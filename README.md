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

### Architecture code terraform
``` bash
.
|-- modules
|   |-- Multiple_EC2
|   |   |-- README.md
|   |   |-- main.tf
|   |   |-- output.tf
|   |   |-- provider.tf
|   |   `-- variables.tf
|   `-- Networking
|       |-- README.md
|       |-- main.tf
|       |-- output.tf
|       |-- provider.tf
|       `-- variables.tf
`-- production-env
    |-- backend.tf
    |-- main.tf
    |-- output.tf
    |-- output.txt
    |-- provider.tf
    `-- scripts
        `-- Ansible.sh

5 directories, 16 files
```


**Pour voir les ressources déployées du réseau ainsi que les inputs et outputs, CF README.MD dans le dossier terraform/modules/Networkings (Readme autogénéré via terraform-docs)**

**Pour voir les ressources EC2 deployées ainsi que les inputs et outputs, CF README.MD dans le dossier terraform/modules/Multiple_EC2 (Readme autogénéré via terraform-docs)**
## 2. Ansible
Nous utilisons Ansible pour déployer tous les pré-requis, docker et docker compose ansi que l'initialisation de docker swarm (managers + workers) sur notre flotte de serveurs. Ansible nous sera également utile pour joindre X workers à notre docker swarm en déployant le token sur toutes les machines nécessaires.

### IP des membres du cluster de serveurs (AWS EC2):
 - VM01 (MANAGER) => @IP privé : `10.150.2.10`
 - VM02 (WORKER)  => @IP privé : `10.150.2.11`
 - VM03 (WORKER)  => @IP privé : `10.150.2.12`
 - VM04 (WORKER)  => @IP privé : `10.150.2.13`

### IP des autres serveurs (AWS EC2):
- Dev_Tools => @ip privé: `10.150.2.14` ; @ip public : `52.86.150.152`
  - Dev_Tools a une EIP pour plus de facilité
- NAS =>  @ip privé: `10.150.2.15`


Dans le dossier ansible du projet se trouve le code nécessaire au déploiement.

Ansible est installé sur une autre EC2 (Dev_Tools) et possède la clé SSH privée correspondant à la clé publique du lab présente sur nos 4 EC2 (VM01 - VM04) pour pouvoir les gérer.

Pour simplifier, nous avons peuplé le fichier /etc/hosts sur la machine dev_tools qui héberge Ansible de cette façon:

![Fichier_hosts](https://user-images.githubusercontent.com/84475677/197055826-5b02dd9a-9607-4675-bbbb-91bd34cd0a37.png)


Les noms attribués seront  utilisés dans l'inventory d'ansible


Le code source Ansible se trouve dans le dossier Ansible.

### Architecture code ansible
```bash
.
|-- ansible.cfg
|-- inventories
|   `-- production
|       |-- group_vars
|       |   |-- all
|       |   |   `-- all.yml
|       |   |-- docker-nodes
|       |   |   `-- all.yml
|       |   |-- swarm-managers
|       |   |   `-- all.yml
|       |   `-- swarm-workers
|       |       `-- all.yaml
|       `-- hosts
`-- playbooks
    |-- delete-swarm.yaml
    |-- deploy-swarm.yaml
    `-- roles
        |-- docker-installation
        |   `-- tasks
        |       `-- main.yaml
        |-- docker-swarm-add-worker
        |   `-- tasks
        |       `-- main.yaml
        |-- docker-swarm-init
        |   `-- tasks
        |       `-- main.yaml
        |-- docker-swarm-leave
        |   `-- main.yaml
        `-- install-modules
            `-- tasks
                `-- main.yaml

18 directories, 13 files
```

**À ce stade là et en une seule commande, l'infrastructure réseau ainsi que tous les serveurs sont déployés et sont en cluster swarm.**

## 3. Python

Nous utilisons python pour deux choses :
1. Pour fetch l'API du grand lyon est obtenir un jeu de données en json (des velov de Lyon) puis pour publish à notre broker Mosquitto
2. Pour subscribe à notre broker Mosquitto et parser le jeu de donnée selon ce que l'on souhaite garder + la mise en forme que l'on souhaite et pour finir : Envoyer ces données à notre BDD influxDB sur lequel un grafana sera greffé

### Architecture

```bash
└── python
    └── scripts
        ├── fetch.py
        ├── parse.py
        ├── pubclient1.py
        └── subscribe.py

22 directories, 29 files
```


## 4. Docker

Concernant docker, nous avons donc un cluster swarm de 4 membres (1 manager, 3 workers).

Nous avons créé un docker compose qui déploie tous les services dans une stack, géré par le swarm.

**Les services:**

- BrokerMQTT (Mosquitto)
- publishMQTT (qui fetch l'api du grand lyon et publie sur brokerMQTT => topic = DATA)
- subscribeMQTT (qui souscris au brokerMQTT sur le même topic)
- Une BDD influxDB qui recevra les données (station velov)
- Un grafana pour visualiser les données
- Un visualizer swarm

Un volume NFS a également été monté sur un serveur NAS distant.

Au final une seule commande `docker stack deploy -c docker-compose.yaml nom_stack` permet de déployer tous nos services docker dans une stack gérée par swarm

**Une EIP est présente dans AWS sur notre node manager: `3.215.3.153`. C'est cette IP public qu'il faut utiliser pour accéder à n'importe quel service déployé.**
- https://3.215.3.153:9443 (portainer.io)
- http://3.215.3.153:8080 (visualizer)
- http://3.215.3.153:3000 (Grafana)
- http://3.215.3.153:8086 (influxdb)


### Architecture


```bash
.
├── docker-compose.yaml
├── dockerfiles
│   ├── publish
│   │   ├── Dockerfile
│   │   ├── mosquitto
│   │   │   └── config
│   │   │       └── mosquitto.conf
│   │   ├── python
│   │   │   └── scripts
│   │   │       ├── fetch.py
│   │   │       ├── parse.py
│   │   │       ├── pubclient1.py
│   │   │       └── subscribe.py
│   │   └── requirements.txt
│   └── subscribe
│       ├── Dockerfile
│       ├── mosquitto
│       │   └── config
│       │       └── mosquitto.conf
│       ├── python
│       │   └── scripts
│       │       ├── fetch.py
│       │       ├── parse.py
│       │       ├── pubclient1.py
│       │       ├── sub.py
│       │       ├── subscribe.py
│       │       └── subscribe_influxdb.py
│       └── requirements.txt
├── grafana
│   └── etc
│       ├── grafana.ini
│       └── provisioning
│           ├── dashboards
│           ├── datasources
│           │   ├── datasource.yaml
│           │   └── datasource.yaml.template
│           └── notifiers
├── grafana.env
├── influx2.env
├── mosquitto
│   ├── config
│   │   └── mosquitto.conf
│   └── log
│       └── mosquitto.log
├── provision.sh
└── python
    └── scripts
        ├── fetch.py
        ├── parse.py
        ├── pubclient1.py
        └── subscribe.py

22 directories, 29 files

```

### Annexe
1. Architecture complète

![](https://user-images.githubusercontent.com/84475677/197494138-7ba8a690-d897-4ec1-bdb8-ca15f656482c.jpg)



2. Docker Vizualiser

![Viz](https://user-images.githubusercontent.com/84475677/197485836-61c798a3-4b65-46e0-9622-2aee8402bf79.png)

