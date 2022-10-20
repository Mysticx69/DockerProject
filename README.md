# DockerProject

## 1. Terraform

Pour ce projet, nous allons utiliser **6** serveurs sur AWS.

- Un serveur "**dev_tools**" où une application comme  ansible tournera.
- Un serveur "**NFS**" qui servira seulement de serveur de fichiers partagés. C'est dans cette machine que seront montés les volums dockers
- 4 serveurs qui hébergeront l'infrastructure docker et qui seront géres par docker Swarm
  -  1 **Manager** et 3 **workers**. Il sera spécifié dans le manager de ne pas gérer de service mais de seulement s'occuper de son rôle principal : le management des workers.

 Pour les déployer nous utilisons terraform.

Les scripts terraform vont permettre de :
1. **Créer le réseau, c'est à dire:**
  - Un VPC
  - Des subnets publics et privés attachés à ce VPC
  - Une internet gateway pour connecter le VPC à internet et aux services  AWS
  - Une NAT gateway pour permettre au réseau privé de sortir sur internet
  - Des security groups adaptés aux flux qui transitent.
2. **Les 4 EC2 qui feront partis de notre cluster swarm.**

3. Obtenir les outputs des EC2 et des différents subnet qui seront utiles pour Ansible par la suite. Notamment pour les playbooks.

4. Une fois le réseau et les EC2 déployés, le playbook ansible (voir ci après) va se lancer automatiquement à la création, grâce au user-data

**Pour voir les ressources déployées du réseau ainsi que les inputs et outputs, CF README.MD dans le dossier terraform/modules/Networkings (Readme autogénéré via terraform-docs)**

**Pour voir les ressources EC2 deployées ainsi que les inputs et outputs, CF README.MD dans le dossier terraform/modules/Multiple_EC2 (Readme autogénéré via terraform-docs)**
## 2. Ansible
Nous utilisons Ansible pour déployer tous les pré-requis, docker et docker compose ansi que l'initialisation de docker swarm (managers + workers) sur notre flotte de serveurs. Ansible nous sera également utile pour joindre X workers à notre docker swarm en déployant le token sur toutes les machines nécessaires.

### IP des membres du cluster de serveurs (AWS EC2):
 - VM01 (MANAGER) => @IP privé : 10.150.2.10
 - VM02 (WORKER)  => @IP privé : 10.150.2.11
 - VM03 (WORKER)  => @IP privé : 10.150.2.12
 - VM04 (WORKER)  => @IP privé : 10.150.2.13

Dans le dossier ansible du projet se trouve le code nécessaire au déploiement.

Ansible est installé sur une autre EC2 (Dev_Tools) et possède la clé SSH privée correspondant à la clé publique du lab présente sur nos 4 EC2 (VM01 - VM04) pour pouvoir les gérer.

Pour simplifier, nous avons peuplé le fichier /etc/hosts sur la machine dev_tools qui héberge Ansible de cette façon:

![Fichier_hosts](https://user-images.githubusercontent.com/84475677/197055826-5b02dd9a-9607-4675-bbbb-91bd34cd0a37.png)


Les noms attribués seront  utilisés dans l'inventory d'ansible

