# DigioStore app

<p align="center">
  <img src="https://github.com/Themakew/digio-store-app/assets/3030029/ab309d51-6887-4a03-a467-fb498340a950" alt="Simulator Screenshot - iPhone 15 Pro Max - 2023-10-10 at 17 54 33" width="200"/>
  <img src="https://github.com/Themakew/digio-store-app/assets/3030029/53e30802-234b-43bd-9921-b135d5d893dc" alt="Simulator Screenshot - iPhone 15 Pro Max - 2023-10-10 at 17 54 42" width="200"/>
</p>

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

Run `./bootstrap.sh` from the root directory of this repository, it will install all dependecies and open the Xcode Project automatically.

---
<p align="center">Made by Ruyther Costa | Find me on <a href="https://www.linkedin.com/in/ruyther">LinkedIn</a></p>
