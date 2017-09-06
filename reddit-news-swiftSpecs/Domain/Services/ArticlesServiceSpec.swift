import UIKit
import Quick
import Nimble
import Blindside
@testable import reddit_news_swift

class ArticlesServiceSpec: QuickSpec {
  override func spec() {
    describe("ArticlesServiceSpec") {
      var jsonClient: JSONClientMock!
      var subject: ArticlesService!

      beforeEach {
        let injector = InjectorProvider.injector()
        jsonClient = JSONClientMock();
        injector.bind(JSONClient.self, toInstance: jsonClient)

        subject = injector.getInstance(ArticlesService.self) as! ArticlesService
      }

      describe("-fetchArticles") {
        beforeEach {
          subject.fetchArticles()
        }

        it("should fetch the articles") {
          expect(jsonClient.didCallSendRequest).to(equal(true));
          expect(jsonClient.incomingURLRequest?.url?.absoluteString).to(equal("https://www.google.com"))
        }
      }
    }
  }
}