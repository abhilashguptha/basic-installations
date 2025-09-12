### nginx Configuration ###

#!/bin/bash
set -e

# --- Update system ---
sudo dnf update -y

# --- Install Nginx ---
sudo dnf install -y nginx

# --- Enable & Start Nginx ---
sudo systemctl enable nginx
sudo systemctl start nginx

# --- Backup default config ---
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup.$(date +%F-%H%M)

# --- Write new minimal nginx.conf ---
cat <<'EOF' | sudo tee /etc/nginx/nginx.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log warn;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    keepalive_timeout 65;

    access_log  /var/log/nginx/access.log;

    server {
        listen       80;
        server_name  _;

        root   /usr/share/nginx/html;
        index  index.html index.htm;

        location / {
            try_files $uri $uri/ =404;
        }
    }
}
EOF

# --- Create website root directory ---
sudo mkdir -p /usr/share/nginx/html
sudo chmod 755 /usr/share/nginx/html

# --- Add sample index.html ---
echo "<!DOCTYPE html>
<html>
<head><title>Nginx on EC2</title></head>
<body>
<h1>Hello from Nginx 🚀</h1>
<p>Deployed on Amazon Linux 2023</p>
</body>
</html>" | sudo tee /usr/share/nginx/html/index.html

# --- Set correct permissions for logs ---
sudo mkdir -p /var/log/nginx
sudo touch /var/log/nginx/error.log /var/log/nginx/access.log
sudo chown -R nginx:nginx /var/log/nginx
sudo chmod 640 /var/log/nginx/*.log || true

# --- Test and reload nginx ---
sudo nginx -t
sudo systemctl restart nginx

echo "✅ Nginx installation and setup complete!"