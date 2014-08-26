Pod::Spec.new do |s|
  s.name             = "TrAnimate"
  s.version          = "1.0.1"
  s.summary          = "An animation library for iOS."
  s.description      = <<-DESC
                       TrAnimate is an iOS animation library designed to make it easy to create complex animations without the need for Core Animation.
                       DESC
  s.homepage         = "https://github.com/trenskow/TrAnimate"
  s.license          = { :type => "BSD 2-Clause", :file => "LICENSE" }

  s.author           = "Kristian Trenskow"
  s.social_media_url = "https://twitter.com/trenskow"

  s.platform         = :ios, "6.0"
  s.source           = { :git => "https://github.com/trenskow/TrAnimate.git", :tag => "1.0.0" }

  s.source_files     = "TrAnimate/*.{h,m}"

  s.public_header_files = "TrAnimate/TrFadeAnimation.h", "TrAnimate/TrDirectAnimation.h", "TrAnimate/TrInterpolatable.h", "TrAnimate/CALayer+TrAnimateAdditions.h", "TrAnimate/TrScaleAnimation.h", "TrAnimate/TrOpacityAnimation.h", "TrAnimate/UIView+TrAnimateAdditions.h", "TrAnimate/TrAnimationGroup.h", "TrAnimate/TrAnimatable.h", "TrAnimate/TrRotateAnimation.h", "TrAnimate/TrAnimate.h", "TrAnimate/TrAnimation.h", "TrAnimate/NSNumber+TrAnimateAdditions.h", "TrAnimate/NSValue+TrAnimateAdditions.h", "TrAnimate/TrPositionAnimation.h", "TrAnimate/TrLayerAnimation.h"
  
  s.framework  = "QuartzCore", "UIKit", "Foundation"
  s.requires_arc = true
end
