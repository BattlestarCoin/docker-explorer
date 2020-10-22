FROM keymetrics/pm2:12-alpine

WORKDIR /home/iquidus

RUN apk --no-cache --virtual builddeps add git python py-pip make gcc g++ krb5-dev bash && \
    adduser -s /bin/ash -S -u 1001 iquidus && \
    git clone https://github.com/iquidus/explorer.git .
	
COPY assets .
COPY docker-entrypoint.sh /entrypoint.sh
	
RUN sed -i 's/\/ext\/getlasttxsajax\/0/\/ext\/getlasttxsajax\/0.00000001/g' /home/iquidus/views/index.pug && \
	npm install --production && \ 
	chown -R iquidus /home/iquidus /entrypoint.sh && \
	chmod +x /entrypoint.sh
    
USER iquidus

EXPOSE 3001

ENTRYPOINT ["/entrypoint.sh"]

CMD [ "pm2-runtime", "start", "ecosystem.config.js" ]