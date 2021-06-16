//
//  AuthenticationManager.swift
//  CiceMovies
//
//  Created by cice on 16/06/2021.
//

import Foundation
import FirebaseAuth

enum AuthenticationType: String {
    case Signin
    case Signup
}

enum LoginOption {
    case sigInWithApple
    case emailAndPassword(email: String, password: String)
}

class AuthenticationManager: NSObject, ObservableObject {
    
    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?
    
    static let shared = AuthenticationManager()
    
    private let auth = Auth.auth()
    fileprivate var currentNonce: String?
    
    override private init() {
        loggedInUser = auth.currentUser
        super.init()
        auth.addStateDidChangeListener(authStateChanged)
    }
    
    private func authStateChanged(with auth: Auth, user: User?) {
        guard user != self.loggedInUser else {
            return
        }
        self.loggedInUser = user
    }
    
    func login(with loginOption: LoginOption) {
        self.isAuthenticating = true
        self.error = nil
        
        switch loginOption {
        case .sigInWithApple:
            //handlerSigninWithApple()
            break
        case let .emailAndPassword(email, password):
            handlerSignInWith(email: email, password: password)
        }
    }
    
    func sigup(email: String, password: String, passwordConfirmation: String){
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "Password y Confirmacion no son correctos"])
            return
        }
        self.isAuthenticating = true
        self.error = nil
        
        auth.createUser(withEmail: email, password: password, completion: handlerAuthResultCompletion)
        
    }
    
    private func handlerSignInWith(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: handlerAuthResultCompletion)
    }
    
    private func handlerAuthResultCompletion(auth: AuthDataResult?, error: Error?) {
        DispatchQueue.main.async {
            self.isAuthenticating = false
            if let user = auth?.user{
                self.loggedInUser = user
            } else if let errorDes = error {
                self.error = errorDes as NSError
            }
        }
    }
    
    func signout() {
        do {
            try auth.signOut()
        } catch let error{
            debugPrint(error.localizedDescription)
        }
        
    }
}
