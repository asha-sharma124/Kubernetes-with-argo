# Stage 1: Build with Maven inside Docker
FROM maven:3.6.3-jdk-8 AS build

LABEL maintainer="Chi Dov <d.chiproeng@gmail.com>"

WORKDIR /build
COPY ./pom.xml .

# Copy the entire piggymetrics folder content (parent pom.xml + turbine module)
COPY . .

# Build full multi-module project, skip tests for faster builds
RUN mvn clean package -DskipTests

# Stage 2: Use lightweight Java runtime image
FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

# Copy the built JAR from the 'turbine' module's target folder
COPY --from=build /build/turbine-stream-service/target/turbine-stream-service-0.0.1-SNAPSHOT.jar ./turbine-stream-service.jar

# Run Java app
CMD ["java", "-Xmx200m", "-jar", "turbine-stream-service.jar"]

# Expose the application port
EXPOSE 8989
