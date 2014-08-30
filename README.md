# TrAnimate iOS Animation Library

TrAnimate is an iOS animation library designed to make it easy to create complex animations - without using using Core Animation.

## Setting up TrAnimate

### Using CocoaPods

If you want to only use stable releases, you can use CocoaPods - see [cocoapods.org](http://cocoapods.org/). This method is recommended.

### As a Framework or Module Using Git

Alternatively, if you want to be at the bleeding edge - and if you're using git, you can use git's submodule feature, and the subproject feature of Xcode, to add TrAnimate to your project. This also gives you the benefit of being able to update TrAnimate whenever the master branch is updated - which is the bleeding edge of development.

#### Adding a submodule and subproject to your project

Open a terminal and go to the root of your Xcode project and type the following.

    git submodule add https://github.com/trenskow/TrAnimate.git TrAnimate

This will download all sources to a subfolder of your project.

Next drag the TrAnimate.xcodeproject - which is now in the `TrAnimate` folder TrAnimate of your project - into your project source tree in Xcode.

Secondly you need to do one of the following two methods to use it in your project.

##### Add as a Module (iOS 8)

Simply import TrAnimate as a module in your source code.

    @import TrAnimate


##### Add as a Statically Linked Framework (iOS 7 and below)

- Go to the application settings in Xcode
- Choose the "Build Phases" tab.
- Add `TrAnimate Static` to your "Target Dependencies" and add `libTrAnimate Static.a` to your linked binaries.
- Choose the "Build Settings" tab.
- Add the `$(SRCROOT)/TrAnimate` to your "Header Search Paths".

Now import the umbrella header in your sources when you need TrAnimate.

    #import <TrAnimate/TrAnimate.h>

## Using TrAnimate

### Introduction

An example of a fade animation using TrAnimate

    [TrFadeAnimation animate:aView
                    duration:.3f
                       delay:.0f
                   direction:TrFadeAnimationDirectionIn];
    
The above code will fade `aView` immidiately.

Another example could be

    [TrPositionAnimation animate:aView
                        duration:1.0
                           delay:.0f
                      toPosition:CGPointMake(100.0, 100.0)
                          anchor:TrPositionAnimationAnchorAutomatic
                           curve:[TrCurve easeInBounce]
                      completion:^(BOOL finished) {
                          NSLog(@"Move in complete!")
                      }];

This will move `aView` to position `100.0, 100.0`. The curve specifies that `aView` should bounce into place. Lastly the completion block logs `Move is complete!` when the animation is done.

### Documentation

#### The API Reference Documentation

If you need the library's reference documentation right at your findertip, you can compile the documentation from within Xcode. Build the *Documentation* target of TrAnimate - provided you have [appledoc](http://gentlebytes.com/appledoc/) installed on your system - which will compile and install the documentation into Xcode's *Documentation and API Reference* window.

Alternatively the API reference is available at [CocoaDocs](http://cocoadocs.org/docsets/TrAnimate/).

#### TrAnimate Programming Guide

A programming guide is available at TrAnimate's [Github wiki](https://github.com/trenskow/TrAnimate/wiki).

## About TrAnimate

TrAnimate was created out of the need to create complex animations - without the constant need of using complex Core Animation setups. Also to accomodate the lack of available curves provided by Core Animation.

### State of Development

TrAnimate has been spun off from [the application](https://itunes.apple.com/app/kreafunk-listen-to-anything/id807353001?mt=8) from which it origins and made available as an open source project.

TrAnimate is not complete - but it is stable and the API of implemented features are only subject to minor changes. It is constantly developed to add more features.

### Contributing

Contributions are hightly appreciated. Especially for specialized animations. If you have any bug fixes, changes or additions, that you wish to get merged into the library, please send me a pull request at Github.

### Acknowledgements

All curves has been adapted from the [jQuery UI](https://github.com/jquery/jquery-ui) library. The *jQuery* and *jQuery UI* libraries are designed for browser animations - and as such it provided a rich set of animation curves.

## Notes
TrAnimate requires ARC.
