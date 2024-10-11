FROM uselagoon/php-8.3-cli:latest

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && chmod +x /usr/local/bin/wp

# Add function to .bashrc to run wp-cli with --allow-root
RUN echo 'wp() { /usr/local/bin/wp "$@" --allow-root; }' >>  ~/.bashrc \
    && mkdir -p ~/.wp-cli \
    && echo "path: '/app/web/wp'" > ~/.wp-cli/config.yml

# Lagoon Sync
RUN DOWNLOAD_PATH=$(curl -sL "https://api.github.com/repos/uselagoon/lagoon-sync/releases/latest" | grep "browser_download_url" | cut -d \" -f 4 | grep linux_386) && wget -O /usr/bin/lagoon-sync $DOWNLOAD_PATH && chmod +x /usr/bin/lagoon-sync

COPY composer.* /app/
RUN composer install --no-dev --prefer-dist


COPY . /app

COPY lagoon/wp-entry-point.sh /lagoon/entrypoints/99-wp-entry-point.sh
RUN echo "source /lagoon/entrypoints/99-wp-entry-point.sh" >> /home/.bashrc

ENV WEBROOT=web
ENV PAGER=less
