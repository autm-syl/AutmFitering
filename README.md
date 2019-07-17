# AutmFitering
This library is a version update to swift 5.0 of Sharaku library. 
[![CI Status](https://img.shields.io/travis/sylvanas/AutmFitering.svg?style=flat)](https://travis-ci.org/sylvanas/AutmFitering)
[![Version](https://img.shields.io/cocoapods/v/AutmFitering.svg?style=flat)](https://cocoapods.org/pods/AutmFitering)
[![License](https://img.shields.io/cocoapods/l/AutmFitering.svg?style=flat)](https://cocoapods.org/pods/AutmFitering)
[![Platform](https://img.shields.io/cocoapods/p/AutmFitering.svg?style=flat)](https://cocoapods.org/pods/AutmFitering)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Include in your swift header
```ruby
import AutmFitering
```
Using
```ruby
// AutmFiltering, AutmFilteringViewController
let autm = AutmFilteringViewController.init();
autm.imageOrigin = img;
autm.delegate = self
present(autm, animated: true, completion: nil)
```
Delegate
```ruby
extension ViewController:AutmFilteringDelegate {
    func autmFilteringImageDidFilter(image: UIImage) {
        // image output
    }
    func autmFilteringDidCancel() {
        //cancel
    }
}
```

## Requirements

## Installation

AutmFitering is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AutmFitering'
```

## Author

sylvanas, lecuong.bka@gmail.com

## License

AutmFitering is available under the MIT license. See the LICENSE file for more info.
