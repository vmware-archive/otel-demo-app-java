``` 
VMware has ended active development of this project, this repository will no longer be updated.
```

# Tanzu Observability OTel demo app

This is a sample application using [Spring Boot](https://spring.io/projects/spring-boot) with [Jersey](https://eclipse-ee4j.github.io/jersey/) called beachshirts, which makes shirts for the beach.

## Running the application

1. `git clone` this repo and navigate to this dir:
   ```bash
   git clone https://github.com/wavefrontHQ/otel-demo-app-java
   cd otel-demo-app-java
   ```

2. Run `mvn clean install` from the root directory of the project.

3. Using the following commands from the root directory, run all the services:
   ```bash
   java -jar ./shopping/target/shopping-1.0-SNAPSHOT.jar
   java -jar ./styling/target/styling-1.0-SNAPSHOT.jar
   java -jar ./delivery/target/delivery-1.0-SNAPSHOT.jar
   ```

4. View the shopping menus:
   ```bash
   curl http://localhost:50050/shop/menu
   ```

5. Order shirts using HTTP POST request:
   ```bash
   curl http://localhost:50050/shop/order -d '{"styleName": "testStyle1", "quantity": 5}'
   ```
    - You can use `./loadgen.sh [interval]` in the root directory to send a request ordering random shirts
      every `interval` seconds (defaults to every 1 second)

## Adding OpenTelemetry auto-instrumentation

1. Download the OpenTelemetry Java Agent:
   ```bash
   curl -Lo /tmp/opentelemetry-javaagent.jar https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
   ```

2. Run the services, attaching the agent:
   ```bash
   JAVA_AGENT=/tmp/opentelemetry-javaagent.jar
   java -jar -javaagent:$JAVA_AGENT ./shopping/target/shopping-1.0-SNAPSHOT.jar
   java -jar -javaagent:$JAVA_AGENT ./styling/target/styling-1.0-SNAPSHOT.jar
   java -jar -javaagent:$JAVA_AGENT ./delivery/target/delivery-1.0-SNAPSHOT.jar
   ```

3. Run the OpenTelemetry Collector with the `tanzuobservability` exporter configured to point at your wavefront-proxy.

4. Run the wavefront-proxy with a `token` and `server` pointing to your Tanzu Observability endpoint.

5. Order some shirts and see traces appear in the Tanzu Observability UI.
