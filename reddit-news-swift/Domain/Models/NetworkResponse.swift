import Foundation

enum NetworkResponse : Equatable {
  case Success(Data)
  case Error(NetworkError)

  static func ==(lhs: NetworkResponse, rhs: NetworkResponse) -> Bool {
    switch (lhs, rhs) {
      case (let .Success(lhsData), let .Success(rhsData)):
        return lhsData == rhsData
      case (let .Error(lhsError), let .Error(rhsError)):
        return lhsError == rhsError
      default:
        return false
    }
  }
}