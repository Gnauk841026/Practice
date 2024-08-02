#!/bin/bash
sudo apt update
sudo apt install nginx --yes 
sudo echo "<h1>hello terraform</h1>" > /var/www/html/index.nginx-debian.html
sudo systemctl start nginx