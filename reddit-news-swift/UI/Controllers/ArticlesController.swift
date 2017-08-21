import UIKit

class ArticlesController: UIViewController {

    @IBOutlet weak var todoHeaderLabel: UILabel!

    @IBOutlet weak var todoStackView: UIStackView!

    let articlesService: ArticleService

    public init(articlesService: ArticleService = DefaultArticleService()) {
        self.articlesService = articlesService

        super.init(nibName: "ArticlesController", bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articlesService.fetchArticles()
    }
}
