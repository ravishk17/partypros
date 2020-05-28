FROM node:alpine as builder

WORKDIR '/app'

COPY package.json ./
RUN npm install

COPY ./ ./

RUN npm run build


FROM nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]