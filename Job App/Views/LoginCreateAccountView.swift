//
//  LoginCreateAccountView.swift
//  Chat App
//
//  Created by Pasha Panin on 10/31/21.
//

import SwiftUI

import FirebaseAuth
struct LoginCreateAccountView: View {
    let FirebaseAuth = Auth.auth()
    @State var loading  = false
    let loginModel = LoginModel()
    @State var passwordReset = false
    @State var isRegisterMode = false
    @State var isHomePage  = false
    @State var email = ""
    @State var password = ""
    @State var seePassword = false
    var body: some View {
        NavigationView {
            ZStack {
                
            
            ScrollView {
                Picker(selection: $isRegisterMode,label: Text("Picker Here"), content: {
                    Text("Login")
                        .tag(false)
                    Text("Create Account")
                        .tag(true)
                } ).pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(.black)
                    .padding()
                Spacer()
                
                
                Image(systemName: "ellipsis.bubble.fill")
                    .resizable()
                    .frame(width: 125, height: 125)
                Spacer().frame(height: 30)
                Group {
                    Spacer().frame( height: 50)
                    HStack {
                        Image(systemName: "envelope.circle.fill")
                            .resizable()
                            .frame(width: 25,height: 25)
                        constants().genericTextView(label : "Email...", text : $email).keyboardType(.emailAddress)
                            .background(constants().background)
                        
                    }
                    Spacer().frame( height: 50)
                    ZStack {
                        
                        HStack {
                            Image(systemName: "lock.circle.fill")
                                .resizable()
                                .frame(width: 26,height: 25)
                            Spacer()
                            if seePassword {
                                constants().genericTextView(label: "Password...", text: $password)
                                    .background(constants().background)
                                
                            }else {
                                constants().secureGenericTextField(label: "Password...", text: $password)
                                    .background(constants().background)
                            }
                        }
                        Button  {
                            seePassword.toggle()
                        } label: {
                            Image(systemName: seePassword ? "eye.slash.fill" : "eye.fill").foregroundColor(.black)
                        }.padding(.leading, 250.0).multilineTextAlignment(.trailing)
                        
                    }
                }
                Spacer().frame( height: 50)
                Group {
                    constants().appButton(onPressed: {
                        if email != "" && password != "" {
                            if isRegisterMode {
                                loginModel.createAccount(email: email, password: password)
                            }else {
                                loginModel.login(email: email, password: password)
                                
                            }
                            
                            FirebaseAuth.addStateDidChangeListener { auth, user in
                                if user != nil {
                                    isHomePage = true
                                }
                            }
                            
                        }
                    }, text: isRegisterMode ? "Create Account" : "Login")
                    
                    if !isRegisterMode {
                        
                    }
                    NavigationLink(isActive: $isHomePage) {
                        HomePage()
                    } label: {
                        EmptyView()
                    }

                    
                    Spacer().frame(height: 30)
                    Spacer().frame(height: 30)
                    NavigationLink {
                        ForgotPassword()
                    } label: {
                        Text("Forgot Password?").foregroundColor(.black)
                    }
                    
                    
                }
                
            }
                if loading {
                    ProgressView()
                }
            
        }
            .padding(50)
            .background(constants().background)
            .navigationTitle(isRegisterMode ? "Create Account" : "Login").font(.title3)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarHidden(true)
    }
}

struct LoginCreateAccountView_Previews : PreviewProvider {
    static var previews: some View {
        LoginCreateAccountView()
            .preferredColorScheme(.light)
    }
}
