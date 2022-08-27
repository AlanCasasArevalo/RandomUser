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

        let url = URL(string: "https://reqres.in/api/users?per_page=100")!

        service.getUsers(from: url) { users in
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
