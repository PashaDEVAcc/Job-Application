
import SwiftUI
import FirebaseAuth
import UIKit
struct HomePage: View {
    
    let FirebaseAuth = Auth.auth()
    let loginModel  = LoginModel()
    @State var showComments = false
    @State var comment = ""
    @State var postId : String?
    @State var delete  = false
    @State var accountSettings = false
    @State var post = false
    @State var edit = false
    @ObservedObject private var postController = PostViewModel()
    @State public var isSignOut = false
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach (postController.Posts) {
                        Post in
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(constants().offWhite)
                                    .shadow(color:constants().shadow1, radius: 20, x: 20, y: 20)
                                    .shadow(color: .white, radius: 20, x: -20, y: -20)
                                VStack (alignment: .leading){
                                    HStack {
                                        Text("Posted By: \(Post.postedUser)").foregroundColor(.gray).font(.subheadline)
                                        Spacer()
                                        if Post.postedUser == FirebaseAuth.currentUser?.email {
                                            Menu {
                                                Button {
                                                    postController.deletePost(postDelete: Post)
                                                } label: {
                                                    Label("Delete", systemImage: "trash.fill")
                                                }
                                               

                                            } label: {
                                                Image(systemName: "ellipsis")
                                            }

                                        }

                                    }
                                    Group {
                                        Spacer()
                                        Text("Category: \(Post.Category)").font(.title3)
                                        Spacer()
                                        Text("Payment: $\(Post.Payment, specifier: "%.2f")").font(.title3)
                                        Spacer()
                                        Text("Description: \(Post.Description)").font(.title3)
                                        Spacer()
                                        Text("Posted: \(Post.time, format: .dateTime.day().month().year().hour().minute())").foregroundColor(.gray).font(.subheadline)
                                        Spacer()
                                    }
                                    NavigationLink {
                                        commentsView(id: Post.id)
                                    } label: {
                                        Text("View Comments").foregroundColor(.black)
                                    }
                                    NavigationLink(isActive: $isSignOut) {
                                        LoginCreateAccountView()
                                    } label: {
                                        EmptyView()
                                    }
                                    NavigationLink(isActive: $accountSettings) {
                                        accountSettingsView()
                                    } label: {
                                        EmptyView()
                                    }

                                }.padding()
                            }
                            Spacer()
                        }.padding()
                    }
                }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(constants().background)
            .sheet(isPresented: $post) {
                createView()
            }
           
            .navigationBarTitle("\(FirebaseAuth.currentUser?.email ?? "No User")")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.postController.fetchData()
                
            }
           
            .navigationBarItems(leading: HStack {
                Button(action: {
                    accountSettings = true
                }, label: {
                    Image(systemName: "gearshape.fill").foregroundColor(.black)
                })
                Button(action: {
                    post = true
                }, label: {
                    Image(systemName: "plus").foregroundColor(.black)
                })
            },trailing: Button(action: {
                loginModel.signOut()
                isSignOut = true
            }, label: {
                Text("Sign Out").foregroundColor(.black)
            }))
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(constants().background)
        
    }



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
}
