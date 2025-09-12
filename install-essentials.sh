### Essential Installations ###
#############################
## 1. Docker ###
## 2. Git ###
## 3. Make ### 
## 4. Curl ###
## 5. wget ###
## 6. ###
## 7. ###

#!/bin/bash
set -e

# --- Update system ---
sudo dnf update -y

# --- Install Docker ---
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# --- Install Git ---
sudo dnf install -y git

# --- Install make ---
sudo dnf install -y make

# --- Install Curl ---
sudo dnf install -y curl

# --- Install Wget ---
sudo dnf install -y wget

# --- Install telnet ---
sudo dnf install -y telnet

# --- Install Netcat (nmap-ncat) ---
sudo dnf install -y nmap-ncat

# --- Install 
# --- Check All Installations ---
git --version
docker --version
make --version
curl --version | head -n 1
wget --version | head -n 1
nc -h | head -n 5