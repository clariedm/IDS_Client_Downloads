## IDS_Client_Downloads
## Organisation
Vous trouverez ici tous les fichiers nécessaires à la configuration des Raspberry Pis clients.
Tous sauf ceux qui seront téléchargés automatiquement lorsque vous exécuterez les premières lignes de commande.

## Fichiers :

### Fichiers README

| Nom | Fonction |
| :---: | --- |
| README_ENGLISH.md | Ce fichier, mais en anglais |
| README_FRENCH.md | Ce fichier, contenant toutes les informations nécessaires pour configurer le Raspberry Pi client et télécharger les fichiers nécessaires |

### Fichiers de configuration

| Nom | Fonction |
| :---: | --- |
| autostart | Script Shell définissant les paramètres de redémarrage pour le Raspberry Pi |
| autostart_comments | Fichier autostart mais avec des commentaires - Attention !!! Ne doit pas être executé |
| Executable.sh | Script shell contenant un premier ensemble de commandes implémentant les changements à effectuer dans la configuration du Raspberry Pi, avant que NodeRed ne soit déployé |
| Executable2.sh | Script shell exécutant un deuxième ensemble de commandes mettant en œuvre les changements à effectuer dans la configuration du Raspberry Pi, après le déploiement de NodeRed |
| openchromium.sh | Script shell contenant un premier ensemble de commandes à exécuter à chaque redémarrage du Raspberry Pi |
| openchromium2.sh | Script shell contenant un deuxième ensemble de commandes à exécuter à chaque redémarrage du Raspberry Pi.

### Capteurs et connexion Bluetooth

| Nom | Fonction |
| :---: | --- |
| data_capteur.py | Script Python pour demander et recevoir les données des capteurs d'humidité, de température et de CO2 de l'Arduino Uno |
| data_loop.py | Script Python qui renvoie true si le capteur PIR détecte du mouvement, et renvoie false s'il n'en détecte pas |

### Économie d'énergie 

| Nom | Fonction |
| :---: | --- |
| chromiumManager.py | Script Python qui ferme le navigateur chromium lorsque l'école est fermée et le redémarre à la réouverture de l'école |
| saveEnergy.sh | Script shell qui coupe l'alimentation des LEDs et des ports USB pour économiser de l'énergie |
| screenManager.py | Script Python qui allume et éteint le moniteur connecté à un Raspberry Pi. Il l'allume tous les jours à 8h00 sauf le week-end. Il l'éteint à 21:00. |

### Interface
| Name | Function |
| :---: | --- |
| Interface.json | Interface NodeRed |

### Charte graphique

| Nom | Fonction |
| :---: | --- |
| Chargement.gif | Gif utilisé comme écran de chargement car NodeRed peut mettre un certain temps à démarrer après un redémarrage |
| Wallpaper.png | Le fond d'écran à utiliser dans le Raspberry Pi nouvellement configuré |

## Configuration des Raspberry Pis clients 
# Partie 1 : Téléchargement des mises à jour et des documents
Tout d'abord, vous devez télécharger "Executable.sh" sur votre bureau en exécutant les lignes de commande suivantes dans votre terminal : 
```
cd Desktop
git clone https://github.com/clariedm/IDS_Client_Downloads/
```
Maintenant, vous devez exécuter le fichier en exécutant les lignes de commande suivantes dans votre terminal :
```
cd IDS_Client_Downloads
bash Executable.sh
```
Lors de l'exécution du fichier, il vous sera demandé de répondre à quelques questions par oui ou par non. Vous voudrez répondre oui à toutes les questions, sauf la suivante :

```
      Would you like to customize the settings now (y/N) ?
```
L'installation peut prendre jusqu'à 30 minutes. Lorsque l'exécution du fichier est terminée, le Raspberry Pi redémarre.

# Partie 2 : NodeRed
Une fois que le Raspberry Pi a redémarré, vous devez exécuter la ligne de commande suivante dans votre terminal :
```
node-red start
```
Ceci retournera des informations sur l'adresse à laquelle node-red fonctionne au milieu d'autres informations. Vous trouverez l'adresse comme suit :
```
27 Jan 16:17:59 - [info] Server now running at https://[ADDRESS]
```
L'adresse sera là où ``[ADDRESS]`` est indiqué dans cet exemple.

Vous devriez être en mesure de voir l'interface NodeRed fonctionner dans votre navigateur à [ADDRESS]:1880/ui . 

# Partie 3 : Configurer NodeRed en fonction de son adresse locale (localhost)

Si l'adresse est 127.0.0.1, vous pouvez passer à la partie 4.

Si l'adresse n'est pas 127.0.0.1 alors vous devrez faire quelques modifications avant de pouvoir exécuter le second fichier. 
Les modifications sont les suivantes :

Changez la ligne suivante dans le fichier openchromium2.sh :
```
chromium-browser --start-fullscreen --start-maximized 127.0.0.1:1880/ui
```
à ce qui suit :
``` 
chromium-browser --start-fullscreen --start-maximized [NEW ADDRESS]:1880/ui
```

Pour ce faire, vous devez utiliser la ligne de commande suivante :
```
sudo nano /home/pi/bin/openchromium.sh
```

# Partie 4 : Configuration de la connexion Bluetooth

Tout d'abord, entrez les lignes de commande suivantes dans une fenêtre shell :

```
bluetoothctl
power on
agent on
scan on
```

Après cela, vous devriez obtenir quelque chose comme ceci : 

```
Discovery started
[CHG] Controller B8:27:EB:29:46:68 Discovering: yes
[NEW] Device 00:0E:EA:CF:22:8E 00-0E-EA-CF-22-8E
[CHG] Device 00:0E:EA:CF:22:8E LegacyPairing: no
[CHG] Device [DEVICE_ADDRESS] Name: HC-05
```

Recherchez le périphérique portant le nom HC-05. Son adresse doit être affichée comme indiqué ci-dessus, au lieu de [DEVICE_ADDRESS]. En utilisant cette adresse, vous devrez coupler le périphérique au raspberry pi en utilisant la commande suivante :

```
pair [DEVICE_ADDRESS]
```
Le terminal devrait afficher ce qui suit :

```
Attempting to pair with [DEVICE_ADDRESS]
[CHG] Device [DEVICE_ADDRESS] Connected: yes
Request PIN code
[agent] Enter PIN code: 
```
Le code PIN est 1234.

Une fois le dispositif apparié, fermez la fenêtre de commande et ouvrez-en une nouvelle. Vous devrez vous connecter à l'appareil en utilisant la ligne de commande suivante :
```
sudo rfcomm connect 0 [DEVICE_ADDRESS] &
```

To finish the Bluetooth configuration you will need to go into the reconnectionBluetooth.sh file and change 98:D3:51:FD:C8:BB to [DEVICE_ADDRESS] as follows :
```
#/bin/sh
sleep 20
sudo rfcomm connect 0 [DEVICE_ADDRESS] &
```

To do so, you can enter the following command line:

```
sudo nano /home/pi/bin/reconnectionBluetooth.sh
```

# Partie 5 : Configurations finales et redémarrage

Exécutez maintenant le deuxième fichier en utilisant les commandes suivantes :
```
cd
cd /home/pi/bin
bash Executable2.sh
```
