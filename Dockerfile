FROM forthecommunity/flutter:3.44.4 AS build
WORKDIR /app
COPY flutter_application_1/ ./
RUN flutter pub get
RUN flutter build web --release

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 10000
CMD ["nginx", "-g", "daemon off;"]
