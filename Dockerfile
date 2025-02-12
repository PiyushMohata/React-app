FROM node:18 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM httpd:2.4
WORKDIR /var/www/html
COPY --from=build /app/dist/ /var/www/html/
RUN sed -i 's|DocumentRoot "/usr/local/apache2/htdocs"|DocumentRoot "/var/www/html"|' /usr/local/apache2/conf/httpd.conf

EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]