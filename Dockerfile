ARG BUILD_VERSION
ARG MAJOR_PYTHON_VERSION="3.11"
ARG PRE_COMMIT_VERSION="4.0.1"

FROM python:${MAJOR_PYTHON_VERSION}-slim-bullseye AS compile-image
WORKDIR /build
ARG BUILD_VERSION
ARG MAJOR_PYTHON_VERSION
ARG PRE_COMMIT_VERSION
RUN apt-get update
RUN apt-get install -y git libatomic1 libstdc++6 curl gnupg lsb-release
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y docker-ce-cli
RUN pip install --upgrade pip pre-commit==${PRE_COMMIT_VERSION}


FROM python:${MAJOR_PYTHON_VERSION}-slim-bullseye AS build-image
ARG BUILD_VERSION
ARG MAJOR_PYTHON_VERSION
ENV BUILD_VERSION=${BUILD_VERSION}
ENV MAJOR_PYTHON_VERSION=${MAJOR_PYTHON_VERSION}
COPY --from=compile-image /usr/bin/git /usr/bin/git
COPY --from=compile-image /usr/bin/docker /usr/bin/docker
COPY --from=compile-image /usr/lib /usr/lib
COPY --from=compile-image /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu
COPY --from=compile-image /usr/local/bin /usr/local/bin
COPY --from=compile-image /usr/local/lib/python${MAJOR_PYTHON_VERSION}/site-packages /usr/local/lib/python${MAJOR_PYTHON_VERSION}/site-packages
# Make sure scripts via pip are usable
ENV PATH=/usr/local/lib/python${MAJOR_PYTHON_VERSION}/site-packages/:$PATH
