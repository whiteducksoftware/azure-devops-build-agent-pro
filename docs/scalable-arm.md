# Build Agent SCALABLE - ARM jobs

## Docker builds based on ARM images

The Azure DevOps Docker job can be used to build container images based on ARM architecture. Find a sample to get started below:

``` yaml
pool: my-pool

trigger:
  branches:
    include:
    - master
    - main

variables:
  DOCKER_BUILDKIT: 1

stages:
- stage: build
  jobs:
  - job: build
    displayName: build
    steps:
    - task: Docker@2
      displayName: build
      inputs:
        command: build
        repository: my-image
        tags: $(Build.BuildId)
        arguments: --platform linux/arm64
```

This is en example for a corresponding Dockerfile:

``` Dockerfile
FROM --platform=linux/arm64 ubuntu:20.04

RUN echo "hello!"
```

More details on the Azure DevOps Docker job are available [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/build/docker?view=azure-devops).

## Container jobs based on ARM images

The Azure DevOps Container job allows to run ARM-based container images as environment for pipeline tasks. Use this sample to get started:

``` yaml
pool: my-pool

trigger:
  branches:
    include:
    - master
    - main

stages:
- stage: build
  jobs:
  - job: build
    displayName: build
    container:
      image: arm64v8/ubuntu:20.04
      options: --platform linux/arm64/v8
      # endpoint: 'myServiceConnection'
    steps:
    - task: Bash@3
      displayName: echo
      inputs:
        targetType: 'inline'
        script: /usr/bin/uname -a

```

More details on the Azure Devops Container job is available [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/container-phases?view=azure-devops).
