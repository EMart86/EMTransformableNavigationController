#
# Be sure to run `pod lib lint EMTransformableNavigationController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EMTransformableNavigationController'
  s.version          = '1.0.0'
  s.summary          = 'A UINavigationController with Pan and Pinch Gesture Recognition'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This derived UINavigationController with Pinch and Pan Gesture Recognition is designed to be dragged and pinched along on the window. Since you can pinch these navigation controllers, your client can add many small draggable windows and thus let the user design his/her own control window.
                       DESC

  s.homepage         = 'https://github.com/EMart86/EMTransformableNavigationController'
  s.screenshots     = 'https://github.com/EMart86/EMTransformableNavigationController/blob/develop/Example/Bildschirmfoto%202017-08-06%20um%2001.05.55.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Martin Eberl' => 'eberl_ma@gmx.at' }
  s.source           = { :git => 'https://github.com/EMart86/EMTransformableNavigationController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'EMTransformableNavigationController/Classes/**/*'
end
