import Foundation

class DataSessionTaskMock: URLSessionDataTask {
  var didCallResume: Bool = false;

  override func resume() {
    didCallResume = true;
  }
}