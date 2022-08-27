import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private var user: User?
    
    let service = Service()
    
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView () {
        self.nameLabel.text = user?.name?.first
        self.surnameLabel.text = user?.name?.last
        self.emailLabel.text = user?.email
        
        guard let url = URL(string: user?.picture?.large ?? "") else { return }
        setupAvatarView(url: url)
    }
    
    func setupAvatarView(url: URL) {
        service.getUserAvatar(from: url) { data in
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                self.avatar.image = UIImage(data: data)
            }
        }
    }

}
