//
//  LoginView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 18.10.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var userManager: UserManager
    private let storageManager = StorageManager.shared
    
    var body: some View {
        VStack {
            LoginViewText(name: $userManager.user.name, checkSigns: userManager.checkName)
            Button(action: login) {
                Label("OK", systemImage: "checkmark.circle")
            }
            .disabled(!userManager.checkName)
        }
    }
    
    private func login() {
        userManager.user.isLoggedIn.toggle()
        storageManager.save(userManager.user)
    }
}

struct LoginViewText: View {
    @Binding var name: String
    var checkSigns: Bool
    
    var body: some View {
        ZStack {
            TextField("Enter your name", text: $name)
                .multilineTextAlignment(.center)
            HStack {
                Spacer()
                Text("\(name.count)")
                    .foregroundStyle((checkSigns ? .green : .red))
                    .padding([.top, .trailing])
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserManager())
}
