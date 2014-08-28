(A programming guide is currently being written)

# TrAnimate iOS Animation Library

TrAnimate is an iOS animation library designed to make it easy to create complex animations, without the need for using Core Animation.

## Setting up TrAnimate

### By Copying Source Files

There are three ways of incorporating TrAnimate into your project. First is to copy all sources into your current project and include the headers by adding the following.

    #import "TrAnimate.h"

### Using CocoaPods

See [cocoapods.org](http://cocoapods.org/).

### As a Framework or Module Using Git

Alternatively you can use git's submodule feature and the subproject feature of Xcode to incorporate TrAnimate into your project - givin' it uses git. This also gives you the benefit of being able to update TrAnimate whenever the master branch is updated. A simple pull gives you the latest and greatest features from the TrAnimate repository.

#### Adding a submodule and subproject to your project

Open a terminal and go to the root of your Xcode project and type the following.

    git submodule add https://github.com/trenskow/TrAnimate.git TrAnimate`.

This will add TrAnimate as a subproject and download all sources from Github.

Next drag the TrAnimate.xcodeproject (which is now in the subfolder TrAnimate of your project) into your project source tree in Xcode.

##### Add as a Module (iOS 8)

Simply add it as a module to your sources by importing the module in your sources.

    @import TrAnimate


##### Add as a Statically Linked Framework (iOS 7 and below)

- Go to the application settings in Xcode
   - Choose the "Build Phases" tab.
      - Add `TrAnimate Static` to your "Target Dependencies" and add `libTrAnimate Static.a` to your linked binaries.
   - Choose the "Build Settings" tab.
     - Add the following to your "Header Search Paths".
       - `$(SRCROOT)/TrAnimate`

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

This will move `aView` to position 100.0, 100.0. The curve specifies that `aView` should bounce out. Lastly the completion block logs `Move is complete!` when the animation completes.

### Available animations

The individual animations has special creator methods available. Look in the documentation of each animation to see how to create them.

#### TrPositionAnimation

Moves a view from one location to another, not affecting the view's size.

#### TrFadeAnimation

Fades in a view. The view can either fade in or out.

#### TrOpacityAnimation

Changes the opacity of a view.

#### TrScaleAnimation

Scale a view from an optional start value to an end value.

#### TrRotateAnimation

Rotates the view around an axies from an optional start value to an end value.

#### TrLayerAnimation

This is for all your animation needs on `CALayer` not avaiable above. `TrLayerAnimation` takes a `CALayer` and a key path and animates it.

#### TrDirectAnimation

`TrDirectAnimation` animates without the use of Core Animation and is therefore useful if you want to animate properties of objects not supported by Core Animation. An example could be the `contentOffset` of a `UIScrollView` or even the `volume` property of a `AVAudioPlayer`.

### Curves

#### Predefined Curves

All animations support custom animation curves. Curves are implemented using blocks, but there are some build-in curves which is adapted from [jQuery UI](https://github.com/jquery/jquery-ui). A curve is represented using the `TrCurve` class which has also holds the build-in curves.

The build-in curves are:

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/linear.png" alt="linear" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInQuad.png" alt="easeInQuad" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutQuad.png" alt="easeOutQuad" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutQuad.png" alt="easeInOutQuad" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInCubic.png" alt="easeInCubic" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutCubic.png" alt="easeOutCubic" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutCubic.png" alt="easeInOutCubic" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInQuart.png" alt="easeInQuart" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutQuart.png" alt="easeOutQuart" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutQuart.png" alt="easeInOutQuart" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInQuint.png" alt="easeInQuint" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutQuint.png" alt="easeOutQuint" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutQuint.png" alt="easeInOutQuint" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInSine.png" alt="easeInSine" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutSine.png" alt="easeOutSine" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutSine.png" alt="easeInOutSine" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInExpo.png" alt="easeInExpo" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutExpo.png" alt="easeOutExpo" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutExpo.png" alt="easeInOutExpo" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInCirc.png" alt="easeInCirc" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutCirc.png" alt="easeOutCirc" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutCirc.png" alt="easeInOutCirc" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInElastic.png" alt="easeInElastic" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutElastic.png" alt="easeOutElastic" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutElastic.png" alt="easeInOutElastic" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInBack.png" alt="easeInBack" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutBack.png" alt="easeOutBack" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutBack.png" alt="easeInOutBack" />

<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInBounce.png" alt="easeInBounce" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeOutBounce.png" alt="easeOutBounce" />
<img src="https://raw.githubusercontent.com/trenskow/TrAnimate/master/assets/curves/easeInOutBounce.png" alt="easeInOutBounce" />

#### Custom Curves

Custom curves can be implemeted either by subclassing `TrCurve` and overriding the `transform:` method - or they can be created using blocks as below.

    [TrCurve curveWithBlock:^(double t) {
    	return (-1.0 * cos(t * M_PI_2) - 1.0);
    }];

Above is the actual implementation of the `[TrCurve easeInSine]` curve. The parameter t represents a value between 0.0 and 1.0. Animation blocks must return a `double`.

In the same way custom curves can be used directly in animations as below.

    [TrRotateAnimation animateView:aView
                          duration:.3f
                             delay:.0f
                           toAngle:M_PI_4
                              axis:TrRotateAnimationAxisZ
                             curve:[TrCurve curveWithBlock:^(double t) {
                                 return t / 2.0;
                             }]];

The above will rotate `aView` from zero radians to M_PI_4. But the curve provided will effectively half the endAngle because `t` is divided by `2`.

### Animation Groups

Animation groups allow you to group animations and determine when which animations should run. It allows you to group other animation groups and really is a powerful tool for chaining animations.

(This documentation will be updated to explain in more details how animation groups work)

## About TrAnimate

TrAnimate was created out of the need to create complex animations without the constant need of using complex Core Animation setups. Also to accomodate the lack of custom interpolation and curves provided by Core Animation.

### State of Development

TrAnimate has been spun off from the application from which it origins and made available as an open source project. The application in question is the KREAFUNK app - download it on the [App Store](https://itunes.apple.com/app/kreafunk-listen-to-anything/id807353001?mt=8))

TrAnimate is **not** complete. It is constantly developed to add more features. Transitions are currently in the process of being implemented.

### Contribution

Contributions are always appreciated. Especially for specialized animations. If you have any additions, that you wish to have incorporated into the library please create a pull request.

### Acknowledgements

All curves has been adapted from the [jQuery UI](https://github.com/jquery/jquery-ui) library. The *jQuery* and *jQuery UI* libraries are designed for high quality browser interaction and animations, and provide a rich set of animation curves.

## Notes
TrAnimate requires ARC.
