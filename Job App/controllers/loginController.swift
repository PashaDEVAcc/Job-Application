//
//  LoginModel.swift
//  Chat App
//
//  Created by Pasha Panin on 10/31/21.
//

import Foundation
import FirebaseAuth
import SwiftUI
class LoginModel : ObservableObject {
    let FirebaseAuth = Auth.auth()
    
    func login (email : String, password : String) {
        FirebaseAuth.signIn(withEmail: email, password: password)
    
    }
    
    func deleteUser() {
        FirebaseAuth.currentUser?.delete()
    }
    func createAccount(email : String , password : String){
        FirebaseAuth.createUser(withEmail: email, password: password)
        
    }
    func signOut() {
        do {
            try FirebaseAuth.signOut()
        }catch {
            print("Error signing Out")
        }
    }
    func sendForgotPassword(email : String) {
        // send password reset
        FirebaseAuth.sendPasswordReset(withEmail: email)
    }
}
    
    
