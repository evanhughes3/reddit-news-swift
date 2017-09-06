import Foundation

class URLSessionClient: NSObject, NetworkClient {
  var urlSession: URLSession
  
  init(urlSession: URLSession) {
    self.urlSession = urlSession
    super.init()
  }

  func sendRequest(urlRequest: URLRequest) {
    let dataTask = self.urlSession.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) -> Void in 
      
     }
    
    dataTask.resume()
  }
}