import UIKit
import Quick
import Nimble
import Blindside
import CBGPromise
import SwiftyJSON
@testable import reddit_news_swift

class ArticlesServiceSpec: QuickSpec {
  override func spec() {
    describe("ArticlesServiceSpec") {
      var jsonClient: JSONClientMock!
      var articlesDeserializer: ArticlesDeserializerMock!
      var subject: ArticlesService!

      beforeEach {
        let injector = InjectorProvider.injector()
        
        jsonClient = JSONClientMock();
        injector.bind(JSONClient.self, toInstance: jsonClient)

        articlesDeserializer = ArticlesDeserializerMock();
        injector.bind(ArticlesDeserializer.self, toInstance: articlesDeserializer)

        subject = injector.getInstance(ArticlesService.self) as! ArticlesService
      }

      describe("-fetchArticles") {
        var future: Future<ArticlesResponse>!
        
        beforeEach {
          future = subject.fetchArticles()
        }

        it("should fetch the articles") {
          expect(jsonClient.didCallSendRequest).to(equal(true));
          expect(jsonClient.incomingURLRequest?.url?.absoluteString).to(equal("https://www.reddit.com/r/news.json"))
        }
        
        describe("successfully fetching the articles") {
          beforeEach {
            jsonClient.promise.resolve(.Success(JSON(["foo": "bar"])))
          }

          it("should deserialize the json into articles") {
            expect(articlesDeserializer.incomingArticlesResponse).to(equal(JSON(["foo": "bar"])))
          }

          it("should resolve the promise with articles") {
            expect(future.value) == .Success(articlesDeserializer.expectedArticles)
          }
        }

        describe("failing to fetch the articles") {
          var error: NetworkError!

          beforeEach {
            error = NetworkError(localizedTitle: "as", localizedDescription: "as", code: 500)
            jsonClient.promise.resolve(.Error(error))
          }
          
          it("should reject the promise") {
            expect(future.value) == .Error(error)
          }
        }
      }
    }
  }
}