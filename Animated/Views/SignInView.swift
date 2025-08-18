//
//  SignInView.swift
//  Animated
//
//  Created by Hiển Hảo on 17/08/2025.
//

import SwiftUI
import RiveRuntime

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    @Binding var showModal: Bool
    
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    
    func logIn() {
        isLoading = true
        if email.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                check.triggerInput("Error")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isLoading = false
            })
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                check.reset()
                check.triggerInput("Check")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isLoading = false
                confetti.triggerInput("Trigger explosion")
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                withAnimation {
                    showModal = false
                }
            })
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Sign In")
                .customFont(.largeTitle)
            Text("Access to 240+ hours of content. Learn design and code, by building real apps with React and Swift.")
                .customFont(.headline)
            
            VStack(alignment: .leading) {
                Text("Email")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $email)
                    .customTextField()
            }
            
            VStack(alignment: .leading) {
                Text("Password")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                SecureField("", text: $password)
                    .customTextField(image: Image("Icon Lock"))
            }
            
            Button {
                logIn()
            } label: {
                Label("Sign In", systemImage: "arrow.right")
                    .customFont(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background {
                        UnevenRoundedRectangle(cornerRadii:.init(
                            topLeading: 8  ,
                            bottomLeading: 20,
                            bottomTrailing: 20,
                            topTrailing: 20))
                        .fill(Color(hex: "F77D8E"))
                    }
                    .foregroundColor(.white)
                    .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
            }
            
            HStack {
                Rectangle().frame(height: 1).opacity(0.1)
                Text("OR")
                    .customFont(.subheadline2)
                    .foregroundColor(.black.opacity(0.3))
                Rectangle().frame(height: 1).opacity(0.1)
            }
            
            Text("Sign up with Email, Apple or Google")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image("Logo Email")
                Spacer()
                Image("Logo Apple")
                Spacer()
                Image("Logo Google")
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding()
        .overlay(
            ZStack {
                if isLoading {
                    check.view()
                        .frame(width: 100, height: 100)
                        .allowsHitTesting(false)
                }
                confetti.view()
                    .scaleEffect(3)
                    .allowsHitTesting(false)
            }
            
        )
    }
}

#Preview {
    SignInView(showModal: .constant(true as Bool))
}
