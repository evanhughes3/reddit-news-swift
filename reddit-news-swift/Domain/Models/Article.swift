import Foundation

public final class Article: NSObject {
  let title: String

  public init(title: String) {
    self.title = title
    
    super.init()
  }
}
