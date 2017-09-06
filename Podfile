platform :ios, '9.0'
use_frameworks!

target 'reddit-news-swift' do
  pod 'Blindside'
  pod "CBGPromise"
  pod "SwiftyJSON"

  target 'reddit-news-swiftSpecs' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod "PivotalCoreKit/Development", git: "https://github.com/pivotal/PivotalCoreKit"
  end
end
