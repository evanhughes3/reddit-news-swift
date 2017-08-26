import Foundation

protocol ArticlesService {
  func fetchArticles() -> Array<Article>
  init(jsonClient: JSONClient)
}

class DefaultArticlesService: ArticlesService {
  let jsonClient: JSONClient

  public required init (jsonClient: JSONClient = DefaultJSONClient()) {
    self.jsonClient = jsonClient
  }

  func fetchArticles() -> Array<Article> {
    if let url = URL.init(string: "https://www.google.com") {
      self.jsonClient.sendRequest(url: url)
    }

    return []
  }
}
