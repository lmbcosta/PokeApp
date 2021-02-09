# PokeApp
This project aims to consume data from [PokeAPI](https://pokeapi.co)

## Requirements
* iOS 14.2

## Structure
For PokeApp it was used a MVVM architecture approach with the below layers:

Layers  | Main Responsability
----------- | -------------------
AppCoordinator | Instantiates all dependencies needed on the project dependencies
View Controller| Builds and controls different UI components for both screens: Main screen and Detail screen
Provider            | Mamory Cache. Persists the last response from service.
ViewModels | Prepares content, and manages business logic
Service | Manages network calls to PokeAPI

## External Dependencies
PokeApp has only **1** external dependency:</p>
**[KingFisher](https://github.com/onevcat/Kingfisher)**: A lightweight, pure-Swift library for downloading and caching images from the web. It was decided to use it to cache and download all Pokemon images.</p>

## Dependency Manager
As dependency manager it was used Swift Package Manager (SPM).

## Last Considerations
Due to a lack of time, there are some things that should be improved:
- Layout was terrible. I would like to be able to focus more on this subject.
- There aren't unit tests.
- This API is so rich, there is so much content that definitely I could use it to improve the app.

## Author
Luís Costa - lmbcosta@hotmail.com
