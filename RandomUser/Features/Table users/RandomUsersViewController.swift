import UIKit

class RandomUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let forCellReuseIdentifier = "UserCell"
    let service = Service()
    var users: [User]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        setDelegateAndDataSource()
        registerTableCell()

        let url = Constants.API.baseURL
        var components = URLComponents()

        components.scheme = url.scheme
        components.host = url.host
        components.path = url.path + ""
        components.queryItems = [
            URLQueryItem(name: "appid", value: Constants.API.apiKey),
            URLQueryItem(name: "fmt", value: "json"),
            URLQueryItem(name: "results", value: "10")
        ].compactMap { $0 }
        
        service.getUsers(from: components.url ?? URL(string: "https://randomuser.me/api")!) { users in
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setDelegateAndDataSource () {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func registerTableCell () {
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
    }

}

extension RandomUsersViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = users?[indexPath.row] else { return }
        let detailVC = DetailViewController(user: user)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension RandomUsersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = users?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: forCellReuseIdentifier, for: indexPath) as! UserCell
        cell.setupView(with: user)
        return cell
    }
}
