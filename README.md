#### Stack
`PHP 8.1`, `Nginx`, `Supervisor`, `Cron`, `Ubuntu 22.04`

#### Web root
`/var/www/html`

#### Cron setup
Add your crontab on the file `config/crontabs`

#### Enable / disable / configure services
Check `config/supervisord.conf` file

#### Load custom nginx config file
Mount files to directory `/etc/nginx/conf.d`

#### Load custom php ini
Mount files to directory `/etc/php/8.1/fpm/conf.d`

#### Loaded php8.1 extension:

[PHP Modules] 
`bcmath` `calendar` `Core` `ctype` `curl` `date` `dom` `exif` `FFI` `fileinfo` `filter` `ftp` `gd` `gettext` `hash` `iconv` `intl` `json` `libxml` `mbstring` `mysqli` `mysqlnd` `openssl` `pcntl` `pcre` `PDO` `pdo_mysql` `Phar` `posix` `readline` `Reflection` `session` `shmop` `SimpleXML` `soap` `sockets` `sodium` `SPL` `standard` `sysvmsg` `sysvsem` `sysvshm` `tokenizer` `xml` `xmlreader` `xmlwriter` `xsl` `Zend OPcache` `zip` `zlib`

[Zend Modules]
`Zend OPcache`

#### Supported commands
Text editor: `vim.tiny`