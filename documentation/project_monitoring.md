# Introduction

La plateforme CampusIoT a pour objectif de monter une plateforme d’expérimentation pédagogique in-vivo de l’Internet des Objets longue distance pour l’imagination et le prototypage rapide de ces services aux travers de projets disciplinaires et de projets pluridisplinaires entre les composantes des établissements de l’enseignement grenoblois. 

More information on  [Monitoring CampusIot Plateform ](https://air.imag.fr/index.php/Monitoring_de_la_plateforme_CampusIoT) Project

# Documents

* [Acces CampusIoT](https://lns.campusiot.imag.fr/#/organizations/5/applications) 
* [dépôt GitHub Racine CampusIot](https://github.com/CampusIoT)
* [dépôt GitHub](https://github.com/CampusIoT/chirpstack-monitoring)

# Team

**Tutors :** Didier Donsez

**Members :** Antoine BLANQUET, Paul LAMBERT, Kevin YUNG

**Departement :** [RICM 4 - Polytech Grenoble](http://www.polytech-grenoble.fr/ricm.html)

# Project objectives

Le projet INFO4 2020-2021 a pour objectif le développement d'outils de supervision de la plateforme CampusIoT.

Ces outils serviront :
*  à alerter les administrateurs des défaillances d'objets, des gateways ou du serveur (ainsi que leur retour à la normale).
*  à alerter les administrateurs des opérations de maintenance sur les objets (changement de batterie des objets par exemple).
*  à produire des rapports (HTML) réguliers donnant des métriques sur les gateways et les objets d'une organisation (en incluant des graphiques compacts comme [https://omnipotent.net/jquery.sparkline/#s-about Sparkline]).

# Progress of the project

The project started January 25th, 2021.

## Week 1 (January 25th - January 31th)
---
* Project discovery
* Course LoraWan
* Research on CampusIoT

## Week 2 (February 1st- February 7th)
* Analysis of all github repositories  
* Preparation Meeting 1
    + Better understanding of the subject on the `reports` side and campus.iot demo by the teacher.
    > The information emails from the current Gateways are sent via a report nearly done. We will have to add a memory effect. (Delta between passive and active gateways.
    
    **Goal:** Send an email with a very precise summary. In particular by using technologies such as `Sparkline`.
    >  **Potential problem:** send by mail, possibly not possible with javascript. **Alternative**: Generate Sparkline, generate image and generate doc in svg."
    > **PB potentiel :** envoyer par mail, possiblement pas possible avec du javascript. **Alternative** : Générer Sparkline, générer image et générer doc en svg."
    + Definition of the first objectives and missions with the teacher.
    + Follow-up report.
* Implementation of a regular follow-up with this follow-up sheet. As well, make a document which gathers all our information assimilated to this day. We named it "Récapitulatif_Projet".

## Week 3 (February 8th - February 14th) + Vacances
* Meeting with the professor.
    + Better understanding of the subject on the `dashboard` side. Demo of grafana + nodered by M.Donsez.
    **Goal:** Calculate duty cycle for endpoints and gateways: > 1% (ETSI) > 10%.

    + Understanding the management of the dashboard and the objectives to be achieved.
* First attempts to install grafana + nodered tools.
    + learning technos (docker compose)
    > **Problem : missing logins**.
* First attempts to modify the HTML report sent by default.
    + learning technos (curl + jq)
    > **Problem : missing logins**. Not understanding the curl commands in the sandbox.

* Take images from Sparkline (javascript executed) as SVG

> For the moment we are on the right track. Still not working. Problem to take exact screenshot of generated javascript.

## Week 4 (February 22th - February 28th)
* Meeting with the professor.
    + Question about the login issue on Grafana + Nodered.
    >  Answers to our questions + TTN Mapper presentation and possible new mission for later on the dashboard side.

    + Question on the report issue.
* debut de test d'implem sur nodered d'un "tableau".
* start of implementation test on nodered of an "visual graphic". 
> **Problem→** we don't have access to the database fields.
* implementation and understanding HTML report. We managed to display the report.

Task assignments: 

- [x] Antoine : Issues on Github and Gitlab
- [ ] Antoine & Kevin : Understanding furthermore curl + jq code using for generating html reports
> still in progress, todo : documentation on this. jq is a powerfull tool but we don't undeerstand everything of it.
- [ ] Antoine : [Reoganization of code](https://github.com/CampusIoT/chirpstack-monitoring/issues/5)
- [ ] Paul : [Sparkline integration & transform to SVG image](https://github.com/CampusIoT/chirpstack-monitoring/issues/2)
> in progress; very hard task because we can't really capture after javascript execute
- [ ] Kevin : [Add a memory effect on reports](https://github.com/CampusIoT/chirpstack-monitoring/issues/6)
> still in progress


## Week 5 (March 1st - March 7th)

+ weekly meeting with our teacher
Better understanding how to use InfluxDB.
+ Continuation of tasks to be performed

- [x] Antoine : Understanding all the API for CampusIoT and how to use it !
- [] Antoine & Kevin : Understanding furthermore curl + jq code using for generating html reports
> still in progress, separating tasks between kevin and antoine. Kevin implementend json generation on branch `test_report_j-1` (first version). Antoine looked how to display html correctly between passives and actives Gateways with J-1 day.
- [ ] Antoine : [Reoganization of code](https://github.com/CampusIoT/chirpstack-monitoring/issues/5)
> not a priority.
- [X] Paul : [Sparkline integration & transform to SVG image](https://github.com/CampusIoT/chirpstack-monitoring/issues/2)
> Done. It display it in PNG. Issue closed.
- [ ] Kevin : [Add a memory effect on reports](https://github.com/CampusIoT/chirpstack-monitoring/issues/6)
> task to do later.
- [ ] Paul : Understanding furthermore on TTT implementation. Looking how to do it.
> still in progress.

## Week 6 (March 8th - March 14th)

+ Mid-Term Presentation
> Preparing the presentation with graphics.

- [x] Kevin & Antoine : Understanding furthermore curl + jq code using for generating html reports
-- [x] Kevin implementend json generation on branch `test_report_j-1` 
-- [x] Kevin looked how to display html correctly between passives and actives Gateways with J-1 day.
> Kevin took all tasks on this, easier to do.
> Finalisation du code pour identifier un changement d'état sur les gateways + correction d'erreurs + ajout du changement dans le fichier html qui change la couleur de la gateway si changement d'état + début de test pour l'envoi des mails

- [ ] Paul : Understanding furthermore on TTT implementation. Looking how to do it.
> Remise en question de la direction que prenais mes recherches sur l'affichage de la carte
> Search to access a JSON file in JavaScript. (seems impossible under the Web aspect)
> Research around NodeJS to display an HTML page with style (for the map)
> Questioning the direction of research we were taking on the map display.

- [] Antoine : Implementation of Sparkline on HTML report
> Succesfully use API to generate stats from api. First implementation in `get_gateway_stats.sh.` Still in Progress.

## Week 7 (March 15th - March 21th)

- Understanding furthermore on TTT implementation. Looking how to do it.
> Feature put on stand-by. Not a priority.
> it's TTN and basically we couldn't read a json file from JS (native / web). It was surely a mistake to work in a web process elsewhere because using nodeJS it must be possible but then we would not have had the leaflet (map) displayed, and that was the primary goal anyway
> we did not see where we would use this card.

- [x] Paul : Sending functional email to Gmail address not to university address
- [ ] Paul : API search to retrieve devices but no code

- [x] Kevin : Integration of momentjs in the code to be able to change the dates for more readability

- [x] Antoine : Implementation of Sparkline on HTML report
> Finalization and Strucutration of Sparkline Generated code

## Week 8 (March 22th - March 28th)

- [] Paul + Kevin : Code review for code merging / Code improvement for devices
> Good implementation, still in progress.

- [x] Antoine : Completely updated Sparkline Fusion code with MomentJs and Devices

- [ ] Todo : Code cleaning and structuring

## Week 9 (March 29th - April 04th)

- [x] Kevin : Finalisation on the code for devices to match the one for gateways, problems to correct because of null values on some devices using the API

- [X] Paul : Code cleaning and structuring
> cleaning french comments and put everything in english.
> restructing the code where files where register.
> How to install mailserver documentation written.

- [ ] Antoine : Working on the Report and similar stuff

## Week 10 (March 05th - April 08th)

- [X] Antoine : Restruction of code with data repertory which includes all configurations, json, html and csv files
- [X] Antoine & Kevin : Fixing bug MomentJS
- [X] Antoine & Paul : Cleaning Code and adding Headers to files we create or modified
- [X] Antoine : Adapt devices generation html to gateways implementation
- [X] Antoine & Paul : Adapt devices generation html to gateways implementation
- [X] Kevin : Bug Fix sending mail with attachment image
- [X] Antoine & Paul : Sending picture from a html file with javascript generated. (very long and hard part because of dependencies)
- [X] Kevin & Paul : Conception of new architecture of reports files
- [X] A & K & P : Redaction of Final Report
- [X] A & K & P : Documentation
- [X] Antoine & Paul : Handling errors on npm files.

