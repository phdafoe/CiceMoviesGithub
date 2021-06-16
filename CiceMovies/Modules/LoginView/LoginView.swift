//
//  LoginView.swift
//  CiceMovies
//
//  Created by cice on 15/06/2021.
//

import SwiftUI

let lightGreyColor = Color(red: 239/255, green: 243/255, blue: 244/255)

struct LoginView: View {
    
    @EnvironmentObject var authState: AuthenticationManager
    @ObservedObject var loginPresenter = LoginPresenter()
    @State var authType = AuthenticationType.Signup
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Informacion Personal")){
                    VStack(alignment: .leading) {
                        UsernametextField(placeholder: "Name", title: "Name", text: self.$loginPresenter.name)
                            .autocapitalization(.none)
                            .padding(5)
                            .background(lightGreyColor)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                        if !loginPresenter.nameMessage.isEmpty {
                            Text(loginPresenter.nameMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        UsernametextField(placeholder: "Lastname", title: "Lastname", text: self.$loginPresenter.lastname)
                            .autocapitalization(.none)
                            .padding(5)
                            .background(lightGreyColor)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                        if !loginPresenter.lastnameMessage.isEmpty {
                            Text(loginPresenter.lastnameMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        UsernametextField(placeholder: "Email", title: "Email", text: self.$loginPresenter.email)
                            .autocapitalization(.none)
                            .padding(5)
                            .background(lightGreyColor)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                        if !loginPresenter.emailMessage.isEmpty {
                            Text(loginPresenter.emailMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        UsernametextField(placeholder: "Username", title: "Username", text: self.$loginPresenter.username)
                            .autocapitalization(.none)
                            .padding(5)
                            .background(lightGreyColor)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                        if !loginPresenter.usernameMessage.isEmpty {
                            Text(loginPresenter.usernameMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                Section(header: Text("Información segura")){
                    VStack(alignment: .leading) {
                        PasswordTexField(title: "Password", text: self.$loginPresenter.password)
                            .autocapitalization(.none)
                            .padding(5)
                            .background(lightGreyColor)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                        if !loginPresenter.passwordMessage.isEmpty {
                            Text(loginPresenter.passwordMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        PasswordTexField(title: "Password confirmation", text: self.$loginPresenter.passwordAgain)
                            .autocapitalization(.none)
                            .padding(5)
                            .background(lightGreyColor)
                            .cornerRadius(5)
                            .shadow(radius: 1)
                        if !loginPresenter.passwordMessage.isEmpty {
                            Text(loginPresenter.passwordMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            Button(action: {
                emailAuthenticationTapped()
            }, label: {
                Text("Login ")
            }).disabled(!self.loginPresenter.isValid)
        }

    }
    
    private func emailAuthenticationTapped() {
        switch authType {
        case .Signin:
            authState.login(with: .emailAndPassword(email: self.$loginPresenter.email.wrappedValue,
                                                    password: self.$loginPresenter.password.wrappedValue))
        default:
            authState.sigup(email: self.$loginPresenter.email.wrappedValue,
                            password: self.$loginPresenter.password.wrappedValue,
                            passwordConfirmation: self.$loginPresenter.passwordAgain.wrappedValue)
        }
    }
    
}

struct UsernametextField: View {
    
    var placeholder: String
    var title: String
    var text: Binding<String>
    
    var body: some View {
        ZStack(alignment: .leading){
            Text(title).foregroundColor(.gray).offset(y: text.wrappedValue.isEmpty ? 0 : -25).scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.6, anchor: .leading)
            TextField(placeholder, text: text).foregroundColor(.black)
        }
        .padding(.top, 15)
        .animation(.spring(response: 0.2, dampingFraction: 0.5))
    }
}

struct PasswordTexField: View {
    
    var title: String
    var text: Binding<String>
    
    var body: some View {
        ZStack(alignment: .leading){
            Text(title).foregroundColor(.gray).offset(y: text.wrappedValue.isEmpty ? 0 : -25).scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.6, anchor: .leading)
            SecureField("Password", text: text).foregroundColor(.black)
        }
        .padding(.top, 15)
        .animation(.spring(response: 0.2, dampingFraction: 0.5))
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
