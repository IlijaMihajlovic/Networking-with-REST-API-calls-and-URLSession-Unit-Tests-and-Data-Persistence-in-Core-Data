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
- Swift 4.2+
- Xcode 9.2+
- iOS 11.0+
___

## Getting the files

* Use GitHub to clone the repository locally, or download the .zip file of the repository and extract the files.
___

## Example how the UI looks

* On the left side, we see the home controller which is a TableViewController embedded in a TabController. The TabController  also has a MapController that shows all the users location on the map. Going back to HomeController we can see the TableView cells loaded with the fetched JSON data from the REST API. When the images are downloaded the first time there are cached to the device, so the next time there's no need to download it again.

   ![alt text](https://github.com/IlijaMihajlovic/Networking-with-REST-API-calls-and-URLSession-Unit-Tests-and-Data-Persistence-in-Core-Data/blob/master/Images/cellsAndSlideMenu.png)
   
* On the right side, we can see a custom created slide menu with buttons inside init that shows up when the "more icon/button" is tapped inside the NavigationBar, also worth noticing when the slide menu shows up the backgorund bahinde it dims swith a smooth animation.   
___

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
