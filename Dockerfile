FROM reinaertvdc/alpine:latest

RUN addgroup -g 101 -S nginx
RUN adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin \
    -G nginx -g nginx nginx

RUN apk add --no-cache nginx \
    nginx-mod-http-headers-more \
    nginx-mod-stream

RUN apk add --no-cache tzdata

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/
RUN chmod 644 /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]