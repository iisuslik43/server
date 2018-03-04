FROM openjdk:8-jdk

EXPOSE 4567


# Gradle
ENV GRADLE_VERSION 3.3
ENV GRADLE_SHA c58650c278d8cf0696cab65108ae3c8d95eea9c1938e0eb8b997095d5ca9a292

RUN cd /usr/lib \
 && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
 && echo "$GRADLE_SHA gradle-bin.zip" | sha256sum -c - \
 && unzip "gradle-bin.zip" \
 && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-bin.zip"

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

RUN gradle -version

ENV VERSION 1.2.30

ENV KOTLIN_COMPILER_URL https://github.com/JetBrains/kotlin/releases/download/v${VERSION}/kotlin-compiler-${VERSION}.zip

RUN wget $KOTLIN_COMPILER_URL -O /tmp/a.zip && \
    unzip /tmp/a.zip -d /opt && \
    rm /tmp/a.zip

ENV PATH $PATH:/opt/kotlinc/bin

RUN kotlinc -version
WORKDIR /usr/bin/app
ADD . .
RUN gradle build
CMD ["gradle", "run"]

#FOR /f "tokens=*" %i IN ('docker ps -a -q') DO docker rm %i

