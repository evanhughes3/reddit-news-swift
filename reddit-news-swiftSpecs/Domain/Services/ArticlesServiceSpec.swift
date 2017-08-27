import UIKit
import Quick
import Nimble
import Blindside
@testable import reddit_news_swift

class ArticlesServiceSpec: QuickSpec {
  override func spec() {
    describe("ArticlesServiceSpec") {
      var injector: BSInjector & BSBinder!
      var jsonClient: JSONClientMock!
      var subject: DefaultArticlesService!

      beforeEach {
        injector = InjectorProvider.injector()

        jsonClient = JSONClientMock();
        injector.bind(DefaultJSONClient.self, toInstance: jsonClient)

        subject = injector.getInstance(DefaultArticlesService.self) as! DefaultArticlesService
      }

      describe("-fetchArticles") {
        beforeEach() {
          subject.fetchArticles()
        }

        it("should fetch the articles") {
          expect(jsonClient.didCallSendRequest).to(equal(true));
          expect(jsonClient.incomingURL?.absoluteString).to(equal("https://www.google.com"))
        }
      }
    }
  }
}