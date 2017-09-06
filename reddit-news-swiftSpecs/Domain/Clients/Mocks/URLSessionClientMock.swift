import Foundation
import CBGPromise
@testable import reddit_news_swift

class URLSessionClientMock: NetworkClient {
  var didCallSendRequest: Bool = false
  var incomingURL: URLRequest?

  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse> {
    didCallSendRequest = true
    incomingURL = urlRequest;

    let promise = Promise<NetworkResponse>()
    return promise.future
  }
}
