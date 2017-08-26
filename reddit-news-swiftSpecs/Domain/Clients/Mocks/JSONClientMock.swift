import Foundation
@testable import reddit_news_swift

class JSONClientMock: JSONClient {
  var didCallSendRequest: Bool = false
  var incomingURL: URL?

  func sendRequest(url: URL) {
    didCallSendRequest = true
    incomingURL = url;
  }
}
