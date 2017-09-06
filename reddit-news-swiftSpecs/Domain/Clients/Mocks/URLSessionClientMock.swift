import Foundation
@testable import reddit_news_swift

class URLSessionClientMock: NetworkClient {
  var didCallSendRequest: Bool = false
  var incomingURL: URLRequest?

  func sendRequest(urlRequest: URLRequest) {
    didCallSendRequest = true
    incomingURL = urlRequest;
  }
}
