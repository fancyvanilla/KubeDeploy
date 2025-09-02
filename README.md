# 🚀 Kubernetes Automation on CloudStack  

This repository automates the **provisioning, configuration, and deployment of a Kubernetes cluster** on a private cloud (CloudStack) using **Terraform**, **Ansible**, and a lightweight **Go server**.   

<img width="2048" height="929" alt="image" src="https://github.com/user-attachments/assets/4c8b2a37-6359-4e36-8f98-610c4a54ecd3" />
The diagram above illustrates how infra and config automation pair with a full stack application on Kubernetes (you can find the full application in [this repository](https://github.com/fancyvanilla/ResumeBuilder)).

---
## ⚙️ Components  

- **Terraform** → provisions compute and networking resources in CloudStack.  
- **Ansible** → configures the Kubernetes cluster (infra and/or config).
- **Helm** → deploys and manages Kubernetes applications using charts.  
- **runner.py** → orchestrates Terraform + Ansible to link infra and config.  
- **Go server** → lightweight test application deployed on the cluster.  
- **CI/CD** → builds, tests, and validates the Go server on deployment.  

---

## 🧾 Notes  

- Main directories: `/ansible` (playbooks + roles + variables), `/terraform` (modules + runner.py), `/server` (Go app), `/.cicd` (deploy)
- `deploy_k8s_v2.yaml` is meant for use alongside Terraform-provisioned infra.  
- `autoscale.yaml` used to test autoscaling behavior by adding one worker node on demand .  
- Ansible roles and tasks are modular for reuse and maintainability.
- This repository expects the use of **Vault** to store CloudStack credentials.  
- Terraform modules (`compute`, `network`) are structured for easy extension
- Terraform state is local by default

---

## 📌 Requirements  

- Terraform  
- Ansible  
- Go  
- CloudStack access & credentials
