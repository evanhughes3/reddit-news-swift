import UIKit
import Quick
import Nimble
import Blindside
@testable import reddit_news_swift

class URLSessionClientSpec: QuickSpec {
  override func spec() {
    describe("URLSessionClientSpec") {
      var injector: BSInjector & BSBinder!
      var urlSession: URLSessionMock!
      var queue: OperationQueueMock!
      var subject: URLSessionClient!

      beforeEach {
        injector = InjectorProvider.injector()
        
        urlSession = URLSessionMock()
        injector.bind(URL_SESSION_INJECTOR_KEY, toInstance: urlSession)

        queue = OperationQueueMock()
        injector.bind(OperationQueue.self, toInstance: queue)

        subject = injector.getInstance(URLSessionClient.self) as! URLSessionClient
      }

      describe("-sendRequest") {
        beforeEach() {
          let url = URL(string: "https://www.google.com")!
          let urlRequest = URLRequest(url: url)
          subject.sendRequest(urlRequest: urlRequest)
        }

        it("should send the data task request") {
          expect(urlSession.didCallDataTask).to(equal(true));
          expect(urlSession.incomingUrlRequest?.url?.absoluteString).to(equal("https://www.google.com"))
        }

        it("should call resume on the created data task") {
          expect(urlSession.dataSessionTask?.didCallResume).to(equal(true))
        }
        
//        context("when there is an error") {
//          beforeEach() {
//            let error = NSError(domain: "foo", code: 2)
//            urlSession.incomingCompletionHandler?(nil, nil, error)
//          }
//        }

//        context("when there is NOT an error") {
//          beforeEach("") {
//
//          }
//        }
      }
    }
  }
}