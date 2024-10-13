# Neurodesktop Batch Workflow System

This project integrates a batch workflow system into Neurodesktop, enabling the submission of interactively developed notebooks to a batch processing queue. The solution leverages **Elyra** and **Kubeflow Pipelines**, allowing the submission of interactively developed notebooks to a batch processing queue

## Table of Contents
- [Project Overview](#project-overview)
- [Setup Guide](#setup-guide)
  - [Neurodesktop Setup](#neurodesktop-setup)


## Project Overview

This project integrates a batch workflow system into Neurodesktop by combining Elyra and Kubeflow Pipelines (KFP). It allows Neurodesktop users to develop Jupyter notebooks in Neurodesktop and submit them as batch jobs for execution on a Kubernetes-based system.

Kubeflow Pipelines is a platform for building, deploying, and running machine learning (ML) workflows using Docker containers. It uses Docker containers to run components of a pipeline and enables efficient execution of tasks, often in parallel, by organizing them into a computational directed acyclic graph (DAG). The platform provides features like tracking pipeline runs, managing ML artifacts, and optimizing resource usage. With KFP, pipelines are authored in Python using the KFP SDK, compiled to YAML, and then submitted to a KFP backend, either running on Kubernetes locally or on cloud services. In this project, we will be running kubeflow pipelines on a Minikube kubernetes cluster. In this project, the pipelines will be authoreed using ELyra.

In this setup, Elyra is used to create and manage pipelines. Elyra’s Pipeline Visual Editor in JupyterLab simplifies the process of turning multiple notebooks into batch jobs. In this project, the Dockerfile for Neurodesktop already includes Elyra, making it easy to build these pipelines directly from notebooks.

The Neurodesktop container runs on the same machine as the Minikube Kubernetes cluster that hosts Kubeflow Pipelines. To ensure Neurodesk’s neuroimaging tools are available in the pipelines, CVMFS-CSI is used to expose the necessary modules and tools. A Persistent Volume Claim (PVC) is created within the cluster, allowing these resources to be accessed by the runtime image that executes the Jupyter notebooks. A sidecar container is also set up in the Kubernetes namespace to mount CVMFS, ensuring that the tools are available to the pipeline during execution.

## Prerequistes
- Minikube: Used to deploy Kubeflow Pipelines on a local Kubernetes cluster.
- Docker: Required for running Neurodesktop and base for Minikube.


## Setup Guide

### Neurodesktop Setup

1. **Clone the OjaswinKohli/neurodesktop repository**:
    Clone the Neurodesktop repository by using following command 
    ```bash
    git clone https://github.com/OjaswinKohli/neurodesktop.git
    ```
    After successfully clone the repository. Change into it:
    ```bash
    cd neurodesktop
    ```

2. **Build and Run Neurodesktop using Docker**:
   If you are using Linux, run the following script to build and run Neurodesktop:
    ```bash
    chmod +x ./build_and_run_on_linux.sh 
    ./build_and_run_on_linux.sh 
    ```

   If you are using Windows Subsystem for Linux (WSL), run this script instead:
    ```bash
    chmod +x ./build_and_run.sh 
    ./build_and_run.sh 
    ```

    If you are running it on 

3. **Access Neurodesktop**: After the script finishes, Neurodesktop will be accessible on port 8888. Open the link printed in the terminal using a web browser.
