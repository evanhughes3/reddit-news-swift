import UIKit
import Blindside

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var injector: BSInjector
  
  override init() {
    self.injector = InjectorProvider.injector()
    super.init()
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window?.makeKeyAndVisible()
    window?.rootViewController = self.injector.getInstance(ArticlesController.self) as! ArticlesController

    return true
  }
}
