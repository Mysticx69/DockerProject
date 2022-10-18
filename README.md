# DockerProject

## 1. Terraform

Pour ce projet, nous allons utiliser 3 serveurs en cluster sur AWS. Pour les déployer nous utilisions terraform.

Les scripts terraform vont permettre de :
1. Créer le réseau c'est à dire: Un VPC; des subnets publics et privés; une internet gateway ; une NAT gateway; un security group par défaut.
2. Les 3 EC2 qui feront parties de notre cluster swarm.
3. Obtenir les outputs des EC2 et des différents subnet qui seront utiles pour Ansible par la suite.

**Pour voir les ressources déployées du réseau ainsi que les inputs et outputs, CF README.MD dans le dossier terraform/modules/Networkings (Readme autogénéré via terraform-docs)**

**Pour voir les ressources EC2 deployées ainsi que les inputs et outputs, CF README.MD dans le dossier terraform/modules/Multiple_EC2 (Readme autogénéré via terraform-docs)**
## 2. Ansible 
Nous utilisons Ansible pour déployer tous les pré-requis, docker et docker compose ansi que l'initialisation de docker swarm (managers + workers) sur notre flotte de serveurs. Ansible nous sera également utile pour joindre X workers à notre docker swarm en déployant le token sur toutes les machines nécessaires.

### IP des membres du cluster de serveurs (AWS EC2): 
 - VM01 (MANAGER) => @IP privé : 172.31.10.132 
 - VM02 (WORKER)  => @IP privé : 172.31.11.251 
 - VM03 (WORKER)  => @IP privé : 172.31.11.32 

Dans le dossier ansible du projet se trouve le code nécessaire au déploiement.

Ansible est installé sur une 4ème EC2 (Ansible) et possède la clé SSH privée correspondant à la clé publique du lab présente sur nos 3 EC2 (VM01 - VM03) pour pouvoir les gérer.

Pour simplifier, nous avons peuplé le fichier /etc/hosts sur la machine Ansible de cette façon: 

![test](https://user-images.githubusercontent.com/84475677/196258723-4c4aa76f-c4c1-4fc7-bb18-609e07825713.PNG)

Les noms attribués seront  utilisés dans l'inventory d'ansible

