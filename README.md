# SFPPredicateDSL

[![CI Status](http://img.shields.io/travis/SiarheiFedartsou/SFPPredicateDSL.svg?style=flat)](https://travis-ci.org/SiarheiFedartsou/SFPPredicateDSL)
[![Version](https://img.shields.io/cocoapods/v/SFPPredicateDSL.svg?style=flat)](http://cocoapods.org/pods/SFPPredicateDSL)
[![License](https://img.shields.io/cocoapods/l/SFPPredicateDSL.svg?style=flat)](http://cocoapods.org/pods/SFPPredicateDSL)
[![Platform](https://img.shields.io/cocoapods/p/SFPPredicateDSL.svg?style=flat)](http://cocoapods.org/pods/SFPPredicateDSL)

Allows to work with NSPredicate's in much safer manner with compile-time checks. For example instead of this:
```objc
[NSPredicate predicateWithFormat:@"keypath == %@ AND keypath2 IN %@", @10, @[@1, @2, @3]]
```
you can just write:
```objc
[NSPredicate predicate:where(@"keypath").equals(@10).and.where(@"keypath2").in(@[@1, @2, @3])]
```
For more examples of usage see specs.

## Installation

SFPPredicateDSL is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SFPPredicateDSL"
```

## Author

Siarhei Fiedartsou, siarhei.fedartsou@gmail.com

## License

SFPPredicateDSL is available under the MIT license. See the LICENSE file for more info.
