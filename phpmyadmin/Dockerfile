FROM phpmyadmin/phpmyadmin

LABEL maintainer="Ilya Blagorodov <blagorodov@gmail.com>"

# Add volume for sessions to allow session persistence
VOLUME /sessions

# We expose phpMyAdmin on port 80
EXPOSE 80

ADD boodark /var/www/html/themes/boodark
ADD darkwolf /var/www/html/themes/darkwolf
