# Docker Pre-Commit

pre-commit is a git hook useful for identifying simple issues before submission to code review. Use this docker image to verify if pre-commit hook has been run via CI/CD pipelines.

## Getting Started

1. Setting up development environment

```bash
    pre-commit install
```

2. Other helpful commands

```bash

# Build the docker locally
docker build -t docker-pre-commit .

# Run the docker locally, get into docker
docker run --name docker-pre-commit --rm -ti docker-pre-commit bash

# Check versions available
apt-cache policy pre-commit

```

## Usage

1. On GitLab CI

```yaml
job-validate-precommit-hook:
  stage: validate
  image: swateekj/verify-pre-commit:latest
  script: |
    set -x
    status=0
    pre-commit run --all-files || status=$?
    if [[ $status -ne 0 ]]; then
      # cat /root/.cache/pre-commit/pre-commit.log
      exit 1 # fail the job
    fi
  rules:
    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
```
