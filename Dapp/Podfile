# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!

def common_pods
  pod 'Realm', '~> 3.20.0'
  pod 'RealmSwift', '~> 3.20.0'
  pod 'web3.swift', '0.3.4'

end

post_install do |installer|
  # installer.pods_project.targets.each do |target|
  #   if ['Alamofire', 'ObjectMapper', 'FacebookLogin', 'Pulsator'].include? target.name
  #     target.build_configurations.each do |config|
  #       config.build_settings['SWIFT_VERSION'] = '4.2'
  #     end
  #   end
  # end
end

target 'AuditElections' do
  common_pods
end
