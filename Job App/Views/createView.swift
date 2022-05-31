//
//  createView.swift
//  Chat App
//
//  Created by Pasha Panin on 11/1/21.
//

import SwiftUI
import FirebaseAuth
struct createView: View {
    @Environment(\.presentationMode) var presentationMode
    let FirebaseAuth = Auth.auth()
    var postController = PostViewModel()
    @State var user = "No User"
    @State var payment  : String = "0.00"
    @State var description = ""
    @State var finishedPost = false
    @State var otherCategory = ""
    @State var categories = ["Software Developement",
                             "Remodeling",
                             "Art/Design",
                             "Marketing",
                             "Law",
                             "Other..."]
    @State var selectedIndex = 0
    let textLimit = 250
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                Text("Create").font(.title).foregroundColor(.black)
                Picker(selection: $selectedIndex) {
                    ForEach(0 ..< categories.count) {
                        Text("\(self.categories[$0])")
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .foregroundColor(.black)
                Spacer()
                if categories[selectedIndex] == categories.last{
                    constants().genericTextView(label: "Category", text: $otherCategory)
                }
                Spacer().frame(height: 30)
                HStack {
                    
                    Image(systemName: "dollarsign.square.fill").foregroundColor(.black)
                    TextField("Payment Amount", text: $payment)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.black)
                }
                Group{Spacer().frame(height: 50)
                    constants().genericTextView(label: "Description", text: $description)
                        .disableAutocorrection(false)
                Spacer().frame(height: 30)
                constants().appButton(onPressed: {
                    if description != ""  {
                        if categories[selectedIndex] == categories.last {
                            if otherCategory != "" {
                                postController.addPost(PostModel(Category: otherCategory, Payment: Double(payment)!, Description: description, postedUser: (FirebaseAuth.currentUser?.email)!, time: Date.now))
                                description = ""
                                otherCategory = ""
                                payment = "0.00"
                                selectedIndex = 0
                                presentationMode.wrappedValue.dismiss()
                            }
                        }else {
                            postController.addPost(PostModel(Category: categories[selectedIndex] , Payment: Double(payment)!, Description: description, postedUser: (FirebaseAuth.currentUser?.email)!, time: Date.now))
                            description = ""
                            otherCategory = ""
                            payment = "0.00"
                            selectedIndex = 0
                        }
                       
                    }
                
                }, text: "Post")
                        .foregroundColor(.black)
                }
                   Spacer()
                   
               
            }.padding(50)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(constants().background)
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            self.postController.fetchData()
        })
        .navigationBarBackButtonHidden(true)
    }
}

struct createView_Previews3: PreviewProvider {
    static var previews: some View {
        createView()
    }
}
