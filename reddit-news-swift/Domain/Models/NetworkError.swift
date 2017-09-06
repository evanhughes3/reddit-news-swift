protocol NetworkErrorProtocol: Error {
  var localizedTitle: String { get }
  var localizedDescription: String { get }
  var code: Int { get }
}

struct NetworkError: NetworkErrorProtocol, Equatable {
  var localizedTitle: String
  var localizedDescription: String
  var code: Int

  init(localizedTitle: String?, localizedDescription: String, code: Int) {
    self.localizedTitle = localizedTitle ?? "Error"
    self.localizedDescription = localizedDescription
    self.code = code
  }

  static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
    
    return lhs.localizedTitle == rhs.localizedTitle &&
            lhs.localizedDescription == rhs.localizedDescription && 
            lhs.code == rhs.code
  }
}