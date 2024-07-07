# install mc & docker
sudo apt update
sudo apt install software-properties-common
sudo apt install mc
# docker installation instruction: https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker ${USER}
# docker-compose instsallation instruction: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-ru
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo apt install apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-cache policy docker-ce
sudo apt install docker-ce

# clone project
mkdir app && cd app && mkdir src
git config --global credential.helper store
git clone --branch dev https://code.spherum.io/studio/spherum-backend.git src
cp src/.env.example src/.env
sudo chmod 777 -R src/public
sudo chmod 777 -R src/storage

# !!!! EDIT .env!

# clone laradock
cd ~/app
mkdir docker
git clone https://code.spherum.io/IliyaBlagorodov/spherum-backend-dockers.git docker
cp docker/.env.example docker/.env

# !!!! EDIT .env!

# up
cd docker
docker-compose -p qscrm up -d webserver app mysql phpmyadmin
crontab -e
# add to cron: @reboot /usr/local/bin/docker-compose -f /home/ubuntu/app/docker/docker-compose.yml up nginx php-fpm workspace php-worker

# up app
docker exec -it spherum_workspace_1 bash
composer install
php artisan key:generate
php artisan storage:link
chown -R www-data:www-data /var/www
php artisan migrate
php artisan clear-compiled
php artisan cache:clear
php artisan route:clear
php artisan view:clear
php artisan config:clear

