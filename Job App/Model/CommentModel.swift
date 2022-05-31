
import Foundation
import Foundation
import FirebaseFirestoreSwift
struct CommentModel: Identifiable, Codable {
    @DocumentID var id: String?
    var parentID : String
    var message : String
    var postedUser : String
    var time : Date
  enum CodingKeys: String, CodingKey {
    case id
    case parentID
    case message
    case postedUser
    case time
  }
}
