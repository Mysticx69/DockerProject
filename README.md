# DockerProject
## 1. Ansible 
Nous utilisons Ansible pour déployer tous les pré-requis, docker et docker compose sur notre flotte de serveurs. Ansible nous sera également utile pour joindre X workers à notre docker swarm en déployant le token sur toutes les machines nécessaires.

### IP des membres du cluster de serveurs (AWS EC2): 
 - VM01 (MANAGER) => @IP privé : 172.31.10.132 ; @IP publique : 3.238.156.108 
 - VM02 (WORKER)  => @IP privé : 172.31.11.251 ; @IP publique : 44.192.62.32
 - VM03 (WORKER)  => @IP privé : 172.31.11.32  ;  @IP publique : 3.235.166.153

Dans le dossier ansible du projet se trouve le code nécessaire au déploiement.

Ansible est installé sur une 4ème EC2 (VM04) possédant la clé SSH privée correspondant à la clé publique du lab présente sur nos 3 EC2 (VM01 - VM03)

**Commande à executer à la racine du projet :**

`ansible-playbook playbooks/DOCKERPROJECT_PLAYBOOK.yaml -i inventory/DOCKERPROJECT_INVENTORY.yaml `  


