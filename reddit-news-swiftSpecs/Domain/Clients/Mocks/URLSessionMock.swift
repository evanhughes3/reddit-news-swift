import Foundation
@testable import reddit_news_swift

class URLSessionMock: URLSession {
  var didCallDataTask: Bool = false
  var incomingUrlRequest: URLRequest? = nil
  var incomingData: Data? = nil
  var incomingResponse: URLResponse? = nil
  var error: Error? = nil
  var dataSessionTask: DataSessionTaskMock? = nil
  var incomingCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil

  override init() {
    super.init()
  }

  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    didCallDataTask = true
    incomingUrlRequest = request
    incomingCompletionHandler = completionHandler
    dataSessionTask = DataSessionTaskMock();
    return dataSessionTask!
  }
}
