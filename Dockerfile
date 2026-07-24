# ---------- Étape 1 : compilation ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# On copie d'abord le pom seul : tant qu'il ne change pas,
# Docker réutilise le cache des dépendances au lieu de tout retélécharger
COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY src ./src
RUN mvn -B clean package -DskipTests

# ---------- Étape 2 : image finale ----------
FROM tomcat:9.0-jdk17-temurin

# On vide les webapps par défaut (manager, docs, examples...)
RUN rm -rf /usr/local/tomcat/webapps/*

# ROOT.war => l'application est servie à la racine du conteneur
COPY --from=build /app/target/gestion_g2_spring_mvc.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]