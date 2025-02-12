FROM node:18 AS build
WORKDIR /app
COPY . . 
RUN npm install && npm run build  

FROM httpd:2.4
WORKDIR /usr/local/apache2/htdocs
COPY --from=build /app/dist/ . 

RUN sed -i 's/Require all denied/Require all granted/' /usr/local/apache2/conf/httpd.conf

EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]