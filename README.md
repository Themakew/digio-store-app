# DigioStore app

DigioStore is a simple app to sample some basic features, such as: API integration, ViewCode, CollectionView and MVVM-C with RxSwift.

## Functionalities
✔️ Home screen displaying some products for the user.

✔️ Detail screen displaying the product detail.

## Technologies and tools used

- Swift: program language
- RxSwift: for biding the data using the MVVM-C
- RxGesture: capture events on views that RxCocoa does not handle, such as UILabel
- UIKit: for building screen programatically
- XCoordinator: for organize the app navigation
- Kingfisher: a simple framework for image download

## Architecture used

Architecture used was MVVM-C, with some elements of Clean Architecture. Strong reference used: <a href="https://github.com/kudoleh/iOS-Clean-Architecture-MVVM">repo.</a></p> 

## API used for integration

API integration with this app was <a href="https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products">API.</a></p>
A simple service to list the products and their detail informations.

## How to run the project?

It is quite straightforward:

Run `./bootstrap.sh` from the root directory of this repository (in order to install SwiftLint), and then the `.xcodeproj` file, waits for SPM to install the dependencies.

## TODO (Future Work)

- For some reason the RxBlocking is presenting some bug when running the unit tests, the work around is necessary yet. After fixing this issue, the future work would be increase the tests coverage.

---
<p align="center">Made by Ruyther Costa | Find me on <a href="https://www.linkedin.com/in/ruyther">LinkedIn</a></p>
