import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
class PostViewModel: ObservableObject {
    @Published var Posts = [PostModel]()
    @Published var comments = [CommentModel]()
    
    private var db = Firestore.firestore()
    func addPost(_ post: PostModel) {
        do {
            let _ = try db.collection("posts").addDocument(from: post)
        }
        catch {
            print(error)
        }
    }
    func editPost( _ postEdit : PostModel,id : String) {
        do {
            let _ = try db.collection("posts").document(id).setData(from: postEdit)
        }
        catch {
            print(error)
        }
        
    }
    func postComment(_ id : String, _ comment : CommentModel) {
        do {
            try db.collection("posts").document(id).collection("comments").addDocument(from: comment)
        }catch {
            print(error)
        }
    }
    func deleteComments(_ id : String, _ commentId : String) {
        db.collection("posts").document(id).collection("comments").document(commentId).delete()
    }
    func fetchComments(_ id : String) {
        db.collection("posts").document(id).collection("comments").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            self.comments = documents.compactMap({ queryDocumentSnapsot -> CommentModel? in
                return try? queryDocumentSnapsot.data(as: CommentModel.self)
            })
        }
    }
    func deletePost(postDelete : PostModel){
        db.collection("posts").document(postDelete.id ?? "").delete()
        self.fetchData()
    }
    func fetchData() {
        db.collection("posts").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.Posts = documents.compactMap({ queryDocumentSnapshot -> PostModel? in
                return try? queryDocumentSnapshot.data(as: PostModel.self)
                
            })
            
            
        }
        
    }
    
}
