import UIKit
import Quick
import Nimble
import Blindside
@testable import reddit_news_swift

class AppDelegateSpec: QuickSpec {
  override func spec() {
    describe("AppDelegate") {
      var articlesController: ArticlesController!
      var subject: AppDelegate!

      beforeEach {
        let injector = InjectorProvider.injector()
        
        subject = AppDelegate()
        
        injector.bind(ArticlesService.self, toInstance: ArticlesServiceMock()) //to prevent actually making a request...
        
        articlesController = injector.getInstance(ArticlesController.self) as! ArticlesController
        injector.bind(ArticlesController.self, toInstance: articlesController)

        subject.window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        subject.injector = injector
      }

      describe("-application:didFinishLaunchingWithOptions:") {
        beforeEach {
          _ = subject.application(UIApplication.shared, didFinishLaunchingWithOptions: [UIApplicationLaunchOptionsKey(rawValue: "test"): true])
        }

        it("should create a window") {
          expect(subject.window).toNot(beNil())
          expect(subject.window?.isKeyWindow).to(beTruthy())
        }

        it("should set the correct root view controller") {
          expect(subject.window?.rootViewController).to(equal(articlesController))
        }
      }
    }
  }
}
