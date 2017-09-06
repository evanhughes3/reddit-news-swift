import Foundation
import CBGPromise

protocol ArticlesServiceProtocol {
  func fetchArticles() -> Future<ArticlesResponse>
}

class ArticlesService: NSObject, ArticlesServiceProtocol {
  let articlesDeserializer: ArticlesDeserializerProtocol
  let jsonClient: JSONClientProtocol

  public required init (articlesDeserializer: ArticlesDeserializerProtocol, 
                        jsonClient: JSONClientProtocol
  ) {
    self.articlesDeserializer = articlesDeserializer
    self.jsonClient = jsonClient
  }

  func fetchArticles() -> Future<ArticlesResponse> {
    let promise = Promise<ArticlesResponse>();

    let requestURL = URL(string: "https://www.reddit.com/r/news.json")!
    let urlRequest = URLRequest(url: requestURL)

    self.jsonClient.sendRequest(urlRequest: urlRequest).then { response in 
      switch (response) {
        case .Success(let json):
          promise.resolve(.Success(self.articlesDeserializer.deserializeArticles(response: json)))
          return
          
        case .Error(let error):
          promise.resolve(.Error(error))
          return
      }
     }

    return promise.future
  }
}
