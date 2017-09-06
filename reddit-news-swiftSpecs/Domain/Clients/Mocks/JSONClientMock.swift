import Foundation
import CBGPromise
@testable import reddit_news_swift

class JSONClientMock: JSONClientProtocol {
  var didCallSendRequest: Bool = false
  var incomingURLRequest: URLRequest?
  let promise = Promise<JSONResponse>()
  
  func sendRequest(urlRequest: URLRequest) -> Future<JSONResponse> {
    didCallSendRequest = true
    incomingURLRequest = urlRequest;
    return promise.future
  }
}
