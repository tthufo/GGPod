#
# Be sure to run `pod lib lint GGPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GGPod'
  s.version          = '0.1.0'
  s.summary          = 'A short description of GGPod.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Simple GG plugin for personal use

                       DESC

  s.homepage         = 'https://github.com/tthufo@gmail.com/GGPod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tthufo@gmail.com' => 'tthufo@gmail.com' }
  s.source           = { :git => 'https://github.com/tthufo@gmail.com/GGPod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

s.source_files = 'GGPod/Classes'

s.public_header_files = 'GGPod/Classes/*.h'

s.static_framework = true

s.dependency 'GoogleSignIn', '~> 4.1'

s.dependency 'SVProgressHUD'

s.pod_target_xcconfig = {
    "OTHER_LDFLAGS" => '$(inherited) -framework "GoogleSignIn"',
    "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => 'YES',
    "FRAMEWORK_SEARCH_PATHS" => '$(inherited) "${PODS_ROOT}/GoogleSignIn/Frameworks"'
}

end
