FROM openjdk:8-jre-alpine 
EXPOSE 8090
COPY ./target/java-maven-app-3.1-SNAPSHOT.jar .
WORKDIR .
ENTRYPOINT [ "java","-jar","java-maven-app-3.1-SNAPSHOT.jar" ]