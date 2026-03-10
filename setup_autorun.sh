#!/bin/bash

SCRIPT_DIR="/www/server/nodejs/vhost/scripts"
RUN_SCRIPT="/root/run_all_scripts.sh"

echo "Creating run_all_scripts.sh..."

cat > $RUN_SCRIPT << 'EOF'
#!/bin/bash

SCRIPT_DIR="/www/server/nodejs/vhost/scripts"

for script in $SCRIPT_DIR/*.sh
do
    echo "Running $script"
    bash "$script"
done
EOF

echo "Set execute permission..."
chmod +x $RUN_SCRIPT

echo "Set execute permission for all .sh in scripts folder..."
chmod +x $SCRIPT_DIR/*.sh

echo "Adding crontab @reboot..."

(crontab -l 2>/dev/null | grep -v "$RUN_SCRIPT"; echo "@reboot $RUN_SCRIPT") | crontab -

echo "Done!"
echo "Script will run all .sh files on reboot."
