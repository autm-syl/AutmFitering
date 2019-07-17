# AutmFitering
This library is a version update to swift 5.0 of Sharaku library. 

![sharaku_header](https://github.com/makomori/Sharaku/blob/master/sharaku_header.png)

[![CI Status](https://img.shields.io/travis/sylvanas/AutmFitering.svg?style=flat)](https://travis-ci.org/sylvanas/AutmFitering)
[![Version](https://img.shields.io/cocoapods/v/AutmFitering.svg?style=flat)](https://cocoapods.org/pods/AutmFitering)
[![License](https://img.shields.io/cocoapods/l/AutmFitering.svg?style=flat)](https://cocoapods.org/pods/AutmFitering)
[![Platform](https://img.shields.io/cocoapods/p/AutmFitering.svg?style=flat)](https://cocoapods.org/pods/AutmFitering)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Include in your swift header
``` Swift
import AutmFitering
```
Using
``` Swift
// AutmFiltering, AutmFilteringViewController
let imageToBeFiltered = UIImage(named: "targetImage")
let autm = AutmFilteringViewController.init();
autm.imageOrigin = imageToBeFiltered;
autm.delegate = self
present(autm, animated: true, completion: nil)
```
Delegate
``` Swift
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
- Swift4.2 +
- iOS 10.0+
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
