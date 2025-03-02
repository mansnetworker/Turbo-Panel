#!/bin/bash

clear

echo "=========================="
echo "      Turbo Panel        "
echo "=========================="
echo " Automated X-UI Installer"
echo "--------------------------"

echo "Choose an option:"
echo "1) Install"
echo "2) Uninstall"
read -p "Enter your choice (1 or 2): " choice

if [[ "$choice" == "1" ]]; then
    echo "Installing X-UI with Docker..."

    curl -fsSL https://get.docker.com | sh
    sleep 50

    git clone https://github.com/alireza0/x-ui.git
    cd x-ui
    sleep 10

    docker compose up -d
    sleep 20

    mkdir x-ui && cd x-ui
    docker run -itd \
    -p 54321:54321 -p 2052:2052 -p 80:80 \
    -e XRAY_VMESS_AEAD_FORCED=false \
    -v $PWD/db/:/etc/x-ui/ \
    -v $PWD/cert/:/root/cert/ \
    --name x-ui --restart=unless-stopped \
    alireza7/x-ui:latest

    echo "Installation completed successfully!"

elif [[ "$choice" == "2" ]]; then
    echo "Uninstalling X-UI..."

    docker stop x-ui
    docker rm x-ui

    cd ..
    rm -rf x-ui

    echo "X-UI has been removed successfully."

else
    echo "Invalid choice. Please run the script again and select 1 or 2."
fi
