# Uncomment the next line to define a global platform for your project
platform :ios, '12.1'
deployment_target = '12.1'

install! 'cocoapods', :disable_input_output_paths => true, :warn_for_unused_master_specs_repo => false

use_frameworks!
inhibit_all_warnings!

def all_pods
  
  use_frameworks!
  inhibit_all_warnings!
  
  # UI
  pod 'Eureka', '~> 5.1.0'
  pod 'SnapKit', '~> 5.0.1'
  pod 'SkyFloatingLabelTextField', '~> 3.8.0'
  pod 'SCLAlertView', '~> 0.8.0'
  pod 'ESTabBarController-swift', '~> 2.7'
  pod 'Closures', '~> 0.7'

  # RxSwift
  pod 'RxSwift', '~> 5.0.1'
  pod 'RxCocoa', '~> 5.0.1'
  
  # Networking
  pod 'Moya', '~> 13.0.1'
  pod 'SwiftyJSON', '~> 5.0.0'
  
  # Firebase
  pod 'Firebase', '~> 6.4.0'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'Firebase/Messaging'
  pod 'Firebase/Storage'
  
  # Facebook
  pod 'FBSDKLoginKit', '~> 5.13.1'
  
  # Google OAuth
  pod 'Firebase/Auth'
  pod 'GoogleSignIn', '~> 5.0.2'
  
  # Google Maps
  pod 'GoogleMaps', '~> 3.7.0'
  pod 'GooglePlaces', '~> 3.7.0'
  
  # General
  pod 'R.swift', '~> 5.1.0'
  pod 'ReSwift', '~> 5.0.0'
  
  # Store user data
  pod 'KeychainSwift', '~> 18.0.0'
  pod 'SwiftyUserDefaults', '~> 4.0.0'
  
end

abstract_target 'App' do
  
  target 'FirebaseAuthTraining' do
    all_pods
  end
  
  post_install do |installer|
    
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_BITCODE'] = 'NO' # set 'NO' to disable DSYM uploading - usefull for third-party error logging SDK (like Firebase)
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      end
    end
    
    installer.generated_projects.each do |project|
      project.build_configurations.each do |bc|
        bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
      end
    end
    
  end
  
end
