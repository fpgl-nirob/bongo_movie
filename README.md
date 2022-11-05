# Bongo Movie
This is a movie list application where you can see top rated movies and view details of the movie. And you can change theme and languages(English and Hindi)

## Features

- User can see top rated movies from The Movie Database (TMDB)
- User can see the details of the movie.
- Unit testing added

## Requirements

- iOS/iPadOS 13.0+
- Swift 5.0

## Supported Platforms
- iPhone (iOS 13.0+)
- iPad (iPados 13.0+)

## How to Build

At first, run the following command in terminal:

```
git clone <#SSH/HTTPS#>
```

Then go to project directory.
```
cd <project's root directory>
```

And then, install dependenies through cocoapod into project:

```
pod install
```

Finally, open ```BongoMovie.xcworkspace``` file. Build and Run the project. That's it.

## Project Architecture

- Used MVVM archetectural design pattern.
- Also used some other design patterns like ```singleton, protocol, Observer etc```.

## Third party libraies

- 'SnapKit', '5.6.0'
- 'SDWebImage', '5.13.4'
- 'MBProgressHUD', '1.2.0'
- 'Alamofire', '5.6.2'
- 'Cosmos', '23.0.0'

## Limitations

- User can't search movies, they can only see top rated movies and it's details.
- User can't give review or rating.
- User can't see other movies rather than top rated movies.

## Future Update

- Will add user login/registration option
- Will add search movie option
- Will add rating, review functionality

## Availability
This app is not in appstore currently but you can take a look the video which is cover all the features. [Watch the video](https://youtu.be/4GPUEq8slWA)
