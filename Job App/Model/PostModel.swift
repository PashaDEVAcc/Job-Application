import Foundation
import FirebaseFirestoreSwift
import SwiftUI
struct PostModel:  Identifiable, Codable {
  @DocumentID var id : String?
  var Category : String
  var Payment : Double
  var Description : String
  var postedUser : String
  var time : Date
  enum CodingKeys: String, CodingKey {
    case id
    case Category
    case Payment
    case Description
    case postedUser
    case time
  }
}
