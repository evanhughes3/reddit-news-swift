import Foundation

enum ArticlesResponse: Equatable {
  case Success([Article])
  case Error(NetworkError)
}

func == (lhs: ArticlesResponse, rhs: ArticlesResponse) -> Bool {
  switch (lhs, rhs) {
  case (.Success(let val1), .Success(let val2)) where val1 == val2: return true
  case (.Error(let error1), .Error(let error2)) where error1 == error2: return true
  default: return false
  }
}
