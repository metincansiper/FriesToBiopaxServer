# pull the reach frext repository
FROM alpine/git as clone-reach-frext
WORKDIR /
RUN git clone https://github.com/metincansiper/reach-frext.git
WORKDIR /reach-frext
RUN git checkout maven-publish

# copy the cloned repository form clone stage and build it as a maven project
FROM maven:3.5.0-jdk-8-alpine as build

ENV GRADLE_VERSION 4.7
ENV GROOVY_VERSION 2.4.15

# download and install gradle
RUN curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip \
 && unzip "gradle.zip" \
 && ln -s "$PWD/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle.zip"
 
# download and install groovy
RUN curl -fl https://dist.apache.org/repos/dist/release/groovy/${GROOVY_VERSION}/distribution/apache-groovy-binary-${GROOVY_VERSION}.zip -o groovy.zip \
 && unzip "groovy.zip" \
 && ln -s "$PWD/groovy-${GROOVY_VERSION}/bin/groovy" /usr/bin/groovy \
 && rm "groovy.zip"

WORKDIR /reach-frext
COPY --from=clone-reach-frext /reach-frext $PWD
RUN gradle -Dmaven.repo.local=/usr/share/maven/ref/repository publishToMavenLocal

WORKDIR /app
COPY . $PWD

RUN mvn -s /usr/share/maven/ref/settings-docker.xml clean install

# deploy the war file created in build stage to tomcat
FROM tomcat:7.0.86-jre8-alpine
ENV TARGET_WAR_NAME=FriesToBiopaxServer
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/${TARGET_WAR_NAME}.war