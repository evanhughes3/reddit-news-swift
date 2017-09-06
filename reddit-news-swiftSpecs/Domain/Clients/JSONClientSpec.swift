import UIKit
import Quick
import Nimble
import Blindside
@testable import reddit_news_swift

class JSONClientSpec: QuickSpec {
  override func spec() {
    describe("JSONClientSpec") {
      var injector: BSInjector & BSBinder!
      var urlSessionClient: URLSessionClientMock!
      var subject: JSONClient!

      beforeEach {
        injector = InjectorProvider.injector()
        
        urlSessionClient = URLSessionClientMock()
        injector.bind(URLSessionClient.self, toInstance: urlSessionClient)

        subject = injector.getInstance(JSONClient.self) as! JSONClient
      }

      describe("-sendRequest") {
        beforeEach() {
          let url = URL(string: "https://www.google.com")!
          let urlRequest = URLRequest(url: url)
          subject.sendRequest(urlRequest: urlRequest)
        }

        it("should fetch the articles") {
          expect(urlSessionClient.didCallSendRequest).to(equal(true));
          expect(urlSessionClient.incomingURL?.url?.absoluteString).to(equal("https://www.google.com"))
        }
      }
    }
  }
}