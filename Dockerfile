# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
FROM node:14.18.1-alpine3.14 as build-stage
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build
# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.15
COPY --from=build-stage /app/build/ /usr/share/nginx/html
COPY docker-entry.sh docker-entry.sh
RUN chmod +x docker-entry.sh
ENV API_URL "http://localhost:1337"
ENV SOCKET_PATH ""
EXPOSE 80
# Copy the default nginx.conf provided by tiangolo/node-frontend
COPY  ./nginx.conf /etc/nginx/conf.d/default.conf
ENTRYPOINT [ "./docker-entry.sh" ]