FROM maven:3.8.5-openjdk-17-slim AS build
RUN apt update && apt install -y git
RUN git clone https://github.com/mayurmwagh/onlinebookstore.git /app
WORKDIR /app
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk11-openjdk-slim AS runtime
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/onlinebookstore.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
