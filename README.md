#  Disaster Recovery Automation (Java + Docker + Kubernetes + Jenkins)

##  Project Overview

This project demonstrates an **automated disaster recovery system** using:

- Spring Boot (Java)
- Docker (Containerization)
- Kubernetes (Orchestration)
- Jenkins (CI/CD Pipeline)

 The system automatically detects failures and ensures the application is **always running (self-healing)**.

---

##  Key Features

* Automated Build & Deployment using Jenkins  
* Dockerized Spring Boot Application  
* Kubernetes Self-Healing (Auto Recovery)  
* Health Monitoring using Actuator  
* Automated Recovery Simulation  
* CI/CD Pipeline Integration  

##  Architecture
##  Project Structure
disaster-recovery-automation-java/
│
├── app/ # Spring Boot Application
│ ├── src/main/java/com/dr/app/
│ │ ├── controller/
│ │ │ ├── HomeController.java
│ │ │ └── TestController.java
│ │ ├── health/
│ │ │ └── CustomHealthIndicator.java
│ │ └── DrApplication.java
│ │
│ ├── src/main/resources/
│ │ ├── application.yml
│ │ └── static/index.html
│ │
│ ├── Dockerfile
│ ├── pom.xml
│ └── mvnw
│
├── deployment.yaml # Kubernetes Deployment
├── service.yaml # Kubernetes Service
├── run-dr-system.sh # Automation Script
└── scripts/
├── backup.sh
├── recover.sh
└── health-check.sh


---

##  Technologies Used

| Tool        | Purpose |
|------------|--------|
| Java (Spring Boot) | Backend Application |
| Docker     | Containerization |
| Kubernetes | Deployment & Recovery |
| Jenkins    | CI/CD Automation |
| Actuator   | Health Monitoring |

---

##  How It Works

### 🔹 Step 1: Build Application
- Jenkins builds the Spring Boot app using Maven

### 🔹 Step 2: Docker Image Creation
- App is packaged into a Docker image

### 🔹 Step 3: Kubernetes Deployment
- Deployment.yaml creates pods
- Service.yaml exposes the app

### 🔹 Step 4: Disaster Recovery
- If a pod fails → Kubernetes **automatically creates a new one**

---

##  Self-Healing Demo

```bash
kubectl get pods
kubectl delete pod <pod-name>
