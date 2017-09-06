import UIKit
import Quick
import Nimble
import Blindside
import CBGPromise
import SwiftyJSON
@testable import reddit_news_swift

class JSONClientSpec: QuickSpec {
  override func spec() {
    describe("JSONClientSpec") {
      var urlSessionClient: URLSessionClientMock!
      var subject: JSONClient!

      beforeEach {
        let injector = InjectorProvider.injector()
        
        urlSessionClient = URLSessionClientMock()
        injector.bind(URLSessionClient.self, toInstance: urlSessionClient)

        subject = injector.getInstance(JSONClient.self) as! JSONClient
      }

      describe("-sendRequest") {
        var future: Future<JSONResponse>!

        beforeEach {
          let url = URL(string: "https://www.google.com")!
          let urlRequest = URLRequest(url: url)
          
          future = subject.sendRequest(urlRequest: urlRequest)
        }

        it("should fetch the articles") {
          expect(urlSessionClient.didCallSendRequest).to(equal(true));
          expect(urlSessionClient.incomingURL?.url?.absoluteString).to(equal("https://www.google.com"))
        }
        
        describe("successfully fetching the articles") {
          var data: Data!
          let responseDictionary = [ "foo": "bar" ]

          beforeEach() {
            do {
              data = try JSONSerialization.data(withJSONObject: responseDictionary)
            } catch {
              
            }

            urlSessionClient.promise.resolve(.Success(data))
          }

          it("should deserialize the data into JSON") {
            expect(future.value) == .Success(JSON(data: data))
          }
        }

        describe("failing to fetch the articles") {
          var data: Data!
          let error = NetworkError(localizedTitle: "this is an error", localizedDescription: "this is description", code: 500)
          
          beforeEach() {
            urlSessionClient.promise.resolve(.Error(error))
          }

          it("should deserialize the data into JSON") {
            expect(future.value) == .Error(error)
          }
        }
      }
    }
  }
}