<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.3-orange.svg?style=flat" alt="Swift 5.3">
   </a>
    <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Xcode-12.0.1-blue.svg" alt="Xcode 12.0.1">
   </a>
   <a href="">
      <img src="https://img.shields.io/cocoapods/p/ValidatedPropertyKit.svg?style=flat" alt="Platform">
   </a>
   <a href="https://twitter.com/ricardo_psantos/">
      <img src="https://img.shields.io/badge/Twitter-@ricardo_psantos-blue.svg?style=flat" alt="Twitter">
   </a>
</p>


# iOS Architecture design patterns :VIP + Clean + Rx

The mains intent of this project is:

* To show a implementation of one of my favourites design patterns: __VIP + Clean (Rx)__ and how we can use booth at same time and still have a rock solid project. 

* Have a quick start project with all that a good project have (logs, webapi, etc), and that usually take some days to configure if we start from scratch. Saying so _Good to Go_ looked like a good name to me.

If you don't agree with something or have a suggestion, just email me, I love to hear opinions and learn from that.

# Install

Download source code and run  `./makeProject.sh`

This will install/update [Brew](https://brew.sh/), that will be used to install/update [Carthage](https://github.com/Carthage/Carthage)

Also, on last step, can regenerated the project using [XcodeGen](https://github.com/yonaskolb/XcodeGen)

![Preview](Documents/images/install.png)

### Could not save file?

If theres a error while building Carthag : _Could not save file_ - run on terminal `open $TMPDIR/TemporaryItems` and delete folder content

[Carthage/issues/3056](https://github.com/Carthage/Carthage/issues/3056)
 
## Project structure

![Preview](Documents/images/project.png)

The project follows the Domain Driven approach, and its divided in frameworks according to business.

About naming, and taking `Core` as example. `Core` is where we have the __base__ implementation of business for the app; and this `Core` is something that could be in every mobile app. But `Core.XXX` do the same type of  of special business logic applied to this app alone.  

This mean that if we want to take out the `XXX` logic from the project, we just need to take `Core.XXX`, `Domain.XXX` and the related _Scenes_.

## Project modules dependencies

Bellow is a simplied dependencies graph 

![Preview](Documents/images/G2G.graph.simplified.png)

* `GoodToGo` : Is the app it self. Scenes, Workers and SwiftInject related code
* `AppTheme` : Manage fonts, colours and so so
* `BaseConstants` : Constants
* `Designables` : UI components
* `Factory` : Factory for objects (for now just `Errors`)
* `AppResources` : App strings/localisables, images, etc...
* `BaseUI` : Base classes, mainly for `VIP`
* `BaseDomain`, `Core`, `Repositories` : DDD
* `DevTools` : Logs, feature flags, developer helping tools in general
* `Extensions` : See [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html)
* `PointFreeFunctions` : Small global var/functions like

 ```
 public var screenWidth: CGFloat { return UIScreen.main.bounds.width }
 ```

# VIP - Quick intro

A single screen has always 6 files as we can see on the image below

![Preview](Documents/images/VIP.project.png)

* `View` - View Logic
    * Only UI
    * No business
    * Forward user interaction to `ViewController`
    * Don't know nothing, including `ViewController`
* `UIViewController` - Display Logic
    * Glues/bridge `View` and `Interator` by observing the `View` and letting the `Interator` know about it
    * No business
    * Knows a `Router` if needed
    * Knows the `Interactor`
    * Knows `View` and observe `View` to pass events to `Interactor`
* `Interator` - Business Logic
    * Can have business rules
    * Receive `ViewController` requests and do stuff with it
    * Knows `Worker` 
    * Knows `Presenter` 
    * Takes the `Worker` responses, and forward then to the `Presenter`
* `Presenter` - Presentation Logic
    * Receives a raw object from the `Interactor` and parse it in a way that the View knows how to show it. Example : The `Interactor` can send a `Swift.Date` object to the `Presenter`, and the `Presenter` turns that into a `String` like _Monday, 10 AM_
    * Takes an `Interactor` object, parses it and sent it to the `ViewController` and the `ViewController` sends it to the `View`
* `Domain` 
    * The `Domain` file contains all the protocols related with some `Scene` (since all this layers are connected using protocols), and also all the related `ViewModels`
* `Router` 
    * Handles screen routing 

* __Others__    
    * `Worker` 
        * If and app could be separated into UI and business, the worker is the glue/bridge
        * Connects the Interator and the UseCases
    * `UseCases`
        * Brain of the app. 
        * Can connect to `API`, `DataBase` and so on 

![Preview](Documents/images/G2G.graph.simplified.png)

Looking the image above, about the project dependencies, if we zoom in `UICarTrack` and `UIGalleryApp`, we will end up with the diagram of the image below

![Preview](Documents/images/VIP.graph.png)

More info about VIP architecture [here](https://github.com/ricardopsantos/RJPS_MVPCleanRx/tree/master/documents/Arquitecture)

# Project (implemented) Features

- [x] [Xcodegen](https://github.com/yonaskolb/XcodeGen) configurated
- [x] Localisable resources
- [x] Remote logs with [NSLogger](https://github.com/fpillet/NSLogger)
- [x] [RJPSLib](https://github.com/ricardopsantos/RJPSLib) to manage logs, caching, network client, generic extensions...
- [x] FRP with RxSwift & RxCocoa
- [x] [.xcconfig](https://nshipster.com/xcconfig/) usage
- [x] Cache (on Network API) usage
- [x] Code style analyser with [Swiftlint](https://github.com/realm/SwiftLint)
- [x] Dependency injection with [Swinject](https://github.com/Swinject/Swinject)
- [x] VIP Pattern design sample screens - `GoodToGo/Scenes/VIP.*`
- [x] VIP Custom Xcode Template - `GoodToGoVIP_Schene.xctemplate`
- [x] UnitTests
- [x] `SwiftUI` Preview for all `UIViewControllers`
 
# Used Frameworks

 * [RJPSLib](https://github.com/ricardopsantos/RJPSLib) - Swift toolbox
 * [TinyConstraints](https://github.com/roberthein/TinyConstraints) - Nothing but sugar.
 * [Swinject](https://github.com/Swinject/Swinject) - Dependency injection framework for Swift with iOS/macOS/Linux
 * [NSLogger](https://github.com/fpillet/NSLogger) - A modern, flexible logging tool
 * RxSwift, RxCocoa
 * [Toast-Swift](https://github.com/scalessec/Toast-Swift) - A modern, flexible logging tool
 * [SkyFloatingLabelTextField](https://github.com/Skyscanner/SkyFloatingLabelTextField) - A beautiful and flexible text field control implementation of _Float Label Pattern_
 * [Material](https://github.com/CosmicMind/Material) - A UI/UX framework for creating beautiful applications. http://cosmicmind.com
 * [Motion](https://github.com/CosmicMind/Motion) - A library used to create beautiful animations and transitions for iOS. 
 * [Lottie-ios](https://github.com/airbnb/lottie-ios) - An iOS library to natively render After Effects vector animations
 * [Pulsator](https://github.com/shu223/Pulsator/) - Pulse animation for iOS (used on `UIView+Extensions.swift`, `func addPulse()` for utility purposes)
 * [Firebase](https://firebase.google.com/docs/remote-config) - For remote config

# Code Guidelines/Conventions

### All is private

Variables, functions, etc are private, unless really need to be public/internal

### Variable naming

* All `UIButton`s start by _btn_. Example : _btnLogin_, _btnRegister_
* All `UILabel`s start by _lbl_. Example _llbName_, _lblPassword_
* All `UITableView`s start by _table_ or _tbl_. Example : _tableUsers_, _tblFriends_
* All `UITextViews` and `UITextField`s starts by _txt_. Example : _txtPassword_, _txtUserName_
* All Rx related vars start with `rx` or end with `Single`, `Observable`, etc...

__Thumb rule : The name of the var, should be clear about the type associated.__

### Files naming

The _Views_ will start always by `V.`, _ViewControllers_ by `VC.`, _Routers_ by `R.`, _Interactors_ by `I.`, _Presenters_ by `P.`,  _Domain_ file by `D.` 

Other files : `W.` for _Workers_ and `UC.` for _UseCases_

### Others

* Hardcoded values are strongly discouraged

# License

[Unlicensed](http://unlicense.org)

What is the Unlicensed?
The Unlicensed is a template for disclaiming copyright monopoly interest in software you've written; in other words, it is a template for dedicating your software to the public domain. It combines a copyright waiver patterned after the very successful public domain SQLite project with the no-warranty statement from the widely-used MIT/X11 license.
