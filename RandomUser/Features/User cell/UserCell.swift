import UIKit

class UserCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    let service = Service()

    override func prepareForReuse() {
        super.prepareForReuse()
        resetValues()
    }
    
    func resetValues () {
        self.nameLabel.text = ""
        self.surnameLabel.text = ""
        self.emailLabel.text = ""
        self.avatar.image = nil
    }
    
    func setupView(with user: User) {
        self.nameLabel.text = user.name?.first
        self.surnameLabel.text = user.name?.last
        self.emailLabel.text = user.email
        
        guard let url = URL(string: user.picture?.large ?? "") else {
            return
        }
        
        self.setupAvatar(with: url)
    }
    
    func setupAvatar(with url: URL) {
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
