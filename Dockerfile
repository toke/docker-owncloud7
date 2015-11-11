FROM debian:jessie

#ADD . /usr/src/app
#WORKDIR /usr/src/app

# install your application's dependencies
RUN apt-get update && apt-get install -y wget
RUN wget http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_7.0/Release.key
RUN apt-key add - < Release.key  
RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/Debian_7.0/ /' >> /etc/apt/sources.list.d/owncloud.list 
RUN apt-get update && apt-get install -y owncloud

RUN a2enmod ssl
RUN a2ensite default-ssl
RUN a2enmod rewrite


# replace this with your application's default port
EXPOSE 80
EXPOSE 443

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_RUN_DIR   /etc/apache2

CMD ["/usr/sbin/apache2", "-c", "ErrorLog /dev/stdout",  "-DFOREGROUND"]
