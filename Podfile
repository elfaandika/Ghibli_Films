# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Ghibli_Films' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

    pod 'RxSwift', '6.1.0'
    pod 'RxCocoa', '6.1.0'

  target 'Ghibli_FilmsTests' do
    inherit! :search_paths
    pod 'RxBlocking', '6.1.0'
    pod 'RxTest', '6.1.0'
  end

  target 'Ghibli_FilmsUITests' do
    pod 'RxBlocking', '6.1.0'
    pod 'RxTest', '6.1.0'
  end

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
  end
 end
end