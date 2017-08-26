import UIKit
import Quick
import Nimble
@testable import reddit_news_swift

class ArticlesServiceSpec: QuickSpec {
  override func spec() {
    describe("ArticlesServiceSpec") {
      var jsonClient: JSONClientMock!
      var subject: DefaultArticlesService!

      beforeEach {
        jsonClient = JSONClientMock();

        subject = DefaultArticlesService(jsonClient: jsonClient)
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