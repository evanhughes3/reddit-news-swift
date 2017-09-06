import Foundation
import SwiftyJSON

protocol ArticleDeserializerProtocol {
  func deserializeArticles(response: JSON) -> [Article]
}

class ArticleDeserializer: NSObject, ArticleDeserializerProtocol {
  func deserializeArticles(response: JSON) -> [Article] {
    return [Article(title: "title")]
  }
}