# Guide: Fix Node.js/React Web Apps Not Running After aaPanel Reboot

[🇻🇳 Xem phiên bản Tiếng Việt bên dưới](#hướng-dẫn-sửa-lỗi-nodejsreact-web-không-chạy-sau-khi-khởi-động-lại-aapanel)

## ⚠️ The Problem
When using the **Node.js Project Manager** on aaPanel to run React/Next.js/Node.js websites, a very common issue is that **these projects do not start automatically after the server reboots**. Although aaPanel generates startup scripts in the `/www/server/nodejs/vhost/scripts` directory, the system does not trigger them automatically on boot.

## 💡 The Solution
To fix this, we will set up a cronjob that runs at `@reboot` to automatically execute all the startup scripts for your Node.js projects.

Simply run the following 3 commands in your SSH terminal (as root):

```bash
wget -O setup_autorun.sh https://raw.githubusercontent.com/duyvo26/aapanel/main/setup_autorun.sh
chmod +x setup_autorun.sh
./setup_autorun.sh
```

## 🛠️ How does this script work?
When you run the script above, it performs the following steps:
1. Creates a script named `run_all_scripts.sh` in the `/root/` directory.
2. The `run_all_scripts.sh` script automatically finds and executes all `.sh` files located in `/www/server/nodejs/vhost/scripts` (This is where aaPanel stores the startup commands for Node.js/PM2 for each project).
3. Grants execution permissions (`chmod +x`) to all these scripts.
4. Automatically adds a line to the **crontab** (`@reboot /root/run_all_scripts.sh`), so that every time the server reboots, the cronjob will call this script and bring all your Node/React services back online.

Once installed, you can try restarting your server (`reboot`) and check if your React websites automatically come back up successfully!

---

# Hướng Dẫn Sửa Lỗi Node.js/React Web Không Chạy Sau Khi Khởi Động Lại aaPanel

## ⚠️ Vấn đề
Khi sử dụng **Node.js Project Manager** trên aaPanel để chạy các website React/Next.js/Node.js, một lỗi rất phổ biến là **các project này không tự động chạy lại sau khi server khởi động lại (reboot)**. Mặc dù aaPanel có tạo ra các script khởi động trong thư mục `/www/server/nodejs/vhost/scripts`, nhưng hệ thống lại không tự động kích hoạt chúng khi boot.

## 💡 Giải pháp
Để khắc phục tình trạng này, chúng ta sẽ thiết lập một cronjob chạy ở chế độ `@reboot` để tự động thực thi tất cả các file script khởi động của Node.js project.

Chỉ cần chạy 3 dòng lệnh sau trên SSH terminal của bạn (với quyền root):

```bash
wget -O setup_autorun.sh https://raw.githubusercontent.com/duyvo26/aapanel/main/setup_autorun.sh
chmod +x setup_autorun.sh
./setup_autorun.sh
```

## 🛠️ Script này hoạt động như thế nào?
Khi bạn chạy script trên, nó sẽ thực hiện các bước sau:
1. Tạo một script có tên là `run_all_scripts.sh` tại thư mục `/root/`.
2. Nhiệm vụ của `run_all_scripts.sh` là tự động tìm và chạy tất cả các file có đuôi `.sh` nằm trong thư mục `/www/server/nodejs/vhost/scripts` (Đây là nơi aaPanel lưu các lệnh khởi động Node.js/PM2 cho từng project).
3. Cấp quyền thực thi (`chmod +x`) cho tất cả các script.
4. Tự động thêm một dòng vào **crontab** (`@reboot /root/run_all_scripts.sh`) để mỗi khi server khởi động lại, cronjob sẽ gọi script này và bật lại toàn bộ các dịch vụ Node/React của bạn.

Sau khi cài đặt xong, bạn có thể thử khởi động lại server (`reboot`) và kiểm tra xem các website React đã tự động lên lại thành công hay chưa nhé!
