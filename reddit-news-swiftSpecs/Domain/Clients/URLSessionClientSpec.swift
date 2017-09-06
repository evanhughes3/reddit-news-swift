import UIKit
import Quick
import Nimble
import Blindside
import CBGPromise
import PivotalCoreKit
@testable import reddit_news_swift

class URLSessionClientSpec: QuickSpec {
  override func spec() {
    describe("URLSessionClientSpec") {
      var urlSession: URLSessionMock!
      var queue: PSHKFakeOperationQueue!
      var subject: URLSessionClient!

      beforeEach {
        let injector = InjectorProvider.injector()
        
        urlSession = URLSessionMock()
        injector.bind(URL_SESSION_INJECTOR_KEY, toInstance: urlSession)

        queue = PSHKFakeOperationQueue()
        queue.runSynchronously = false
        injector.bind(MAIN_QUEUE_INJECTOR_KEY, toInstance: queue)

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
          
          it("should reject the promise on the main queue") {
            expect(future.value).to(beNil())
            queue.runNextOperation()

            expect(future.value) == .Error(error)  
          }
        }

        context("when there is NOT an error") {
          context("when there is data") {
            var data: Data!

            beforeEach() {
              data = "my special data".data(using: .utf8)
              urlSession.incomingCompletionHandler?(data, nil, nil)
            }
            
            it("should resolve the promise on the main queue") {
              expect(future.value).to(beNil())
              queue.runNextOperation()
              
              expect(future.value) == .Success(data)
            }
          }

          context("when there is NOT data") {
            var expectedError: NetworkError!

            beforeEach() {
              expectedError = NetworkError(localizedTitle: "Error", localizedDescription: "Something went wrong :(, try again later", code: 500)
              urlSession.incomingCompletionHandler?(nil, nil, nil)
            }

            it("should reject the promise on the main queue") {
              expect(future.value).to(beNil())
              queue.runNextOperation()

              expect(future.value) == .Error(expectedError)
            }
          }
        }
      }
    }
  }
}