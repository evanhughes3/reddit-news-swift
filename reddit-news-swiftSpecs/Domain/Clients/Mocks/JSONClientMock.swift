import Foundation
@testable import reddit_news_swift

class JSONClientMock: NetworkClient {
  var didCallSendRequest: Bool = false
  var incomingURLRequest: URLRequest?

  func sendRequest(urlRequest: URLRequest) {
    didCallSendRequest = true
    incomingURLRequest = urlRequest;
  }
}
