import Foundation
import SwiftyJSON

protocol ArticlesDeserializerProtocol {
  func deserializeArticles(response: JSON) -> [Article]
}

class ArticlesDeserializer: NSObject, ArticlesDeserializerProtocol {
  func deserializeArticles(response: JSON) -> [Article] {
    var articles: [Article] = []; 
    
    let fetchedArticles = response["data"]["children"].arrayValue

    for article in fetchedArticles {
      let title = article["data"]["title"].stringValue
      let url = article["data"]["url"].stringValue
      articles.append(Article(title: title, url: url))
    }
    return articles
  }
}