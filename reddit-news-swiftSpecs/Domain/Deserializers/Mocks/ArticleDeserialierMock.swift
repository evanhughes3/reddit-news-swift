import Foundation
import SwiftyJSON
@testable import reddit_news_swift

class ArticleDeserializerMock: ArticleDeserializerProtocol {
  var incomingArticlesResponse: JSON?
  let expectedArticles = [
    Article(title: "Article 1"),
    Article(title: "Article 2")
  ]
  
  func deserializeArticles(response: JSON) -> [Article] {
    incomingArticlesResponse = response
    return expectedArticles
  }
}