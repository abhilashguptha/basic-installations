### This is a Docker Compose File to install Jenkins

```
version: '3.8'

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    restart: unless-stopped
    ports:
      - "8080:8080"   # Jenkins Web UI
      - "50000:50000" # For Jenkins agents
    volumes:
      - jenkins_home:/var/jenkins_home

volumes:
  jenkins_home:
```