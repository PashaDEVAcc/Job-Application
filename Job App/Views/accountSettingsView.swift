//
//  accountSettingsView.swift
//  Chat App
//
//  Created by Pasha Panin on 11/6/21.
//

import SwiftUI
import FirebaseAuth
struct accountSettingsView: View {
    let FirebaseAuth = Auth.auth()
    let loginController = LoginModel()
    @State var goToHome = false
    @State var goToLogin = false
    @State var deleteAccount = false
    @State var sendReset = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .shadow(color:constants().shadow1, radius: 20, x: 20, y: 20)
                        .shadow(color:.white, radius: 20, x: -20 , y: -20)
                        .foregroundColor(.black)
                    Spacer().frame(height: 50)
                    Text("\(FirebaseAuth.currentUser?.email ?? "No User")").font(.headline).fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer().frame(height: 50)
                    constants().appButton(onPressed: {
                        loginController.sendForgotPassword(email: (FirebaseAuth.currentUser?.email)!)
                        sendReset = true
                    }, text: "Reset Password")
                        .foregroundColor(.black)
                        .alert(isPresented: $sendReset, content: {
                            Alert(title: Text("Reset Sent"), message: Text("A reset password email has been sent."))
                        })
                    Spacer().frame(height: 50)
                    Button {
                        deleteAccount = true
                    } label: {
                        Text("Delete Account").foregroundColor(.red)
                    }
                    .alert(isPresented: $deleteAccount, content: {
                        Alert(title: Text("Delete Account"), message: Text("Are you sure you want to delete this Account?"),
                              primaryButton: .destructive(Text("Delete"), action: {
                            loginController.deleteUser()
                            goToLogin = true
                        }), secondaryButton: .cancel())
                    })
                    NavigationLink(isActive: $goToHome, destination: {
                        HomePage()
                    }, label: {
                        EmptyView()
                    })
                    .fullScreenCover(isPresented: $goToLogin) {
                        LoginCreateAccountView()
                    }
                    
                  
                }
                .padding(.horizontal, 50)
            }

            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(constants().background)
            .navigationBarItems(trailing: Button(action: {
                goToHome = true
            }, label: {
                Image(systemName: "xmark").foregroundColor(.black)
            }))
            
        }
        .navigationBarHidden(true)
        
    }
}

struct accountSettingsView_Previews2: PreviewProvider {
    static var previews: some View {
        accountSettingsView()
    }
}
