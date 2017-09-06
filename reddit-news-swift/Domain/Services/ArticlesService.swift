import Foundation

protocol FetchArticlesService {
  func fetchArticles() -> Array<Article>
}

class ArticlesService: NSObject, FetchArticlesService {
  let jsonClient: NetworkClient

  public required init (jsonClient: NetworkClient) {
    self.jsonClient = jsonClient
  }

  func fetchArticles() -> Array<Article> {
    let requestURL = URL(string: "https://www.google.com")!
    let urlRequest = URLRequest(url: requestURL)

    self.jsonClient.sendRequest(urlRequest: urlRequest)

    return []
  }
}
