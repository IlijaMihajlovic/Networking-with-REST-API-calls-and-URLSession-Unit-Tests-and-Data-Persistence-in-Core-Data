# Networking-with-REST-API-calls-and-URLSession,Unit-Tests-and-Data-Persistence-in-Core-Data

![platform-ios](https://img.shields.io/badge/platform-ios-Blue.svg)
![swift-version](https://img.shields.io/badge/swift-5.0-Orange.svg)
![lisence](https://img.shields.io/badge/license-MIT-Lightgrey.svg)

Networking in Swift with REST API calls and URLSession, that puts the parsed JSON Data from an HTTP based JSON storage endpoint I created into a TableView and persists the data using Core Data with CRUD (create, read, update, and delete). I used also Unit Tests to test URLSession asynchronous network operations and make the project as robust as possible. When the JSON data is parsed into the dynamic TableView cell we can easily delete the cell with a swipe, the TableView will then reload itself with a custom made animation and Core Data will update and save the changes in realtime. There is also an option to send HTTP GET requests to the JSONPlaceholder server and show all the users on the map from their corresponding lat and long coordinates.

And last but not least I implemented a settings launcher slide-up menu that slides up from the bottom of the screen when the settings tab bar button is pressed. On the slide-up menu, we have all the functionalities I mentioned above like getting the data from the REST API, filtering the data in the cells using a search bar and sorting them in the right alphabetical order, and also send data to a REST API.
This whole project is created completely programmatically without Storyboards and Interface Builder.
___
## Side Note
* Currently, I do not have an iPhone, so I'm unable to test the app on a physical device. I apologize in advance for maybe possible bugs.

   Kind regards,

   Ilija 🖖 😄
___

## Requirements
- Swift 5.0+
- Xcode 10.2+
- iOS 12.2+
___

## Getting the files

* Use GitHub to clone the repository locally, or download the .zip file of the repository and extract the files.
___

## Example how the UI looks

* On the left side, we can see the home controller which is a TableViewController embedded in a TabController. The TabController  also has a MapController that shows all the users location on the map. Going back to HomeController we can see the TableView cells loaded with the fetched JSON data from the REST API. When the images are downloaded the first time there are cached to the device, so the next time there's no need to download it again.

   ![alt text](https://github.com/IlijaMihajlovic/Networking-with-REST-API-calls-and-URLSession-Unit-Tests-and-Data-Persistence-in-Core-Data/blob/master/Images/cellsAndSlideMenu.png)
   
* On the right side, we can see a custom created slide menu with buttons inside init that shows up when the "more icon/button" is tapped inside the NavigationBar, also worth noticing when the slide menu shows up the backgorund bahinde it dims swith a smooth animation.
___

* In this image on the left side we see the implmented search by lowercase and uppercase latters, filtter and sort by alphabetical order.

  ![alt text](https://github.com/IlijaMihajlovic/Networking-with-REST-API-calls-and-URLSession-Unit-Tests-and-Data-Persistence-in-Core-Data/blob/master/Images/searchAndPullToRefresh.png)

* On the other side there is the currently put in motion pull to refresh functionality that downloads or reloads the data if necessary.
___

* On the left and right side, we can see an UIAlertController with four UITextFields that require some intput data so we can send an HTTP POST request. If the data type input is incorrect or one of the text fields is left blank the send button will be unavailable till all the fields are filled correctly.

   ![alt text](https://github.com/IlijaMihajlovic/Networking-with-REST-API-calls-and-URLSession-Unit-Tests-and-Data-Persistence-in-Core-Data/blob/master/Images/send%20Message.png)
___

* On the first mockup, we can see when the user swipes to the left and tries to delete the cell. If the cell is then deleted core data updates the database with new changes and the table view gets reloaded to represent the changes.

   The mockup in the middle of the image shows what I call the DetailViewController it gets loaded when the user taps on a cell. This DetailViewController showcases more information about the user i.e. the particular tapped cell.

   ![alt text](https://github.com/IlijaMihajlovic/Networking-with-REST-API-calls-and-URLSession-Unit-Tests-and-Data-Persistence-in-Core-Data/blob/master/Images/deleteDetailVCAndMap.png)
   
* On the far right side of the image, we can see the MKMapView with annotations showing the users locations on the map.
___

## The Project

* A short sneak peek into the project. 😄💻

   ![alt text](https://github.com/IlijaMihajlovic/Networking-with-REST-API-calls-and-URLSession-Unit-Tests-and-Data-Persistence-in-Core-Data/blob/master/Images/project.png)

## License
```
MIT License

Copyright (c) 2019 Ilija Mihajlovic

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
