import Foundation

protocol ArticlesService {
  func fetchArticles() -> Array<Article>
}

class DefaultArticlesService: NSObject, ArticlesService {
  let jsonClient: JSONClient

  public required init (jsonClient: JSONClient) {
    self.jsonClient = jsonClient
  }

  func fetchArticles() -> Array<Article> {
    if let url = URL.init(string: "https://www.google.com") {
      self.jsonClient.sendRequest(url: url)
    }

    return []
  }
}
