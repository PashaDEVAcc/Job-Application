//
//  constants.swift
//  Chat App
//
//  Created by Pasha Panin on 11/1/21.
//

import SwiftUI
import FirebaseAuth
struct constants: View {
    let showComments = false
    let FirebaseAuth = Auth.auth()
    @ObservedObject private var postController = PostViewModel()
    let background = Color(#colorLiteral(red:  0.8980392157, green: 0.9333333333, blue: 1,alpha: 1))
    let offWhite = Color(red: 250 / 255, green: 250 / 255, blue: 255 / 255)
    let shadow1 = Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
    func genericTextView(label : String, text : Binding<String>) -> some View {
        return TextField(label, text: text )
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .foregroundColor(.black)
            .accentColor(.black)
    }
    
  
    func secureGenericTextField(label : String, text : Binding<String>) -> some View{
        return   SecureField(label , text: text)
            .autocapitalization(.none)
            .foregroundColor(.black)
            .disableAutocorrection(true)
            .accentColor(.black)
    }
    func appButton(onPressed: @escaping () -> Void, text : String) -> some View {
        return Button(action: onPressed) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(constants().offWhite)
                    .shadow(color:constants().shadow1, radius: 20, x: 20, y: 20)
                    .shadow(color:.white, radius: 20, x: -20 , y: -20)
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Text(text).foregroundColor(.black)
                        Spacer()
                    }
                    Spacer()
                }
                
            }
        }
        
    }
    var body: some View {
        EmptyView()
    }
}
