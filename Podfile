# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'FlashPads (iOS)' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FlashPads (iOS)
	pod 'Firebase/Auth'
	pod 'FBSDKLoginKit'
 	pod 'FBSDKCoreKit'
	pod 'GoogleSignIn'


end

target 'FlashPads (macOS)' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FlashPad (macOS)


end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end