<p align="center">
  <img src="Linker/Configs/logo.png"/>
  <h3 align="center">Linker</h3>
  <p align="center">Lightweight way to handle internal and external URLs in Swift for iOS.</p>
  <p align="center">
    <a href="https://swift.org"><img src="https://img.shields.io/badge/swift-4.0-orange.svg"></a>
    <a href="https://github.com/MaksimKurpa/Linker"><img src="https://img.shields.io/cocoapods/p/Linker.svg"></a>
    <a href="https://cocoapods.org/pods/Linker"><img src="https://travis-ci.org/MaksimKurpa/Linker.svg?branch=master"></a>
    <a href="https://github.com/MaksimKurpa/Linker"><img src="https://img.shields.io/cocoapods/v/Linker.svg"></a>
    <a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
	<a href="https://raw.githubusercontent.com/Linker/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/Linker.svg"></a>
  </p>
</p>


---


## Installation

### Dependency Managers
<details>
  <summary><strong>CocoaPods</strong></summary>

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Linker into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Linker'
```

Then, run the following command:

```bash
$ pod install
```

</details>

<details>
  <summary><strong>Carthage</strong></summary>

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Linker into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Linker/Linker"
```

</details>

## Usage

(see sample Xcode project Demo)

The main thought of this framework is useful and convenient handling of external and internal URLs in your iOS application. Linker provides only one function to install your own handler to specific URL. A dependency between specific URL and your closure is based on `scheme` and `host` of each URL. That is you can configure miscellaneous behavior for different components of specific URL. You can split hadling by `query` with different parameters and/or by `path`, `fragment`.
<details>
  <summary><strong>Realization details</strong></summary>
On start of your application occurs swizzling methods in `UIApplication` and `UIApplicationDelegate` of your application. Original implementation exchanged on Linker implementation, where occur handle process. If Linker con't handle specific URL, original implementation of this method will be called.

Swizzled methods:

UIApplication.shared - openURL:options:completionHandler:
UIApplication.shared - openURL: (deprecated since iOS 10.0)

UIApplication.shared.delegate - application:openURL:options:
UIApplication.shared.delegate - application:openURL:sourceApplication:annotation: (deprecated since iOS 9.0)
UIApplication.shared.delegate - application:handleOpenURL: (deprecated since iOS 9.0)
</details>

For complience with URL style, use format:

`linker://inapp_am/buy_subscription?type=subscription&productID=com.yourLLC.yourapp.7days_trial#test`

where:

scheme   - `linker`,
host     - `inapp_am`,
query    - `type=subscription&productID=com.yourLLC.yourapp.7days_trial`
path     - `buy_subscription`
fragment - `test`

If you don't need configuration with complexed behavior, you can use URL without `query`:

`linker://show_subscription_screen`

One special case - handle external URLs when app isn't launched. After installation closure to specific URL you should call any func from `UIAppication` or `UIApplicationDelegate`, which process URLs. For example, func
'`openURL:options:completionHandler:` in `UIApplication`.

```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let launchURL = launchOptions?[UIApplicationLaunchOptionsKey.url] as? URL {
            Linker.handle(launchURL, closure: { url in
                print("Your URL has been handle!")
            })
            _ = [UIApplication.shared.open(launchURL, options: [:], completionHandler: nil)]
        }
        return true
    }
```
In other cases of usage you should set your handle closure for special URl before calling its from somewhere.


<h5> (!) Notice: Only the last sent closure for a unique URL will be executed.</h5>

```Swift
class ViewController: UIViewController {
    
    let sourceURL = URL(string: "linker://viewcontroller?title=ExampleAlert&description=ExampleDescriptionAlert")!

    @IBAction func action(_ sender: Any) {
        UIApplication.shared.open(sourceURL, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Linker.handle(sourceURL) { url in
        
            guard let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems! else {
                return }
            var title : String? = nil
            var description: String? = nil
            
            for item in queryItems {
                if item.name == "title" {
                    title = item.value
                }
                if item.name == "description" {
                    description = item.value;
                }
            }
            
            if let name = title, let message = description {
                let alertVC = UIAlertController(title: name, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {action in
                    alertVC.dismiss(animated: true, completion: nil)
                }))
                self.present(alertVC, animated: false, completion: nil)
            }
        }
    }
}
```

## Contributing

Issues and pull requests are welcome!

## Author

Maksim Kurpa - [@maksim_kurpa](https://twitter.com/maksim_kurpa)

## License

This code is distributed under the terms and conditions of the [MIT license](https://raw.githubusercontent.com/MaksimKurpa/Linker/master/LICENSE). 
