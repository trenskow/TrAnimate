(This documentation is very preliminary)

# TrAnimation iOS Animation Library

TrAnimate is an iOS animation library designed to make it easy to create complex animations, without the need for using Core Animation.

## Setting up TrAnimate

There are two ways of incorporating TrAnimate into your project. First is to copy all sources into your current project and include the headers by adding the following.

    #inport "TrAnimate.h"

### Using Git

Alternatively you can use git's submodule feature and the subproject feature of Xcode to incorporate TrAnimate into your project. This also gives you the benefit of being able to update TrAnimate whenever the master branch is updated. A simple pull gives you the latest and greatest features from the TrAnimate repository.

#### Adding a submodule and subproject to your project

1. Open a terminal and go to the root of your project Xcode project, and type the following.
   - `git submodule add https://github.com/trenskow/TrAnimate.git TrAnimate`
   - This will add TrAnimate as a subproject and download all sources from Github.
2. Drag the TrAnimate.xcodeproject (which is now in the subfolder TrAnimate of your project) into your project source tree in Xcode.
3. Go to the application settings in Xcode
   - Choose the "Build Phases" tab.
      - Add TrAnimate to your "Target Dependencies" and add libTrAnimate.a to your linked binaries.
   - Choose the "Build Settings" tab.
     - Add the following to your "Header Search Paths".
       - `$(SRCROOT)/TrAnimate`

Now you are setup for using TrAnimate.

Whenever you need TrAnimate simple import the headers like this.

    #import <TrAnimate/TrAnimate.h>

## Using TrAnimate

### Introduction

An example of using TrAnimate

    [TrFadeAnimation animateWithView:aView
                            duration:.3f
                               delay:.0f
                             fadesIn:YES];
    
This code fades the view in immidiately.

Another example could be

    [TrMoveInAnimation animateWithView:aView
                              duration:1.0f
                                 delay:.0f
                               options:kTrMoveInAnimationOptionDirectionTop
                                 curve:kTrAnimationCurveEaseOutBounce
                            completion:^(BOOL finished) {
    	                        NSLog(@"Move in complete!")
                            }];

This will move in the view from it's superview's bounds. The curve specifies, that the view should bounce out.

### Available animations

The individual animations has special creation methods available. Look in the header files of each animation to see how to create them.

#### TrMoveAnimation

Moves a view from one location to another, not affecting the views size.

#### TrMoveInAnimation

Moves a view into screen. You specify using the option from which direction the view should appear. By default it moves from outside it's superview's bounds and into it's initial location. Specifying the kTrMoveInAnimationOptionFromScreenBounds moves the view from outside the screen's bounds.

The same animation is used to move a view out. Specifying the kTrMoveInAnimationOptionReversed options will reverse the animation.

#### TrFadeAnimation

Fades in a view. The fadeIn parameter specifies, if the view fades in or out.

#### TrFlipAnimation

This flips a view. Either flipping the view 180 degrees or flipping from one view to another. The creation methods determines if it's a single view flip or from one view to another.

#### TrZoomAnimation

Zooms the view from a start value to an end value.

#### TrRotateAnimation

Rotates the view around the Z-axis from a start value to an end value.

### Curves

#### Predefined Curves

Many animations support custom animation curves. Curves are implemented using blocks, but there are some predefined curves, which is adapted from [jQuery UI](https://github.com/jquery/jquery-ui). Not all of the curves has yet been implemented, but they are pretty easy to implement yourself.

Amongst the predefined curves are:

- `kTrAnimationCurveLinear`
- `kTrAnimationCurveEaseInSine`
- `kTrAnimationCurveEaseOutSine`
- `kTrAnimationCurveEaseInOutSine`
- `kTrAnimationCurveEaseOutBounce`
- `kTrAnimationCurveEaseInExpo`
- `kTrAnimationCurveEaseOutExpo`
- `kTrAnimationCurveInBack`
- `kTrAnimationCurveOutBack`
- `kTrAnimationCurveInOutBack`
- `kTrAnimationCurveOutElastic`

For a visual representation of the curves please see [easings.net](http://easings.net/).

#### Custom Curves

Custom curves can be implented like this.

    ^(CGFloat t) {
    	return (CGFloat) (-1.0f * cos(t * M_PI_2) + 1.0f);
    };

Above is the actual implementation of the `kTrAnimationCurveEaseInSine` curve. The parameter t represents a value between 0.0 and 1.0. Animation block must return a CGFloat.

In the same way custom curves can be used directly in animations that support it.

    [TrRotateAnimation animateView:aView
                          duration:.3f
                             delay:.0f
                        startAngle:.0f
                          endAngle:M_PI_4
                             curve:^(CGFloat t) {
                                 return (CGFloat)t / 2.0f
                             }
                         completed:nil];

The above will rotate `aView` from zero radians to M_PI_4. But the curve provided will effectively half the endAngle because `t` is devided a factor of 2.

### Animation Groups

Animation groups allow you to group animations and determine when which animations should run. It allows you to group other animation groups, and really is a powerful tool.

(This documentation will be updated to explain in more details how animation groups work).tr

## About TrAnimate

TrAnimate was created out of the need to create complex animations, without the constant need of using complex Core Animation setups. Also to accomodate the lack of custom interpolation and curves provided by Core Animation.

### State of Development

TrAnimate has been spun off from the application from which it origins and made available as an open source project.

TrAnimate is **not** complete. Lot's of features are still to be added, and lots of useful animations and curves are currently not yet implemented.

### Contribution

Contributions are always appreciated. Especially for specialized animations and curves. If you have any additions, that you wish to have incorporated into the library, please make a pull request against the *dev* branch.

### Acknowledgements

All curves has been adapted from the [jQuery UI](https://github.com/jquery/jquery-ui) library. The *jQuery* and *jQuery UI* libraries are designed for high quality browser interaction and animations, and provide a rich set of animation curves. Some [jQuery UI animation curves](http://easings.net/) are yet to be implemented into TrAnimate.

## Notes
TrAnimate requires ARC (Automatic Reference Count) enabled.
