import Foundation

struct UserModel: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [User]?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}

// MARK: - Datum
struct User: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
