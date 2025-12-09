platform :ios, '13.0'

target 'TrukmenAdmin' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
   pod 'PanModal'
   pod "ViewAnimator"
   pod 'Alamofire', '~> 4.4'
   pod 'AlamofireObjectMapper'
   pod 'ObjectMapper', '~> 3.3'
   pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
   pod 'ImageTextField','~> 1.0.0' 
   pod 'ImageTextField','~> 1.0.0'
   pod 'MaterialComponents/TextFields'
   pod "WOWCheckbox"
   pod 'LGButton'
   pod 'lottie-ios'
   pod 'SideMenu'
   pod 'GooglePlaces'
   pod 'GoogleMaps'
   pod 'Starscream', '~> 4.0.0'
   pod 'SwiftyJSON', '~> 4.0'
   pod 'FSnapChatLoading'
   pod 'Serpent', '~> 1.0' # Just core
   pod 'Serpent/Extensions', '~> 1.0' # Includes core and all extensions
   pod 'Serpent/AlamofireExtension', '~> 1.0' # Includes core and Alamofire extension
   pod 'Serpent/CashierExtension', '~> 1.0' # Includes core and Cashier extension
   pod 'MarqueeLabel'     
   pod 'Polyline', '~> 5.0'
   pod 'Toast', '~> 4.0.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end
  
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end
