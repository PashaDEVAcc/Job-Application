//
//  ForgotPassword.swift
//  Chat App
//
//  Created by Pasha Panin on 10/31/21.
//

import SwiftUI

struct ForgotPassword: View {
    let loginModel = LoginModel()
    @State var sendReset = false
    @State var email = ""
    @State var goToLogin = false
    var body: some View {
        NavigationView{
            ScrollView {
                Text("Looks like you forgot something...").font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 20)
                Image(systemName: "lock.shield")
                    .resizable()
                    .frame(width: 155, height: 175)
                    .foregroundColor(.black)
                Spacer().frame(height: 20)
                Text("Dont Worry. Just Enter the email that you created your account with.").foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                constants().genericTextView(label: "Email...", text: $email).padding(30)
                Spacer().frame(height: 20)
                Button {
                    if email != "" {
                        loginModel.sendForgotPassword(email: email)
                        sendReset = true
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(constants().offWhite)
                            .shadow(color:constants().shadow1, radius: 20, x: 20, y: 20)
                            .padding()
                        VStack {
                            Spacer().frame(height: 40)
                            HStack {
                            
                                Text("Send Password Reset").foregroundColor(.black)
    
                            }
                            Spacer().frame(height: 40)
                        }
                        
                    }
                    
                }
                Spacer()
                    .alert(isPresented: $sendReset, content: {
                        Alert(title: Text("Reset Sent"), message: Text("If an account with this email is found we will send the password reset."))
                    })
            }
            .navigationBarItems(trailing: NavigationLink(destination: {
                LoginCreateAccountView()
            }, label: {
                Image(systemName: "xmark").foregroundColor(.black)
            }))
            .navigationTitle("Forgot Password")
            .font(.title3)
            .navigationBarTitleDisplayMode(.inline)
            .padding(20)
            .background(constants().background)
        }
        .navigationBarHidden(true)
      
            
    }
        
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
