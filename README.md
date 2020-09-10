# Chefaa. 
Clean architecture Concepts with MVVM and [RxSwift](https://github.com/ReactiveX/RxSwift)

### Installation

Dependencies in this project are provided via Cocoapods. Please install all dependecies with

`
pod install
`

## High level overview

#### Domain 


The `Domain` is basically what is Chefaa's App about and what it can do (Entities, UseCase etc.) **It does not depend on UIKit or any persistence framework**, and it doesn't have implementations apart from entities

#### Platform

The `Platform` is a concrete implementation of the `Domain` in a specific platform like iOS. It does hide all implementation details. For example Database implementation whether it is CoreData, Realm, SQLite etc.

#### Application
`Application` is responsible for delivering information to the user and handling user input. It can be implemented with any delivery pattern e.g (MVVM, MVC, MVP). This is the place for your `UIView`s and `UIViewController`s. As you will see from the example app, `ViewControllers` are completely independent of the `Platform`.  The only responsibility of a view controller is to "bind" the UI to the Domain to make things happen. In fact, in the current example we are using the same view controller for Realm and CoreData.

## Detail overview
To enforce modularity, `Domain`, `Platform` and `Application` are separate targets in the App, which allows us to take advantage of the `internal` access layer in Swift to prevent exposing of types that we don't want to expose.

#### Domain

Entities are implemented as Swift value types

```swift
public struct Item {
    public let id: Int
    public let title: String
    public let images: [String]
    public let price: Double
}
```

UseCases are protocols which do one specific thing:

```swift

public protocol AdvertisementsUseCase {
    func homeComponents() -> Observable<HomeComponentsTypeAlias>
}

```

`UseCaseProvider` is a [service locator](https://en.wikipedia.org/wiki/Service_locator_pattern).  In the current app, it helps to hide the concrete implementation of use cases.

#### Platform

The `Platform` also contains concrete implementations of your use cases, repositories or any services that are defined in the `Domain`.

```swift
final class AdvertisementsUseCase: Domain.AdvertisementsUseCase {
    private let network: HomeNetwork

    init(network: HomeNetwork) {
        self.network = network
    }
    
    func homeComponents() -> Observable<(sliders: [SliderAdvertisement], subCategories: [SubCategory], brands: [Brand], items: [Item], landingPages: [LandingPage])> {
        let homeComponents = network.fetchHome().flatMap { home -> Observable<(sliders: [SliderAdvertisement], subCategories: [SubCategory], brands: [Brand], items: [Item], landingPages: [LandingPage])> in
            
            guard let brands = home.data?.brands,
                let sliders = home.data?.slider,
                let subCategories = home.data?.subCategories,
                let items = home.data?.bestselling,
                let landingPages = home.data?.landingPages else {
                    return Observable.of((sliders: [], subCategories: [], brands: [], items: [], landingPages: []))
            }
            
            return Observable.of((sliders: sliders, subCategories: subCategories, brands: brands, items: items, landingPages: landingPages))
        }
        
        return homeComponents
    }
    
}
```

As you can see, concrete implementations are internal, because we don't want to expose our dependecies. The only thing that is exposed in the current app from the `Platform` is a concrete implementation of the `UseCaseProvider`.

```swift
public final class UseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeAdvertisementsUseCase() -> Domain.AdvertisementsUseCase {
        return AdvertisementsUseCase(network: networkProvider.makeHomeNetwork())
    }
}
```

#### Application

In the current example, `Application` is implemented with the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern and heavy use of [RxSwift](https://github.com/ReactiveX/RxSwift), which makes binding very easy.

Where the `ViewModel` performs pure transformation of a user `Input` to the `Output`

```swift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
```


```swift
final class HomeViewModel: ViewModelType {
    
    // MARK: - ViewModel Inputs
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    // MARK: - ViewModel Outputs
    
    struct Output {
        let fetching: Driver<Bool>
        let homeAds: Driver<HomeComponentsViewModelsTypeAlias>
        let error: Driver<Error>
    }
    
    // MARK: - Properties
    
    private let useCase: AdvertisementsUseCase
    private let navigator: HomeNavigator
    
    // MARK: - Init
    
    init(useCase: AdvertisementsUseCase, navigator: HomeNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    // MARK: - ViewModel Transformation
    
    func transform(input: Input) -> Output {
        ....
    }
}

```

A `ViewModel` can be injected into a `ViewController` via property injection or initializer. In the current app, this is done by `Navigator`.

```swift

protocol HomeNavigator {
    func toHome()
}

class DefaultHomeNavigator: HomeNavigator {
    
    // MARK: - Properties
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider

    // MARK: - Init
    
    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    // MARK: - HomeNavigator Functions
    
    func toHome() {
        let viewController = storyBoard.instantiateViewController(ofType: HomeViewController.self)
        viewController.viewModel = HomeViewModel(
            useCase: services.makeAdvertisementsUseCase(),
            navigator: self
        )
        navigationController.pushViewController(viewController, animated: true)
    }

}

class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: HomeViewModel!
    
    ...
}
```

### Modularization

The corner stone of **Clean Architecture** is modularization, as you can hide implementation detail under `internal` access layer. Further read of this topic [here](https://tuist.io/docs/usage/microfeatures/)

### Links
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxSwift Book](https://store.raywenderlich.com/products/rxswift)
* [Robert C Martin - Clean Architecture and Design](https://www.youtube.com/watch?v=Nsjsiz2A9mg)
* [ViewModel](https://medium.com/@SergDort/viewmodel-in-rxswift-world-13d39faa2cf5#.qse37r6jw) in Rx world

### Any questions?

* Message me on [Facebook](https://www.facebook.com/KarimEbrahemAbdelaziz/)
