//
//  LoginPresenter.swift
//  CiceMovies
//
//  Created by cice on 15/06/2021.
//

import Foundation
import Combine
import Vera

class LoginPresenter: ObservableObject {
    
    enum PasswordChecked {
        case valid
        case empty
        case noMatch
        case notStrongEnough
    }

    
    //Input
    @Published var name = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    //Output
    @Published var isValid = false
    @Published var nameMessage = ""
    @Published var lastnameMessage = ""
    @Published var emailMessage = ""
    @Published var usernameMessage = ""
    @Published var passwordMessage = ""
    
    //Logica
    private var cancellable: Set<AnyCancellable> = []
    
    private var isNameValidPublisher: AnyPublisher<Bool, Never> {
        $name
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 5
            }
            .eraseToAnyPublisher()
    }
    
    private var isLastnameValidPublisher: AnyPublisher<Bool, Never> {
        $lastname
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 5
            }
            .eraseToAnyPublisher()
    }
    
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                let emailRegEx = "[A-Z0-9a-z.%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: input)
            }
            .eraseToAnyPublisher()
    }
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 5
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Password
    private var isPasswordEmptyValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { password, passwordAgain in
                return password == passwordAgain
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return Vera.strength(ofPassword: input)
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
        passwordStrengthPublisher
            .map { strength in
                print(Vera.localizedString(forStrength: strength))
                switch strength{
                case .reasonable, .strong, .veryStrong:
                    return true
                default:
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        //Validate Name
        isNameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "El Nombre debe contener como minimo 5 caracteres"
            }
            .assign(to: \.nameMessage, on: self)
            .store(in: &cancellable)
        
        isLastnameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "El Apellido debe contener como minimo 5 caracteres"
            }
            .assign(to: \.lastnameMessage, on: self)
            .store(in: &cancellable)
        
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "El Email debe contener una @ y una extension .com por ejemplo"
            }
            .assign(to: \.emailMessage, on: self)
            .store(in: &cancellable)
        
        isUsernameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "El Username debe contener como minimo 5 caracteres"
            }
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellable)
    }
    
    
}
