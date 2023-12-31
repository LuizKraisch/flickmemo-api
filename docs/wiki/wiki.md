# Wiki

Here’s the Flickmemo’s wiki. You can find some extra information about the project here. 

## Index

* [Goal](#goal)
* [Scope](#scope)
* [Trade-offs](#trade-offs)
* [Deliverables](#deliverables)

## Goal

Flickmemo’s goal is to provide an easy way to organize movies without creating accounts in many places. All this is powered by TMDB API, which brings the primary information for the views in the Mobile App.

## Scope

### **1. Data collection and usage from external applications:**

Movie data is provided from [TMDB API](https://developer.themoviedb.org/reference/intro/getting-started). Basic user auth by Google.

### **2. Pre-processing and Analysis:**

Using TMDB API to bring the data requires a cleanup to keep only the necessary data. For that, what is received from the external API will be processed, organized, and then sent to the Mobile App, which will be used for the views.

### **3. Interface Design:**

All the concepts and main views were created using Figma, following the good practices of UX and UI.

### **4. Development:**

The API uses the power of Ruby on Rails to provide all the mobile app’s main functionalities, such as auth, data manipulation (filters, cleanup), and processing quickly and reactively.

The mobile app is being developed using Flutter from Google. All the main components were built from scratch using the basic libraries that Flutter provides. For other functionalities, some external libraries were used.

### **5. Quality:**

Implementation of unit tests both on the back-end and front-end of the project, having ample test coverage to guarantee the system’s operation. In addition, SonarQube will be implemented to ensure that the code is of good quality.

### **6. CI/CD:**

Implementation of Continuous Integration (CI) and Continuous Delivery (CD) through Github itself, using built-in workflows such as Rubocop (Ruby code), code analyses, and linters. 

### **7. Observability:**

Use a monitoring software for the API, planning to use NewRelic.

## Context

Flickmemo’s solution was developed to improve and make it easier to book and review movies intuitively and can be used on any device with internet access.

## Restrictions

To keep Flickmemo running, the project uses Heroku to store the database and API. Depending on how many requests the app receives in a month, it is necessary to consider a cost to keep the application.

## Trade-offs

### 1. Portability:

**Trade-off:** Flickmemo is primarily available as a mobile app, which can limit its accessibility on devices without internet access or those that do not support the supported operating systems.

**Consideration:** While portability can be an advantage for most users, those relying on unsupported devices may face difficulties.

### 2. Functionality:

**Trade-off:** Flickmemo often offers a wide range of features, such as reviews, movie lists, recommendations, etc.

**Consideration:** Including many features can make the platform richer, but it can also increase complexity and make navigation challenging for users seeking a more straightforward experience.

### 3. Usability:

**Trade-off:** The user interface design on Flickmemo can be optimized for a more pleasant and intuitive experience, but some design decisions may not please all users.

**Consideration:** Effective usability is crucial for attracting and retaining users, but subjective design decisions can result in divergent preferences.

### 4. Efficiency:

**Trade-off:** The navigation and page loading speed on Flickmemo can be compromised by the amount of data (images, reviews, etc.) the mobile app and the API need to process.

**Consideration:** While efficiency is essential for a seamless experience, optimizing speed may require concessions regarding visual quality or the amount of displayed information.

### 5. Maintainability:

**Trade-off:** Continuously maintaining and updating the API and mobile app to fix bugs, add features, and ensure security can be challenging.

**Consideration:** While maintainability is crucial for the platform’s longevity, it may require significant resources that could be directed toward other improvements.

## Deliverables

All the project is managed using Trello, following a Kanban project, with tasks to keep it organized. 

The deliverables were made by packages, following the FDD methodology, where each one adds more content to the project, including documentation, designs, processes, and code.

Below is a list of the packages that will be delivered, the month of the delivery, and the content of the packages:

### Package 1 - August/Setember

* Main documentation finished, including:
  * Diagrams based on C4 model;
  * README of the project with all sections;
  * Use cases described.
* Design of the main pages of the app finished;
  * Not including prototypes.
* Basic structure of the API finished, including:
  * Structure of the main controllers;
  * External API Service.

### Package 2 - October

* API finished, including:
  * User auth, with Google;
  * Controllers working;
  * Unit tests;
  * CI/CD working.
* Basic structure of the mobile app finished, including:
  * Mobile App Flutter repository ready on Github;
  * Auth section working;
  * Presentation page ready.

### Package 3 - November/December

* Mobile app finished, including:
  * All main views working;
  * User main actions working (e.g., add movie, review);
  * App available in stores (Google Play initially);
  * CI/CD working.
  