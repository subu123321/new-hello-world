# maven-project

Multi-module Maven project:

| Module   | Packaging | Purpose                               |
|----------|-----------|---------------------------------------|
| `server` | jar       | Business logic (`Greeter`) + unit tests |
| `webapp` | war       | JSP web app, uses `server`            |

## Requirements
JDK 17+ and Maven 3.6.3+ (or just Docker).

## Build the WAR
```bash
mvn -B clean package
# -> webapp/target/webapp.war
```

## Build and run with Docker
```bash
docker build -t hello-world-webapp .          # builds WAR inside Docker, then packages it on Tomcat 9
docker run -d -p 8080:8080 --name hello-world hello-world-webapp
# open http://localhost:8080/
```
CI pipelines that already ran Maven can use `docker build -f Dockerfile.ci ...` instead (see `Jenkinsfile`, `azure-pipelines.yml`).
