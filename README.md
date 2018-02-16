<p align="center">
  <img src="Linker/Configs/logo.png"/>
  <h3 align="center">Linker</h3>
  <p align="center">Lightweight way to handle internal and external URLs in Swift for iOS.</p>
  <p align="center">
    <a href="https://swift.org"><img src="https://img.shields.io/badge/swift-4.0-orange.svg"></a>
    <a href="https://swift.org"><img src="https://img.shields.io/cocoapods/p/Linker.svg?style=flat"></a>
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

To integrate Restofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

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

For complience with type of style, use URLs with format:

`deeplinkshandler://inapp_am?type=subscription&productID=com.examplellc.dlh.7days`

where:

scheme - `deeplinkshandler`,
host   - `inapp_am`,
query  - `type=subscription&productID=com.examplellc.dlh.7days`


If you don't need configuration with complexed behavior, you can use URL without `query`:

`deeplinkshandler://show_subscription_screen`

One special case - handle external URLs when app isn't launched. 

```Swift
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSURL *url = launchOptions[UIApplicationLaunchOptionsURLKey];
    if (url) {
        [DeepLinksHandler handleURL:url withBlock:^(NSURL *url) {
            NSLog(@"Your deelpink is handled");
        }];
        // this 'dispatch_after' necessary to handle your block after swizzling, which happens after [UIApplication sharedApplication] != nil
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [application openURL:url options:@{} completionHandler:nil];
        });
    }
    return YES;
}
```
In other cases of usage you should set your handle block for special URl before calling its from sowewhere.

<b style='color:red'>!!!Notice:</b> Only the last sent block for a unique URL will be executed.

```Swift
static NSString * const kTestHandleURL = @"testurl://viewcontroller?title=ExampleAlert&description=ExampleDescriptionAlert";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [DeepLinksHandler handleURL:[NSURL URLWithString:kTestHandleURL] withBlock:^(NSURL *url) {
        
        NSString *title = nil;
        NSString *description = nil;
        for (NSURLQueryItem *item in [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES].queryItems)
        {
            if ([item.name isEqualToString:@"title"])
                title = item.value;
            else if ([item.name isEqualToString:@"description"])
                description = item.value;
        }
        if (title && description) {
            [[[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
        }
    }];
}

- (IBAction)buttonAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kTestHandleURL] options:@{} completionHandler:nil];
}

@end
```

## Contributing

Issues and pull requests are welcome!

## Author

Maksim Kurpa [@maksim_kurpa](https://twitter.com/maksim_kurpa)

## License

This code is distributed under the terms and conditions of the [MIT license](https://raw.githubusercontent.com/Linker/master/LICENSE). 
