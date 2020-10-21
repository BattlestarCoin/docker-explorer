FROM keymetrics/pm2:12-alpine

WORKDIR /home/iquidus

RUN apk --no-cache --virtual builddeps add git python py-pip make gcc g++ krb5-dev && \
    adduser -s /bin/ash -S -u 1001 iquidus && \
    git clone https://github.com/iquidus/explorer.git .
	
COPY assets .	
	
RUN sed -i 's/\/ext\/getlasttxsajax\/0/\/ext\/getlasttxsajax\/0.00000001/g' /home/iquidus/views/index.pug && \
	npm install --production && \ 
	chown -R iquidus /home/iquidus
    
USER iquidus

EXPOSE 3001

CMD [ "pm2-runtime", "start", "ecosystem.config.js" ]