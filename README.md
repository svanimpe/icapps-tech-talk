# iCapps Tech Talk

This repository contains the finished projects from the iCapps Tech Talk on May 23, 2018.

## Prerequisites

You will need the following to run the examples:

- Swift 4.1 from Xcode 9.3 or [swift.org](https://swift.org/download/)
- MongoDB
- CocoaPods

I've also used the following tools during the talk. These are optional:

- [Visual Studio Code](https://code.visualstudio.com)
- [Stencil for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=svanimpe.stencil)
- [Postman](https://www.getpostman.com)
- [Robo 3T](https://robomongo.org)

The following sections contain notes and instructions that can help you recreate the projects on your own. These instructions cover only project setup and configuration. For more information, please see the comments in the source code.

## Example 1: Hello from Kitura

This example covers project initialization, basic routing and rendering [Stencil](https://github.com/stencilproject/Stencil) templates.

> **Note:** If you don't want to recreate this example and just want to run it, execute `swift run` from the project's root directory.

To recreate this example, first initialize an empty project using the Swift Package Manager:

```
mkdir Hello
cd Hello
swift package init --type=executable
```

Then fill in **Package.swift** and generate an Xcode project:

```
swift package generate-xcodeproj
```

Unfortunately, Xcode doesn't (yet) support the Swift Package Manager, so you'll have to regenerate the Xcode project every time you change **Package.swift**.

After opening the Xcode project and before making any changes to the code, first build the project. This makes sure the dependencies are built and available to import. Then edit the current scheme, set the executable and run the app to make sure everything is working fine.

Now draw the rest of the owl.

Don't forget to copy over **Views/index.stencil** as it is needed for one of the routes.

## Example 2: Fcats

This example is a step up from the previous one. Its goal is to show how you can architect a more complex app.

> **Note:** If you don't want to recreate this example and just want to run it, execute `swift run` from the project's root directory.

The app is split into modules to allow for automated testing:

- **Main** is an executable target and contains bootstrap code. It sets up a router and starts the server.
- **Fcats** is a library containing all of the app's functionality.
- **FcatsTests** is a test target for **Fcats**. An example end-to-end test is included.

To recreate this project, start by initializing an empty project:

```
mkdir Fcats
cd Fcats
swift package init --type=executable
```

Before creating an Xcode project, first set up the modules. A **keep.swift** file is added to empty modules so these modules get included in the Xcode project. You can remove these files once you've added actual source files.

```
mkdir Sources/Main
mv Sources/Fcats/main.swift Sources/Main/
touch Sources/Fcats/keep.swift
mkdir Tests/FcatsTests
touch Tests/FcatsTests/keep.swift
```

Now fill in **Package.swift** and generate an Xcode project:

```
swift package generate-xcodeproj
```

As before, first build the project, then set the executable and run the app to make sure everything is working fine.

You can now add the remaining sources. You'll also need to copy over the **public** and **Views** directories.

To run or test the app, you'll need to import the database. Go to the project's root directory and run `mongorestore` to import the **dump** directory and create the **fcats** database. To access this database from Swift, this project uses the excellent [MongoKitten](https://github.com/OpenKitten/MongoKitten) driver.

## Example 3: Fcats (iOS)

This example is a basic iOS app that uses [KituraKit](https://github.com/IBM-Swift/KituraKit) to talk to the Kitura back-end from the previous example.

To use KituraKit, add the following to your **Podfile**:

```
pod 'KituraKit', :git => 'https://github.com/IBM-Swift/KituraKit.git', :branch => 'pod'
```

KituraKit's API mirrors Kitura's codable routing API, making it easy to call your back-end from an iOS app. Its goal is to promote code reuse between front-end and back-end. That's not quite the case yet, as we're waiting for Xcode to support the Swift Package Manager.

> **Note:** If you don't want to recreate this example and just want to run it, execute `pod install` from the project's root directory and then open the generated Xcode workspace.

## Useful links

- [Kitura's home page](https://www.kitura.io) is a good starting point to find documentation.
- [Swift@IBM's Slack channel](http://slack.kitura.io/) is the best place to ask questions and get help.
- [Swift@IBM's GitHub page](https://github.com/IBM-Swift/) is a good way to discover useful libraries.
- [Stencil](https://github.com/stencilproject/Stencil) is Swift's most popular template language.
- [Stencil for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=svanimpe.stencil) is a Visual Studio Code extension that adds syntax highlighting, autocompletion, snippets and indentation support for Stencil.
- [MongoKitten](https://github.com/OpenKitten/MongoKitten) is an excellent Swift driver for MongoDB.
- [KituraKit](https://github.com/IBM-Swift/KituraKit) is an iOS client library for Kitura.
- [Swift Blog](https://github.com/svanimpe/swift-blog) is an example project to help you get started with Kitura and deploy your projects to IBM Cloud.
- [Server-side Swift](https://www.serversideswift.info) is an upcoming conference focused exclusively on server-side Swift.
