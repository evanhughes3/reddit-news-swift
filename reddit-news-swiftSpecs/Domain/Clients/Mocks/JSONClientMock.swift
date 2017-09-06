import Foundation
import CBGPromise
@testable import reddit_news_swift

class JSONClientMock: NetworkClient {
  var didCallSendRequest: Bool = false
  var incomingURLRequest: URLRequest?

  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse> {
    didCallSendRequest = true
    incomingURLRequest = urlRequest;
    let promise = Promise<NetworkResponse>()
    return promise.future
  }
}
