FROM google/dart

WORKDIR /app
ADD pubspec.yaml /app/
ADD pubspec.lock /app/
RUN pub get
ADD . /app
RUN pub get

CMD []
ENTRYPOINT ["/usr/bin/dart", "/app/bin/main.dart"]
EXPOSE 3000

