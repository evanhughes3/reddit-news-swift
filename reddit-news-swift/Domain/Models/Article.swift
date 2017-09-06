import Foundation

public final class Article: NSObject {
  let title: String
  let url: String

  public init(title: String, url: String) {
    self.title = title
    self.url = url;
    
    super.init()
  }
}
