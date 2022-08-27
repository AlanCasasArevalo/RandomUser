import UIKit

class RandomUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let service = Service()
    var users: [User]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan


        let url = URL(string: "https://reqres.in/api/users?per_page=100")!

        service.getUsers(from: url) { users in
            self.users = users
        }
    }
    
    func setDelegateAndDataSource () {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension RandomUsersViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}

extension RandomUsersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
