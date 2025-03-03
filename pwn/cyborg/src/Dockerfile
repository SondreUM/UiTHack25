# Disclaimer: This container is intentianally vulnerable and SHOULD NOT be used as a reference implementation.

# Use the official PHP Apache base image
# https://github.com/docker-library/php/blob/d9293b8297781e4e5d81a580df61acc71649eec3/8.4/bookworm/apache/Dockerfile
FROM php:8.4-apache

# Lock down PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Set recommended PHP.ini settings
RUN echo "memory_limit = 256M" >> $PHP_INI_DIR/php.ini \
    && echo "upload_max_filesize = 64M" >> $PHP_INI_DIR/php.ini \
    && echo "post_max_size = 64M" >> $PHP_INI_DIR/php.ini \
    && echo "max_execution_time = 600" >> $PHP_INI_DIR/php.ini \
    && echo "date.timezone = UTC" >> $PHP_INI_DIR/php.ini \
    # conveniently "forget" to disable some really dangerous functions
    # exec,passthru,shell_exec,system,posix_getpwuid
    && echo "disable_functions = proc_close,proc_open,dl,popen,show_source,posix_kill,posix_mkfifo,posix_setpgid,posix_setsid,posix_setuid,posix_setgid,posix_seteuid,posix_setegid,posix_uname" >> $PHP_INI_DIR/conf.d/security.ini


RUN sed -i 's/allow_url_fopen = On/allow_url_fopen = Off/' ${PHP_INI_DIR}/php.ini \
    && sed -i 's/allow_url_include = On/allow_url_include = Off/' ${PHP_INI_DIR}/php.ini
RUN sed -i 's/ServerName localhost/ServerName uithack-2.td.org.uit.no/' "${APACHE_CONFDIR}/apache2.conf"

# Allow and configure indexes
RUN sed -i 's/Options -Indexes/Options +Indexes/' $APACHE_CONFDIR/conf-available/docker-php.conf
RUN echo "IndexOptions FancyIndexing" >> $APACHE_CONFDIR/conf-available/docker-php.conf \
    && echo "IndexOptions ShowForbidden" >> $APACHE_CONFDIR/conf-available/docker-php.conf \
    && echo "IndexOptions FoldersFirst" >> $APACHE_CONFDIR/conf-available/docker-php.conf

# Dissallow access to flag.txt
RUN { \
    echo "<Files \"flag.txt\">"; \
    echo "    Require all denied"; \
    echo "</Files>"; \
    } | tee -a "$APACHE_CONFDIR/conf-available/docker-php.conf"

# Lock down the system
RUN apt-get update \
    && apt-get remove -y wget curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
# Should already be set by the base image
# Create challenge environment
RUN mkdir -p /var/www/html /var/www/admin
WORKDIR /var/www

RUN cp /etc/os-release /var/www/admin/ \
    && cp ${APACHE_CONFDIR}/conf-available/docker-php.conf /var/www/admin/ \
    && cp ${APACHE_CONFDIR}/apache2.conf /var/www/admin/

# Copy application files
COPY www /var/www
COPY uithack.conf /var/www/admin/
RUN cd html && ln -s -d ../admin \
    && ln -s ../admin/flag.txt \
    # change creation time of web shell to original time
    && touch -t 201306061201 /var/www/admin/323d09c08a72717bbec71f172e5f6532.php


# Set permissions, prevent players from modifying/removing the files
RUN chown -R root:root /var/www \
    && chmod -R 1755 /var/www


# Configure Apache
COPY uithack.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf


# Expose port 80
EXPOSE 80

USER www-data


# Inherit the CMD from the base image
# CMD ["apache2-foreground"]

# docker build -t cyborg .
# docker run -p 8080:80 --cap-drop=ALL --security-opt=no-new-privileges --rm cyborg