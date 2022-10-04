# currency_converter_app

currency converter app
![alt text](https://pixelhome-my.sharepoint.com/:i:/g/personal/ahmad-izzeddin_onedrivejo_com/EdL6bFjgQWhDkMRjW1LNB9cBA187hN88lVEUO4MhaBim4g?e=BRYLys)

## Getting Started

This project is Task for Digitinary Co. to imporve some experice and skills.

build with flutter freamWork (Dart)

The project has tow end point resources :
1- api.exchangerate-api.com
2- currencyconverterapi.com

The reason for using two endpoints is that free.currencyconverterapi.com need some connection with the author to get the API key so I start with
api.exchangerate-api.com to finish the task early but after two days I got the free API key from the author of free.currencyconverterapi.com
and added to the project.

Instructions on how to build the project

This project follows the MVC structure and this is the tree of folders I used this structure for maintainability and usability.

--lib
    |--cubits >>>  all cubits that used in the project
        >>> Folder for each cubit
    |-- data
        >>> all sources data like contractors and resources
      |-- constans
            >>> all constants in the project like api endpoint and some const settings
      |-- db
            >>> all tables providers to "CURD" Table in the database
      |-- models
            >>> all models that convert the response from the database and the api(internet)
      |-- network(dio)
            >>> all network methods and settings
      |-- repos
            >>> all Controller repositories to handle the connections with the resources
      |-- resources
            >>> all resources we need it in the ui (Managers for fonts and size ...etc)
       di.dart
        >>> for creating Depndice injection in the application
    |-- helpers
        >>> all helper method for converting strings and log fonts color print for quick debugger
    |-- presentation
        >>> all User interface for application
      |-- screens
            >>> all main application screens
      |-- widgets
            >>> all widgets that used on different screens
    |-- main.dart
        >>> mian (run file)

And this the answers of all qustions that writen in Task document:

Q1 : what is the image loader page I used?
A : its "cached_network_image: ^3.2.0" it's a great package for show images with some motions, can cache the image after the first load from URL and if there is some error with the image URL you can handle it with and widget so the UI will be more friendly.

Q2 : what is the database I used?
A : it's "sqflite: ^2.0.3+1" it's the global and usable data storge in all systems, and i used it for save all requests that user send it to the back-end
and if the device doesn't have a connection to the internet and the request amount recorded in the tables the user will get the last update table row info.

Q3 : what is the dependency injection package I used?
A : its "get_it: ^7.2.0" its the favorite and most used to share all repositories in all your project.
