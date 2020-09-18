# Faylasof iOS Task
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Faylasof task for an iOS developer vacancy.

### Used Third Party Libraries
 - Firebase/Storage (Instead of Alamofire and Kingfisher)
 - Firebase/Firestore (Used for Database connection with Firebase)
 - Firebase/Analytics (Used for linking with Firebase)

### Missing Requirements
 - Use of RxSwift (Singleton was used instead)
 - Support for uploading videos
 - Implementation of likes as the backend is not ready yet

### Other Comments
 - id was not used in the model as Firebase's Firestore index the entries internally if no backend is used
 - Project was created on Xcode Version 11.3 (11C29)
 - Project's minimum support is iOS 13.2 
 - Make sure to change Bundle Identifier before user and 
```console
pod install
```

## Screenshots

![Screenshot 1](https://github.com/fadyelgawly/Faylasof-iOS-Task/raw/master/Faylasof%20Task/Screenshots/Screenshot1.png)
![Screenshot 2](https://github.com/fadyelgawly/Faylasof-iOS-Task/raw/master/Faylasof%20Task/Screenshots/Screenshot2.png)
![Screenshot 3](https://github.com/fadyelgawly/Faylasof-iOS-Task/raw/master/Faylasof%20Task/Screenshots/Screenshot3.png)
