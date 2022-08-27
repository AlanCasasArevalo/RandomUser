import Foundation

struct Service {

    public func getUsers(from url: URL, completion:@escaping ([User]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.none)
            } else {
                if let response = response as? HTTPURLResponse, let data = data {
                    if response.statusCode > 199 && response.statusCode < 299 {
                        let result = try? JSONDecoder().decode(UserModel.self, from: data)
                        return completion(result?.data)
                    }
                }
                completion(.none)
            }
        }.resume()
    }
    
    public func getUserAvatar(from url: URL, completion:@escaping (Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.none)
            } else {
                if let response = response as? HTTPURLResponse, let data = data {
                    if response.statusCode > 199 && response.statusCode < 299 {
                        completion(data)
                    }
                }
                completion(.none)
            }
        }.resume()
    }
}
