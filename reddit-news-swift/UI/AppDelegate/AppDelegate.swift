import UIKit
import Blindside


class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var injector: BSInjector
  
  override init() {
    self.injector = InjectorProvider.injector()
    super.init()
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let screenBounds = UIScreen.main.bounds
    window = UIWindow(frame:screenBounds)
    self.window?.rootViewController = UIViewController()
    window?.makeKeyAndVisible()
    window?.rootViewController = self.injector.getInstance(ArticlesController.self) as! ArticlesController
    
    return true
  }
}
