ARG BUILD_VERSION
ARG MAJOR_PYTHON_VERSION="3.11"
ARG PRE_COMMIT_VERSION="3.3.3"

FROM python:${MAJOR_PYTHON_VERSION}-slim-bullseye AS compile-image
WORKDIR /build
ARG BUILD_VERSION
ARG MAJOR_PYTHON_VERSION
ARG PRE_COMMIT_VERSION
RUN apt-get update
RUN apt-get install -y git
RUN pip install --upgrade pip pre-commit==${PRE_COMMIT_VERSION}


FROM python:${MAJOR_PYTHON_VERSION}-slim-bullseye AS build-image
ARG BUILD_VERSION
ARG MAJOR_PYTHON_VERSION
ENV BUILD_VERSION=${BUILD_VERSION}
ENV MAJOR_PYTHON_VERSION=${MAJOR_PYTHON_VERSION}
COPY --from=compile-image /usr/bin/git /usr/bin/git
COPY --from=compile-image /usr/local/bin /usr/local/bin
COPY --from=compile-image /usr/local/lib/python${MAJOR_PYTHON_VERSION}/site-packages /usr/local/lib/python${MAJOR_PYTHON_VERSION}/site-packages
# Make sure scripts via pip are usable
ENV PATH=/usr/local/lib/python${MAJOR_PYTHON_VERSION}/site-packages/:$PATH
