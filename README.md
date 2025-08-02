# KPI Project - Hệ thống Đánh giá KPI

Hệ thống quản lý và đánh giá KPI (Key Performance Indicators) được xây dựng với Laravel Backend và Next.js Frontend, sử dụng Docker để deployment.

## 🚀 Tính năng chính

### Backend (Laravel)
- **Quản lý đánh giá:** Tự đánh giá, đánh giá cấp 1, đánh giá cấp 2
- **Quản lý nhân viên:** CRUD nhân viên, import/export
- **Quản lý phòng ban:** Tổ chức cơ cấu phòng ban
- **Quản lý vai trò:** Phân quyền chi tiết theo vai trò
- **Quản lý tiêu chí:** Tùy chỉnh tiêu chí đánh giá
- **Báo cáo & Thống kê:** Dashboard, biểu đồ, xuất báo cáo
- **Real-time notifications:** Socket.io integration
- **Queue system:** Xử lý background jobs
- **Cron jobs:** Tự động hóa tasks

### Frontend (Next.js)
- **Giao diện hiện đại:** Responsive design, Dark/Light mode
- **Real-time updates:** Socket.io client
- **Performance optimized:** Code splitting, lazy loading
- **TypeScript:** Type safety
- **SWR caching:** Optimized API calls

## 🛠 Công nghệ sử dụng

### Backend
- **Framework:** Laravel 12
- **Language:** PHP 8.2
- **Database:** MySQL 8.0
- **Cache/Queue:** Redis
- **Real-time:** Laravel Echo Server
- **File handling:** Spatie Media Library
- **Excel:** Maatwebsite Excel

### Frontend
- **Framework:** Next.js 15 (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS 4
- **UI Components:** Radix UI
- **State Management:** SWR
- **Real-time:** Socket.io Client
- **Charts:** Recharts

### Infrastructure
- **Containerization:** Docker & Docker Compose
- **Web Server:** Nginx
- **Process Manager:** Supervisor
- **Cron:** Automated tasks

## 📋 Yêu cầu hệ thống

- Docker & Docker Compose
- Git
- 8GB RAM (khuyến nghị)
- 10GB disk space

## 🚀 Cài đặt và Chạy

### 1. Clone repositories

```bash
# Clone backend
git clone https://github.com/dat25134/kpi_be.git kpi_be

# Clone frontend
git clone https://github.com/dat25134/kpi_fe.git kpi_fe
```

### 2. Cấu trúc thư mục

```
kpi_project/
├── kpi_be/                 # Laravel Backend
├── kpi_fe/                 # Next.js Frontend
├── docker-compose.yml      # Docker configuration
├── Dockerfile.be           # Backend Dockerfile
├── Dockerfile.fe           # Frontend Dockerfile
├── nginx/                  # Nginx configuration
├── mysql/                  # MySQL initialization
├── env/                    # Environment files
├── cron/                   # Cron jobs
└── README.md
```

### 3. Cấu hình Environment Variables

#### Backend (.env/be.env)
```env
APP_NAME=KPI System
APP_ENV=local
APP_KEY=base64:your-app-key
APP_DEBUG=true
APP_URL=http://localhost:90

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=kpi
DB_USERNAME=kpi_mysql
DB_PASSWORD=secret

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379

BROADCAST_DRIVER=redis
CACHE_DRIVER=redis
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis
SESSION_LIFETIME=120

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"
```

#### Frontend (.env/fe.env)
```env
NEXT_PUBLIC_API_URL=http://localhost:90/api
NEXT_PUBLIC_SOCKET_URL=http://localhost:6001
```

### 4. Build và chạy với Docker

```bash
# Build tất cả services
docker-compose build

# Chạy riêng service backend trước để tạo app key
docker-compose up -d mysql redis
docker-compose up -d be

# Tạo Laravel app key
docker-compose exec be php artisan key:generate

# Dừng tất cả services
docker-compose down

# Chạy lại tất cả services
docker-compose up -d

# Hoặc chạy từng service theo thứ tự
docker-compose up -d mysql redis
docker-compose up -d be
docker-compose up -d fe echo queue cron
docker-compose up -d nginx
```

### 5. Khởi tạo database

```bash
# Chạy migrations
docker-compose exec be php artisan migrate

# Chạy seeders
docker-compose exec be php artisan db:seed

# Tạo storage link
docker-compose exec be php artisan storage:link
```

### 6. Kiểm tra services

```bash
# Xem status tất cả containers
docker-compose ps

# Xem logs
docker-compose logs -f be
docker-compose logs -f fe
docker-compose logs -f nginx
```

## 🌐 Truy cập ứng dụng

- **Frontend:** http://localhost:8198
- **Backend API:** http://localhost:90
- **Socket.io:** http://localhost:6001
- **MySQL:** localhost:3306
- **Redis:** localhost:6379

## 📊 Services Architecture

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Nginx     │    │   Frontend  │    │   Backend   │
│  (Reverse   │    │  (Next.js)  │    │  (Laravel)  │
│   Proxy)    │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
              ┌─────────────┼─────────────┐
              │             │             │
         ┌─────────┐  ┌─────────┐  ┌─────────┐
         │  MySQL  │  │  Redis  │  │  Echo   │
         │         │  │         │  │ Server  │
         └─────────┘  └─────────┘  └─────────┘
```

## 🔧 Development

### Chạy development mode

```bash
# Frontend development
cd kpi_fe
npm install
npm run dev

# Backend development
cd kpi_be
composer install
php artisan serve
```

### Useful commands

```bash
# Xem logs real-time
docker-compose logs -f

# Restart service
docker-compose restart be

# Rebuild service
docker-compose build be
docker-compose up -d be

# Execute command trong container
docker-compose exec be php artisan migrate
docker-compose exec be composer install

# Xem logs của service cụ thể
docker-compose logs -f be
docker-compose logs -f fe
docker-compose logs -f nginx
```

## 🐛 Troubleshooting

### Lỗi thường gặp

1. **Port conflicts:**
```bash
# Kiểm tra ports đang sử dụng
netstat -tulpn | grep :90
netstat -tulpn | grep :8198

# Kill process nếu cần
sudo kill -9 <PID>
```

2. **Container không start:**
```bash
# Xem logs chi tiết
docker-compose logs be

# Rebuild container
docker-compose build --no-cache be
docker-compose up -d be
```

3. **Database connection error:**
```bash
# Kiểm tra MySQL container
docker-compose logs mysql

# Restart MySQL
docker-compose restart mysql
```

4. **Permission issues:**
```bash
# Fix permissions
sudo chown -R $USER:$USER kpi_be/storage
sudo chown -R $USER:$USER kpi_be/bootstrap/cache
```

5. **Composer dependencies:**
```bash
# Clear composer cache
docker-compose exec be composer clear-cache

# Reinstall dependencies
docker-compose exec be composer install --no-cache
```

6. **Laravel app key error:**
```bash
# Nếu gặp lỗi "No application encryption key has been specified"
docker-compose up -d mysql redis
docker-compose up -d be
docker-compose exec be php artisan key:generate
docker-compose down
docker-compose up -d
```

### Performance optimization

1. **Tăng memory cho containers:**
```yaml
# Trong docker-compose.yml
services:
  be:
    deploy:
      resources:
        limits:
          memory: 2G
```

2. **Enable OPcache:**
```dockerfile
# Trong Dockerfile.be
RUN docker-php-ext-install opcache
```

## 📁 Project Structure

```
kpi_project/
├── kpi_be/                    # Laravel Backend
│   ├── app/                   # Application logic
│   ├── config/                # Configuration files
│   ├── database/              # Migrations & seeders
│   ├── routes/                # API routes
│   └── storage/               # File storage
├── kpi_fe/                    # Next.js Frontend
│   ├── src/                   # Source code
│   │   ├── app/              # App router pages
│   │   ├── components/       # React components
│   │   ├── hooks/            # Custom hooks
│   │   └── services/         # API services
│   └── public/               # Static files
├── nginx/                     # Nginx configuration
├── mysql/                     # MySQL initialization
├── env/                       # Environment files
├── cron/                      # Cron jobs
└── docker-compose.yml         # Docker orchestration
```

## 🔐 Security

- **Environment variables:** Không commit sensitive data
- **Database:** Sử dụng strong passwords
- **SSL/TLS:** Enable HTTPS cho production
- **Firewall:** Configure network security
- **Updates:** Regular security updates

## 🚀 Deployment

### Production checklist

1. **Environment variables:**
   - Set `APP_ENV=production`
   - Configure production database
   - Set strong passwords

2. **SSL/TLS:**
   - Configure SSL certificates
   - Update nginx config

3. **Monitoring:**
   - Setup log aggregation
   - Configure health checks
   - Setup backup strategy

4. **Performance:**
   - Enable OPcache
   - Configure Redis persistence
   - Setup CDN for static files

## 📞 Support

- **Issues:** Tạo issue trên GitHub repository
- **Documentation:** Xem README của từng repository
- **Team:** Liên hệ team phát triển

## 📄 License

Dự án này được phát triển cho mục đích nội bộ.

---

**Happy coding! 🚀** 