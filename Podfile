# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MedicOnePedsCards' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MedicOnePedsCards
  pod 'LGButton'

end

#post_install do |installer|
  #installer.pods_project.targets.each do |target|
    #target.build_configurations.each do |config|
      #config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    #end
  #end
#end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
      '$(FRAMEWORK_SEARCH_PATHS)'
    ]
  end
end
