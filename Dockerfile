# ==========================================
# STAGE 1: Compile the Dynamic Web Project
# ==========================================
FROM openjdk:17-jdk-slim AS build
WORKDIR /app

# 1. Copy your raw project assets into the build environment
COPY src ./src
COPY WebContent ./WebContent

# 2. Compile Java Source files into bytecode classes
RUN mkdir -p target/WEB-INF/classes && \
    javac -d target/WEB-INF/classes $(find src -name "*.java")

# 3. Assemble the deployment structure and compress it into a standard WAR file
RUN mkdir -p target/final && \
    cp -r WebContent/* target/final/ && \
    cp -r target/WEB-INF/classes target/final/WEB-INF/ && \
    cd target/final && \
    jar -cvf ../ROOT.war *

# ==========================================
# STAGE 2: Host the Compiled App on Tomcat
# ==========================================
FROM tomcat:9.0-jdk17-openjdk-slim
WORKDIR /usr/local/tomcat

# Clean default Tomcat webapps to save free-tier resources
RUN rm -rf webapps/*

# Copy the custom assembled war file directly from the compiler stage
COPY --from=build /app/target/ROOT.war webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
