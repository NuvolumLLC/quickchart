FROM node:12

ENV NODE_ENV production
COPY . /src
RUN cd /src &&  npm install

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV PORT=80
EXPOSE 80

RUN ["chmod", "+x", "/src/start.sh"]
CMD ["/src/start.sh"]
