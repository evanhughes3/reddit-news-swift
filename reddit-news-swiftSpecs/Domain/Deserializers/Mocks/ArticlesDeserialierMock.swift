import Foundation
import SwiftyJSON
@testable import reddit_news_swift

class ArticlesDeserializerMock: ArticlesDeserializerProtocol {
  var incomingArticlesResponse: JSON?
  let expectedArticles = [
    Article(title: "Article 1", url: "URL 1"),
    Article(title: "Article 2", url: "URL 2")
  ]
  
  func deserializeArticles(response: JSON) -> [Article] {
    incomingArticlesResponse = response
    return expectedArticles
  }
}