```
version: "3.8"

services:
  db:
    image: postgres:15
    restart: unless-stopped
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonarpassword!#$%
      POSTGRES_DB: sonarqube
    volumes:
      - postgresql_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      timeout: 5s
      retries: 10
      start_period: 30s

  sonarqube:
    image: sonarqube:2025.1-community
    restart: unless-stopped
    depends_on:
      - db
    ports:
      - "9000:9000"
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://172.31.15.58:5432/sonarqube
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonarpassword!#$%
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_logs:/opt/sonarqube/logs
      - sonarqube_extensions:/opt/sonarqube/extensions

volumes:
  sonarqube_data:
  sonarqube_logs:
  sonarqube_extensions:
  postgresql_data:

```


```
sonar.projectKey=unified-whatsapp
sonar.projectName=unified-whatsapp
sonar.projectVersion=1.0
sonar.sources=.
sonar.host.url=http://3.238.220.212/:9000
sonar.token=sqp_f0ae5676ef9ffb17283b2261726225986d8f269a
```


```
# 1. Go to a working temp directory
cd /tmp

# 2. Download the aarch64 zip
wget "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.2.0.5079-linux-aarch64.zip"

# 3. Unzip it
unzip sonar-scanner-cli-7.2.0.5079-linux-aarch64.zip

# 4. Move it somewhere, e.g., /opt
sudo mv sonar-scanner-7.2.0.5079-linux-aarch64 /opt/sonar-scanner-7.2.0

# 5. (Optional) Create a symlink
sudo ln -s /opt/sonar-scanner-7.2.0 /opt/sonar-scanner

# 6. Add to PATH
#    Either export in your shell profile (~/.bashrc or ~/.profile):
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' >> ~/.bashrc
#    Or call directly when needed:
 /opt/sonar-scanner/bin/sonar-scanner --help
```

```
# temporarily (effective until reboot)
sudo sysctl -w vm.max_map_count=524288
sudo sysctl -w fs.file-max=131072
# increase ulimits for current shell (or set in /etc/security/limits.d/...)
ulimit -n 131072
ulimit -u 8192

# to persist across reboots, add to /etc/sysctl.d/99-sonarqube.conf:
echo "vm.max_map_count=524288" | sudo tee /etc/sysctl.d/99-sonarqube.conf
echo "fs.file-max=131072" | sudo tee -a /etc/sysctl.d/99-sonarqube.conf
sudo sysctl --system
```

```
sudo yum install -y java-17-amazon-corretto


# 1. Go to a working temp directory
cd /tmp

# 2. Download the aarch64 zip
wget "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.2.0.5079-linux-aarch64.zip"

# 3. Unzip it
unzip sonar-scanner-cli-7.2.0.5079-linux-aarch64.zip

# 4. Move it somewhere, e.g., /opt
sudo mv sonar-scanner-7.2.0.5079-linux-aarch64 /opt/sonar-scanner-7.2.0

# 5. (Optional) Create a symlink
sudo ln -s /opt/sonar-scanner-7.2.0 /opt/sonar-scanner

# 6. Add to PATH
#    Either export in your shell profile (~/.bashrc or ~/.profile):
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' >> ~/.bashrc
#    Or call directly when needed:
 /opt/sonar-scanner/bin/sonar-scanner --help



vi ~/.bashrc

export JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.aarch64
export PATH=/opt/sonar-scanner-7.2.0/bin:$JAVA_HOME/bin:$PATH


source ~/.bashrc

sonar-scanner -v

```
