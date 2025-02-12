FROM node:18 as build
WORKDIR /app
COPY package*.json ./
COPY . .
RUN npm install && npm run build

FROM httpd:2.4
WORKDIR /var/www/html
COPY --from=build /app/dist/ /var/www/html/
RUN sed -i 's/Require all denied/Require all granted/' /usr/local/apache2/conf/httpd.conf

EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]