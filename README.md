# TrAnimate iOS Animation Library

TrAnimate is an iOS animation library designed to make it easy to create complex animations - without using using Core Animation.

## Setting up TrAnimate

### Using CocoaPods - Recommended

If you want to use only stable releases, you should use CocoaPods - see [cocoapods.org](http://cocoapods.org/).

### As a Framework or Module Using Git - Advanced

Alternatively, if you want to use the bleeding edge version - and if you project is using *git*, you can use git's submodule feature, and the subproject feature of Xcode, to add TrAnimate to your project. This also gives you the benefit of being able to update TrAnimate whenever the master branch is updated - which is the bleeding edge of development.

#### Adding a submodule and subproject to your project

Open a terminal and go to the root of your Xcode project and type the following.

    git submodule add https://github.com/trenskow/TrAnimate.git TrAnimate

This will download all sources to a subfolder of your project.

Next drag the TrAnimate.xcodeproject - which is now in the `TrAnimate` folder of your project's root folder - into your project source tree in Xcode.

Then you need to do one of the following two methods to use it in your project.

##### Add as a Module (Xcode 6/iOS 8)

If you want to use the module feature of Xcode 6 and iOS 8, you first you need to add the `TrAnimate.framework` to your application's `Target Dependencies`. This ensures TrAnimate will compile along with your application.

Now you can import TrAnimate as a module in your source code.

    @import TrAnimate

##### Add source headers (Xcode 5/iOS 7 and below)

If you're on Xcode 5 and/or iOS 7 and below, you need to use static linking. You do that by adding `TrAnimate Static` to your application's *Target Dependencies*. Secondly you need to add `libTrAnimate Static.a` to the *Link Binary with Libraries* secton of your application.

Now you can import TrAnimate's umbrella header in your source code.

    #import <TrAnimate/TrAnimate.h>

## Using TrAnimate

### Introduction

TrAnimate uses a set of classes in order to acheive animations. Instead of the Core Animation and UIKit of doing animations - where you specify which properties you want to animate - TrAnimate uses task-based animations. Meaning if you want to fade in a `UIView` or `CALayer` you use the `TrFadeAnimation` class.

The same way goes, if you want to move in a `UIView` from - as an example - outside the screen bounds. In this case you would want to use the `TrMoveAnimation` - which is capable of either moving a `UIView` both in and out.

#### Animations and Transitions

In TrAnimate there are *animations* and *transitions*.

Animations animate a single `UIView` - as an example with the `TrFadeAnimation`.

Transitions animate from one `UIView` to another. An example of a transition is the `TrFlipTransition` which flips one `UIView` to another - replacing the view in the view hierarchy. Transitions are a kind of prepacked group of animations - which execute in a predefined order.

For a list of avalable animations and transition - and for detailed descriptions about them - please refer to the [API Reference](http://cocoadocs.org/docsets/TrAnimate/1.0.3) or the [*TrAnimate Programming Guide*](https://github.com/trenskow/TrAnimate/wiki/).

For more information about groups - see the [*TrAnimate Programming Guide*](http://cocoadocs.org/docsets/TrAnimate/1.0.3).

#### Example

The best introduction is always through code examples. Below is some examples of how to fade in a `UIView` using Objective-C and Swift. There are many more animations available.

##### Objective-C

Below is an example of a fade animation using TrAnimate. The code will fade in `aView` immediately.

    [TrFadeAnimation animate:aView
                    duration:.3
                       delay:.0
                   direction:TrFadeAnimationDirectionIn];

Alternatively all animation's has convenience methods added to `UIView` - as the example below.

    [aView fadeInWithDuration:.3
                        delay:.0];

##### Swift

Below is an example of the above examples implemented in Swift.

    TrFadeAnimation.animate(aView
        duration: 0.3,
        delay: 0.0,
        direction: .In
    )

... or by using the convenience method ...

    aView.fadeIn(0.3, 
        delay: 0.0
    )

### Features in TrAnimate

- A pocket of build-in animations.
- A pocket of build-in transitions.
- The ability to easily create your own animations and transitions.
- Curves (many curves) and custom curves.
- Completion handlers everywhere.
- The ability to group animations and group groups (for complex animation handling and timing).
- Custom interpolation on animations.
- The ability to animate all properties through the `TrDirectAnimation` - not just `UIView` or `CALayer` properties.
- ... and much more.

It is highly recommended that you read the [*TrAnimate Programming Guide*](https://github.com/trenskow/TrAnimate/wiki/) to fully understand how these features work.

### Documentation

#### The API Reference Documentation

The API reference is available at [CocoaDocs](http://cocoadocs.org/docsets/TrAnimate/).

You can alse get the library's reference documentation right at your findertip, by compiling the documentation directly from within Xcode. If you have [appledoc](http://gentlebytes.com/appledoc/) installed on your system, you can build the *Documentation* target of TrAnimate which will compile and install the documentation right into Xcode's *Documentation and API Reference* window.

#### TrAnimate Programming Guide

A programming guide is available at TrAnimate's [Github wiki](https://github.com/trenskow/TrAnimate/wiki).

## About TrAnimate

TrAnimate was created out of the need to create complex animations - without the constant need of also using complex Core Animation setups. The libary was also build to accomodate the lack of available curves provided by Core Animation.

### State of Development

TrAnimate has been spun off from [the application](https://itunes.apple.com/app/kreafunk-listen-to-anything/id807353001?mt=8) from which it origins and made available as an open source project.

TrAnimate is not complete - but it is stable and the API of implemented features are only subject to minor changes. It is constantly developed to add more features.

### Contributing

Contributions are hightly appreciated. Especially for specialized animations. If you have any bug fixes, changes or additions - that you wish to get merged into the library - please send a pull request at *[Github](http://github.com/)*.

### Acknowledgements

All curves has been adapted from the [jQuery UI](https://github.com/jquery/jquery-ui) library. The *jQuery* and *jQuery UI* libraries are designed for browser animations - and as such it provided a rich set of animation curves.

## Notes
TrAnimate requires ARC.
