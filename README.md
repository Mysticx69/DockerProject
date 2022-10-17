# DockerProject
## 1. Ansible 
Nous utilisons Ansible pour déployer tous les pré-requis, docker et docker compose ansi que l'initialisation de docker swarm (managers + workers) sur notre flotte de serveurs. Ansible nous sera également utile pour joindre X workers à notre docker swarm en déployant le token sur toutes les machines nécessaires.

### IP des membres du cluster de serveurs (AWS EC2): 
 - VM01 (MANAGER) => @IP privé : 172.31.10.132 ; @IP publique : 3.238.156.108 
 - VM02 (WORKER)  => @IP privé : 172.31.11.251 ; @IP publique : 44.192.62.32
 - VM03 (WORKER)  => @IP privé : 172.31.11.32  ;  @IP publique : 3.235.166.153

Dans le dossier ansible du projet se trouve le code nécessaire au déploiement.

Ansible est installé sur une 4ème EC2 (Ansible) et possède la clé SSH privée correspondant à la clé publique du lab présente sur nos 3 EC2 (VM01 - VM03) pour pouvoir les gérer.

Pour simplifier, nous avons peuplé le fichier /etc/hosts sur la machine Ansible de cette façon: 

![test](https://user-images.githubusercontent.com/84475677/196258723-4c4aa76f-c4c1-4fc7-bb18-609e07825713.PNG)

Les noms attribués seront  utilisés dans l'inventory d'ansible

