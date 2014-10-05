# TrAnimate iOS Animation Library

TrAnimate is an iOS animation library designed to make it easy to create complex animations - without the use of Core Animation.

## Setting up TrAnimate

### Using CocoaPods - Recommended

If you want to use only stable releases, you should use CocoaPods - see [cocoapods.org](http://cocoapods.org/).

### As a Framework or Module Using Git - Advanced

Alternatively, if you want to use the bleeding edge version - and if you project is using *git*, you can use git's submodule feature, and the subproject feature of Xcode, to add TrAnimate to your project. This also gives you the benefit of being able to update TrAnimate whenever the master branch is updated - which is the bleeding edge of development.

#### Adding a submodule and subproject to your project

Open a terminal and go to the root of your Xcode project and type the following.

    git submodule add https://github.com/trenskow/TrAnimate.git TrAnimate

This will download all sources to the `TrAnimate` subfolder of your project.

Next drag the TrAnimate.xcodeproject - which is now in the `TrAnimate` folder of your project's root folder - into your project source tree in Xcode.

Then you need to do one of the following two methods to use it in your project.

##### Usage a Module (Xcode 6/iOS 8)

If you want to use the module feature of Xcode 6 and iOS 8, you first you need to add the `TrAnimate.framework` to your application's `Target Dependencies`. This ensures TrAnimate will compile along with your application.

Now you can import TrAnimate as a module in your source code.

    @import TrAnimate

##### Using the Umbrella Header (Xcode 5/iOS 7 and below)

If you're on Xcode 5 and/or iOS 7 and below, you need to use static linking. You do that by adding `TrAnimate Static` to your application's *Target Dependencies*. Secondly you need to add `libTrAnimate Static.a` to the *Link Binary with Libraries* section of your application.

Now you can import TrAnimate's umbrella header in your source code.

    #import <TrAnimate/TrAnimate.h>

## Using TrAnimate

### Introduction

TrAnimate uses a set of classes in order to achieve animations. Instead of the Core Animation and UIKit's way of doing animations - where you specify which properties you want to animate - TrAnimate uses task-oriented animations. Meaning if you want to fade in a `UIView` or `CALayer` you use the `TrFadeAnimation` class.

The same way goes, if you want a `UIView` to move in from - as an example - outside the screen bounds, you would want to use the `TrMoveAnimation` - which is capable of either moving a `UIView` both in and out.

#### Animations and Transitions

In TrAnimate there are *animations* and *transitions*.

Animations animate a single `UIView` - as an example with the `TrFadeAnimation`.

Transitions animate from one `UIView` to another - replacing the original view in the view hierarchy. An example of this is the `TrFlipTransition` which flips one `UIView` to another. Transitions are a kind of pre-packed group of animations - which execute in a predefined order - see more below.

For a list of available animations and transition - and for detailed descriptions about them - please refer to the [API Reference](http://cocoadocs.org/docsets/TrAnimate/) or the [*TrAnimate Programming Guide*](https://github.com/trenskow/TrAnimate/wiki/).

For more information about groups - see the [*TrAnimate Programming Guide*](http://cocoadocs.org/docsets/TrAnimate/).

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

### Features of TrAnimate

TrAnimate provides a rich set of features. Stuff like animating basic animations such as fading, custom animations, transitions, complex animation chains, and more...

It is highly recommended that you read the [*TrAnimate Programming Guide*](https://github.com/trenskow/TrAnimate/wiki/) to fully understand how these features work.

#### Build-in Animations

There are a handful of build-in animations. The list of animations is not complete - more will be added through time.

The basic animations are `TrOpacityAnimation`, `TrPositionAnimation`, `TrScaleAnimation` and `TrRotateAnimation`. Each of these does - as their name implies - basic property animation. If non of these satisfy your needs, the `TrLayerAnimation` is able to animate any property of a `CALayer` instance.

There are also some build-in variants of these animation - such as `TrFadeAnimation`, `TrMoveAnimation` and `TrPopAnimation`.

All the above animations supports custom or build-in curves and/or custom interpolation.

#### Build-in Transitions

Transitions are used to transition one `UIView` object to another. The list of transitions - as with the list of animations - is not complete - more will be added through time.

Currently TrAnimate has a `TrFadeTransition`, `TrPushTransition` and a `TrFlipAnimation`.

All the above support custom or build-in curves.

See the [TrAnimate API reference](http://cocoadocs.org/docsets/TrAnimate/) or the [*TrAnimate Programming Guide*](https://github.com/trenskow/TrAnimate/wiki/) for more information on how each of these work.

#### Custom Animations

TrAnimate supports custom animation by either subclassing existing animations - or creating objects that implements the `TrAnimation` protocol.

#### Curves

TrAnimate has many build-in curves. Actually it implements of the curves of [JQuery UI](http://www.easings.net). On top of that custom curves can be utilized using blocks.

#### Custom Interpolation

Does the build-in interpolation not satisfy your needs? Does your rotation animation rotate in the wrong direction. Many animations support custom interpolation. This means that you can provide a block that takes care of interpolating from one value to another. 

You would also use custom interpolation if you are animating a data type not supported by TrAnimate.

#### Completion Handlers

In TrAnimate there are completion handlers everywhere. Any animation, any transition, any group can have it's own completion handler, meaning you have total control - also within complex animations - to do last minute adjustments and logic.

#### Groups

*Groups* are a very powerful tool of TrAnimate. It allows you to group animations and do daisy-chaining. It is actually quite useful when dealing with complex animations and you want to move your animation code outside your logic - for instance your view controllers.

All build-in transitions are implemented using groups.

#### Direct Animations

Direct animations allows you to animate otherwise non-animatable content. It uses a display link instead of Core Animation to do it's animation. As an example this could be the `volume` property of a `AVAudioPlayer` object.

Direct animations are utilized using the `TrDirectAnimation` class.

#### Categories Everywhere

As mentioned in the example above, all animations has convenience methods applied through categories. `TrFadeAnimation` provides the `fadeIn:` method of `UIView` and `TrDirectAnimation` provides a `setValue:forKeyPath:duration:delay:curve:` on `NSObject`.

### Documentation

#### The API Reference Documentation

The API reference is available at [CocoaDocs](http://cocoadocs.org/docsets/TrAnimate/).

##### In Xcode

You can also get the library's reference documentation right at your fingertip, by compiling the documentation directly from within Xcode. If you have [appledoc](http://gentlebytes.com/appledoc/) installed on your system, you can build the *Documentation* target of TrAnimate which will then compile and install the documentation right into Xcode's *Documentation and API Reference* window.

#### TrAnimate Programming Guide

A programming guide is available at TrAnimate's [Github wiki](https://github.com/trenskow/TrAnimate/wiki).

## About TrAnimate

TrAnimate was created out of the need to create complex animations - without the constant need of also using complex Core Animation setups. The library was also build to accommodate the lack of available curves provided by Core Animation.

### State of Development

TrAnimate is not complete - but it is stable and the API of implemented features are only subject to minor changes. It is constantly developed to add more features.

### Contributing

Contributions are highly appreciated. Especially for specialized animations. If you have any bug fixes, changes or additions - that you wish to get merged into the library - please send a pull request at *[Github](http://github.com/)*.

Please make sure your code is proper documented - see the headers of TrAnimate for a guideline of the level of documentation needed.

### Acknowledgements

All curves has been adapted from the [jQuery UI](https://github.com/jquery/jquery-ui) library. The *jQuery UI* libraries are designed for browser animations - and as such it provides a rich set of curves.

## Notes
TrAnimate requires ARC.
