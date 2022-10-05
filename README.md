# currency_converter_app

Currency Converter app
![Screenshot_20221005-152932](https://user-images.githubusercontent.com/16311128/194061508-5a4d20ad-1c75-44d1-b08b-7b2e6deb083b.jpg)<br/>

## Getting Started

This project is a Task for Digitinary Co. to improve some experience and skills.

build with flutter (Dart freamWork)<br/>
![Screenshot_20221005-152942](https://user-images.githubusercontent.com/16311128/194061725-2821daad-3618-4a55-b1d1-d3819eb5eca4.jpg)

The project has tow end point for currncy convert resources :<br/>
1-  [api.exchangerate-api.com](https://www.exchangerate-api.com/)<br/>
2- [https://free.currencyconverterapi.com](https://free.currencyconverterapi.com/)<br/>
<br/>
The reason for using two endpoints is that [https://free.currencyconverterapi.com](https://free.currencyconverterapi.com/) need some connection with the author to get the API key so I start with [api.exchangerate-api.com](https://www.exchangerate-api.com/) to finish the task early but after two days I got the free API key from the author of free.currencyconverterapi.com

and added to the project.
<br/><br/>
The endpoint for countries flags<br/>
1- https://flagcdn.com/
<br/>

<br/>
Instructions on how to build the project<br/>
This project follows the MVC structure and this is the tree of folders I used this structure for maintainability and usability.<br/>
<br/><br/>
--lib<br />
    |--cubits >>>  all cubits that used in the project<br />
        >>> Folder for each cubit<br />
    |-- data<br />
        >>> all sources data like contractors and resources<br />
      |-- constans<br />
            >>> all constants in the project like api endpoint and some const settings<br />
      |-- db<br />
            >>> all tables providers to "CURD" Table in the database<br />
      |-- models<br />
            >>> all models that convert the response from the database and the api(internet)<br />
      |-- network(dio)<br />
            >>> all network methods and settings<br />
      |-- repos<br />
            >>> all Controller repositories to handle the connections with the resources<br />
      |-- resources<br />
            >>> all resources we need it in the ui (Managers for fonts and size ...etc)<br />
       di.dart<br />
        >>> for creating Depndice injection in the application<br />
    |-- helpers<br />
        >>> all helper method for converting strings and log fonts color print for quick debugger<br />
    |-- presentation<br />
        >>> all User interface for application<br />
      |-- screens<br />
            >>> all main application screens<br />
      |-- widgets<br /><br />
            >>> all widgets that used on different screens<br />
    |-- main.dart<br />
        >>> mian (run file)<br />
<br />
And this the answers of all qustions that writen in Task document:
<br />
Q1 : what is the image loader page I used?
A : its "cached_network_image: ^3.2.0" it's a great package for show images with some motions, can cache the image after the first load from URL and if there is some error with the image URL you can handle it with and widget so the UI will be more friendly.

Q2 : what is the database I used?
A : it's "sqflite: ^2.0.3+1" it's the global and usable data storge in all systems, and i used it for save all requests that user send it to the back-end
and if the device doesn't have a connection to the internet and the request amount recorded in the tables the user will get the last update table row info.

Q3 : what is the dependency injection package I used?
A : its "get_it: ^7.2.0" its the favorite and most used to share all repositories in all your project.
