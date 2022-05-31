
import SwiftUI
import FirebaseAuth
struct EditPage: View {
    let FirebaseAuth = Auth.auth()
    var postController = PostViewModel()
    @State var user = "No User"
    @State var payment  : String = "0.00"
    @State var description = ""
    @State var otherCategory = ""
    @State var categories = ["Software Developement",
                             "Remodeling",
                             "Art/Design",
                             "Marketing",
                             "Law",
                             "Other..."]
    @State var selectedIndex = 0
    @State var id : String?
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
                            }
                        }else {
                            postController.editPost(PostModel(Category: categories[selectedIndex] == categories[5] ? otherCategory : categories[selectedIndex], Payment: Double(payment) ?? 0, Description: description, postedUser: (FirebaseAuth.currentUser?.email)!, time: Date.now), id: id ?? "")
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
        }
    }
}

struct EditPage_Previews: PreviewProvider {
    static var previews: some View {
        EditPage()
    }
}
