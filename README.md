# Système de Gestion de Banque de Sang

**Application Web JEE** pour la gestion complète des donneurs et receveurs de sang avec automatisation du processus de matching selon les compatibilités sanguines et les urgences médicales.

---

## 📌 Contexte

Suite aux défis rencontrés par les centres de transfusion sanguine dans la gestion manuelle, cette application web monolithique JEE intègre :

* Gestion complète des donneurs et receveurs
* Automatisation du matching selon compatibilités sanguines
* Priorisation selon urgences médicales
* Validation automatique des critères d'éligibilité

---

## ✅ Fonctionnalités Principales

### Pages de l'Application

* **Page Création** : Formulaires distincts donneur/receveur avec validations automatiques
* **Page Liste Donneurs** : Tableau avec informations personnelles, receveurs associés, actions (modifier/supprimer), et filtres
* **Page Liste Receveurs** : Tableau avec informations personnelles, donneurs associés, actions (modifier/supprimer), tri automatique par priorité

### Gestion des Donneurs

* Informations personnelles complètes (nom, prénom, téléphone, CIN, date de naissance, poids, sexe)
* Groupe sanguin avec compatibilité automatique
* Statut de disponibilité automatique :
    * **DISPONIBLE** : Peut donner du sang
    * **NON_DISPONIBLE** : Déjà associé à un receveur
    * **NON_ELIGIBLE** : Ne respecte pas les critères

#### Critères d'Éligibilité

* Âge entre 18 et 65 ans

### Gestion des Receveurs

* Informations personnelles (nom, prénom, téléphone, CIN, date de naissance, sexe)
* Groupe sanguin avec règles de compatibilité

#### Tri Automatique

Liste des receveurs triée par priorité décroissante : CRITIQUE → URGENT → NORMAL

---

## 🩸 Matrice de Compatibilité Sanguine

| Receveur | Peut recevoir de |
|----------|------------------|
| O- | O- |
| O+ | O-, O+ |
| A- | O-, A- |
| A+ | O-, O+, A-, A+ |
| B- | O-, B- |
| B+ | O-, O+, B-, B+ |
| AB- | O-, A-, B-, AB- |
| AB+ | Tous (receveur universel) |

**Note** : O- est donneur universel (compatible avec tous les groupes)

---

## 🧾 Règles de Validation

### Association Donneur-Receveur

* Afficher uniquement les entités compatibles :
    * Pour un receveur : donneurs compatibles ET disponibles
    * Pour un donneur : receveurs compatibles ET non satisfaits
* Vérification automatique du groupe sanguin
* Validation du statut avant association
* Messages d'erreur explicites en cas d'incompatibilité

### Validations Formulaires

* Champs obligatoires vérifiés
* Format CIN validé
* Format téléphone vérifié
* Âge et poids pour donneurs
* Gestion des erreurs avec messages utilisateurs

---

## 🧰 Stack Technologique

* **Langage** : Java 17
* **Framework** : JEE (Java Enterprise Edition)
* **Vue** : JSP avec JSTL
* **Build** : Maven
* **Serveur** : Apache Tomcat
* **Base de données** : PostgreSQL
* **ORM** : JPA/Hibernate
* **Tests** : JUnit (minimum 2 tests unitaires)
* **UI** : Tailwind

---

## 🏗️ Architecture & Design Patterns

### Architecture MVC Multicouches

```
src/
├─ main/
│  ├─ java/
│  │  ├─ org.exapmle/
│  │  │  ├─ config/               # Configuration générale
│  │  │  ├─ web.controllers/      # Servlets (gestion requêtes HTTP)
│  │  │  ├─ services/             # Logique métier et compatibilité
│  │  │  ├─ repositories.DAO/     # Accès données avec JPA       
│  │  │  └─ entities/             # Entités JPA (Donneur, Receveur) et les Enums
│  ├─ resources/
│  │  └─ META-INF/
│  │     └─ persistence.xml  # Configuration JPA/Hibernate
│  └─ webapp/
│     ├─ WEB-INF/
│     │  ├─ web.xml          # Configuration servlets/filtres
│     │  └─ views/           # JSP files
│     └─ index.jsp
├─ test/
│  └─ java/                  # Tests JUnit
├─ pom.xml
└─ README.md
```

### Design Patterns Implémentés

* **Repository Pattern** : Accès aux données
* **Singleton Pattern** : EntityManagerFactory
* **MVC Pattern** : Séparation présentation/métier/données
* **Service Layer** : Logique métier centralisée

### Principes SOLID

* **S**ingle Responsibility : Chaque classe a une responsabilité unique
* **O**pen/Closed : Extensible sans modification
* **L**iskov Substitution : Interfaces respectées
* **I**nterface Segregation : Interfaces spécifiques
* **D**ependency Inversion : Dépendance aux abstractions

---

## ⚙️ Configuration JPA/Hibernate

### persistence.xml

```xml
<persistence xmlns="https://jakarta.ee/xml/ns/persistence"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="https://jakarta.ee/xml/ns/persistence
                                 https://jakarta.ee/xml/ns/persistence/persistence_3_0.xsd"
             version="3.0">

    <persistence-unit name="sang" transaction-type="RESOURCE_LOCAL">
        <provider>org.hibernate.jpa.HibernatePersistenceProvider</provider>
        <exclude-unlisted-classes>false</exclude-unlisted-classes>
        <properties>
            <property name="hibernate.dialect" value="org.hibernate.dialect.PostgreSQLDialect"/>
            <property name="hibernate.hbm2ddl.auto" value="update"/>
            <property name="hibernate.show_sql" value="true"/>
            <property name="hibernate.format_sql" value="true"/>
        </properties>
    </persistence-unit>
</persistence>
```

### web.xml (Configuration Obligatoire)

```xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

    <!-- Déclaration du servlet -->

    <servlet>
        <servlet-name>DonationAssociationController</servlet-name>
        <servlet-class>org.example.web.controllers.DonationController</servlet-class>
    </servlet>

    <servlet>
        <servlet-name>DonneurController</servlet-name>
        <servlet-class>org.example.web.controllers.DonneurController</servlet-class>
    </servlet>

    <servlet>
        <servlet-name>ReceveurController</servlet-name>
        <servlet-class>org.example.web.controllers.ReceveurController</servlet-class>
    </servlet>


    <!-- Mapping du servlet -->
    <servlet-mapping>
        <servlet-name>DonneurController</servlet-name>
        <url-pattern>/donneurs/*</url-pattern>
    </servlet-mapping>

    <servlet-mapping>
        <servlet-name>ReceveurController</servlet-name>
        <url-pattern>/receveurs/*</url-pattern>
    </servlet-mapping>

    <servlet-mapping>
        <servlet-name>DonationAssociationController</servlet-name>
        <url-pattern>/donations/*</url-pattern>
    </servlet-mapping>

</web-app>

```

---

## 🚀 Installation & Déploiement

### Prérequis

* JDK 17+
* Apache Tomcat 11+
* PostgreSQL
* Maven

### Étapes d'Installation

1. **Cloner le projet**
   ```bash
   git clone https://github.com/zakariaeelhassad/Syst-me-Gestion-de-Banque-de-Sang.git
   cd bSyst-me-Gestion-de-Banque-de-Sang
   ```

2. **Configurer la base de données**
    * Créer la base de données
    * Modifier persistence.xml avec vos credentials

3. **Compiler avec Maven**
   ```bash
   mvn clean install
   ```

4. **Déployer sur Tomcat**
    * Copier le fichier WAR dans `tomcat/webapps/`
    * Démarrer Tomcat
    * Accéder à `http://localhost:8080/Systme_Gestion_Banque_Sang`

---

## 📊 Gestion de Projet

### Méthodologie Scrum avec JIRA

* User Stories définies
* Sprints organisés
* Backlog priorisé
* Burndown charts

**Lien JIRA** : [Votre lien JIRA ici]

---

## 📷 Captures d'Écran & Diagrammes

### Diagramme de Classes UML
![Diagramme de Classes](docs/uml/class-diagram.png)

### Captures d'Écran
![Page Création](docs/screenshots/creation.png)
![Liste Donneurs](docs/screenshots/donneurs.png)
![Liste Receveurs](docs/screenshots/receveurs.png)
![Dashboard](docs/screenshots/dashboard.png)

---

## 📝 Livrables

* ✅ Code source complet avec structure Maven
* ✅ Fichier WAR déployable
* ✅ README.md (ce fichier)
* ✅ Lien JIRA
* ✅ Diagramme de classe UML
* ✅ Documentation technique
* ✅ Tests unitaires (minimum 2)

---

## ✅ Critères de Performance

* ✅ Respect des exigences fonctionnelles
* ✅ Règles métier correctement implémentées
* ✅ Architecture MVC multicouches
* ✅ Design Patterns (Repository, Singleton)
* ✅ Principes SOLID
* ✅ Configuration JPA/Hibernate
* ✅ Gestion des erreurs complète
* ✅ Code propre et documenté
* ✅ Tests fonctionnels

---

## 📅 Calendrier

* **Début** : 06/10/2025
* **Deadline** : 14/10/2025 avant minuit
* **Présentation** : Date à confirmer

---

## ✉️ Contact

**Auteur** : [Zakariae el hassad]  
**Email** : [zakariaelhasssad031@gmail.com]  
**GitHub** : [https://github.com/zakariaeelhassad](https://github.com/zakariaeelhassad)

---

## 📄 Licence

Ce projet est développé dans un cadre pédagogique.

---

**Bonne implémentation ! 🩸🚀**