//
//  commentsView.swift
//  Chat App
//
//  Created by Pasha Panin on 11/13/21.
//

import SwiftUI
import FirebaseAuth
struct commentsView: View {
    @State var id : String?
    @State var comment = ""
    @State var home  = false
    @ObservedObject var postController = PostViewModel()
    let FirebaseAuth = Auth.auth()
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                ForEach(postController.comments) {
                    Comment in
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(constants().offWhite)
                                .shadow(color:constants().shadow1, radius: 20, x: 20, y: 20)
                                .shadow(color: .white, radius: 20, x: -20, y: -20)
                            VStack (alignment: .leading){
                                HStack {
                                    Text("Posted By: \(Comment.postedUser)").foregroundColor(.gray).font(.subheadline)
                                    Spacer()
                                    if Comment.postedUser == FirebaseAuth.currentUser?.email {
                                        Button {
                                            postController.deleteComments(id!, Comment.id!)
                                        } label: {
                                            Image(systemName: "trash.fill").foregroundColor(.red)
                                        }
                                    }

                                }
                                Text("\(Comment.message)").font(.title3)
                                Spacer()
                                Text("Posted: \(Comment.time, format: .dateTime.day().month().year().hour().minute())").foregroundColor(.gray).font(.subheadline)
                            }.padding()
                        }
                       
                    }.padding()
                }
                }
                Spacer()
                HStack (alignment: .bottom){
                    constants().genericTextView(label: "Comment", text: $comment)
                    Spacer()
                    Button {
                        postController.postComment(id!, CommentModel(parentID: id!, message: comment, postedUser: (FirebaseAuth.currentUser?.email)!, time: Date.now))
                        comment = ""
                    } label: {
                        Image(systemName: "paperplane.fill").foregroundColor(.black)
                    }
                    Spacer()
                }.padding()
               
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(constants().background)
            .navigationBarHidden(true)
            .accentColor(.black)

        }
        .navigationTitle("Comments")
        .onAppear {
            self.postController.fetchComments(id!)
        }
        
        .accentColor(.black)
    }
}

struct commentsView_Previews: PreviewProvider {
    static var previews: some View {
        commentsView(id: "")
            
    }
}
