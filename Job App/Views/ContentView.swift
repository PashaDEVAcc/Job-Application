//
//  ContentView.swift
//  Chat App
//
//  Created by Pasha Panin on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView {
            LoginCreateAccountView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
