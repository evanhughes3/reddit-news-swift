import Foundation
import CBGPromise
@testable import reddit_news_swift

class URLSessionClientMock: URLSessionClientProtocol {
  var didCallSendRequest: Bool = false
  var incomingURL: URLRequest?
  let promise = Promise<NetworkResponse>() 

  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse> {
    didCallSendRequest = true
    incomingURL = urlRequest;
    
    return promise.future
  }
}
