import Foundation

protocol ArticleService {
  func fetchArticles() -> Void
}

class DefaultArticleService: ArticleService {
  func fetchArticles() {
  }
}