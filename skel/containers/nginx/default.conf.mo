# nginx config
# http://kvz.io/blog/2010/02/24/cakephp-and-nginx/
server {
  listen 80;
  server_name {{PROJECT_NGINX_SERVER_NAME}};

  root /srv/http/source/app/webroot/; ## <-- Your only path reference.
  index index.php;

  # Not found this on disk?
  # Feed to CakePHP for further processing!
  if (!-e $request_filename) {
      rewrite ^/(.+)$ /index.php?url=$1 last;
      break;
  }

  # Pass the PHP scripts to FastCGI server
  location ~ \.php$ {
    fastcgi_pass php:9000;
    fastcgi_index index.php;
    try_files $uri =404;
    fastcgi_intercept_errors on; # to support 404s for PHP files not found
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
  }

  # Static files.
  # Set expire headers, Turn off access log
  location ~* \favicon.ico$ {
      access_log off;
      expires 1d;
      add_header Cache-Control public;
  }
  location ~ ^/(img|cjs|ccss)/ {
      access_log off;
      expires 7d;
      add_header Cache-Control public;
  }

  # Deny access to .htaccess files,
  # git & svn repositories, etc
  location ~ /(\.ht|\.git|\.svn) {
      deny  all;
  }
}

# Redirect alternative domain names.
server {
  listen 80;
  server_name www.{{PROJECT_NGINX_SERVER_NAME}};
  # $scheme will get the http protocol
  # and 301 is best practice for tablet, phone, desktop and seo
  return 301 $scheme://{{PROJECT_NGINX_SERVER_NAME}}$request_uri;
}

# vim:syntax=nginx
