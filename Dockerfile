# ---------------------------------------------------------------------------
# Multi-stage build: Maven builds the WAR from pom.xml, Tomcat runs it.
#   docker build -t hello-world-webapp .
#   docker run -d -p 8080:8080 --name hello-world hello-world-webapp
#   -> http://localhost:8080/
# ---------------------------------------------------------------------------

# ---- Stage 1: build the WAR with Maven -------------------------------------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build

# Copy the project (poms + sources) and build.
# Use --build-arg SKIP_TESTS=true to skip unit tests inside the image build.
COPY pom.xml .
COPY server server
COPY webapp webapp
ARG SKIP_TESTS=false
RUN mvn -B -ntp clean package -DskipTests=${SKIP_TESTS}

# ---- Stage 2: run on Tomcat -------------------------------------------------
# Tomcat 9 = javax.servlet (matches the Servlet 4.0 / JSP 2.3 APIs in the pom)
FROM tomcat:9.0-jdk17-temurin

LABEL org.opencontainers.image.title="hello-world-webapp" \
      org.opencontainers.image.description="Maven WAR deployed on Tomcat 9" \
      maintainer="valaxytech@gmail.com"

# Remove the default Tomcat sample apps and deploy our WAR as the root context
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /build/webapp/target/webapp.war /usr/local/tomcat/webapps/ROOT.war

# Run as a non-root user (the official Tomcat image keeps logs/temp/work/webapps writable)
USER 1001

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=3 \
  CMD curl -fsS http://localhost:8080/ > /dev/null || exit 1

CMD ["catalina.sh", "run"]
