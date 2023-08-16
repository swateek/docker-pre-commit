ARG BUILD_VERSION
ARG PYTHON_VERSION="3.11"

FROM python:${PYTHON_VERSION}-slim-bullseye AS compile-image
WORKDIR /build
ARG BUILD_VERSION
RUN apt-get update
RUN apt-get install -y git pre-commit

FROM python:${PYTHON_VERSION}-slim-bullseye AS build-image
ARG BUILD_VERSION
ENV BUILD_VERSION=${BUILD_VERSION}
COPY --from=compile-image /usr/bin/ /usr/bin/
COPY --from=compile-image /usr/lib/ /usr/lib/
