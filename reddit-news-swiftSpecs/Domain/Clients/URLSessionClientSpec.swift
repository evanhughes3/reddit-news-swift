import UIKit
import Quick
import Nimble
import Blindside
import CBGPromise
@testable import reddit_news_swift

class URLSessionClientSpec: QuickSpec {
  override func spec() {
    fdescribe("URLSessionClientSpec") {
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
        var future: Future<NetworkResponse>!
        
        beforeEach() {
          let url = URL(string: "https://www.google.com")!
          let urlRequest = URLRequest(url: url)
          future = subject.sendRequest(urlRequest: urlRequest)
        }

        it("should send the data task request") {
          expect(urlSession.didCallDataTask).to(equal(true));
          expect(urlSession.incomingUrlRequest?.url?.absoluteString).to(equal("https://www.google.com"))
        }

        it("should call resume on the created data task") {
          expect(urlSession.dataSessionTask?.didCallResume).to(equal(true))
        }
        
        context("when there is an error") {
          var error: NetworkError!

          beforeEach() {
            error = NetworkError(localizedTitle: "title", localizedDescription: "description", code: 500)
            urlSession.incomingCompletionHandler?(nil, nil, error)
          }
          
          it("should reject the promise") {
            expect(future.value).to(equal(.Error(error)))
          }
        }

        context("when there is NOT an error") {
          context("when there is data") {
            var data: Data!

            beforeEach() {
              data = "my special data".data(using: .utf8)
              urlSession.incomingCompletionHandler?(data, nil, nil)
            }
            
            it("should resolve the promise") {
              expect(future.value).to(equal(.Success(data)))
            }
          }

          context("when there is NOT data") {
            
          }
        }
      }
    }
  }
}