import UIKit
import Quick
import Nimble
@testable import reddit_news_swift

class AppDelegateSpec: QuickSpec {
  override func spec() {
    describe("AppDelegate") {
      var subject: AppDelegate!

      beforeEach {
        subject = AppDelegate()

        subject.window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
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
          expect(subject.window?.rootViewController).to(beAnInstanceOf(ArticlesController))
        }
      }
    }
  }
}
