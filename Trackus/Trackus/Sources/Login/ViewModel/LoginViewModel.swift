//
//  LoginViewModel.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case signUpcating
    case authenticated
}

class LoginViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage: String = ""
    @Published var user: FirebaseAuth.User?
    @Published var displayName: String = ""
    @Published var newUser: Bool = false
    
    
    init() {
        registerAuthStateHandler()
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                if user == nil {
                    // user가 없으면서 newUser가 false일 때
                    self.authenticationState = .unauthenticated
                } else if self.newUser {
                    // user가 있고, newUser가 true일 때
                    self.authenticationState = .signUpcating
                } else {
                    // user가 있고, newUser가 false일 때
                    self.authenticationState = .authenticated
                }
                //self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
            }
        }
    }
    
    // 로그아웃
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    // 회원 탈퇴
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}

enum AuthenticationError: Error {
  case tokenError(message: String)
}

extension LoginViewModel {
    // 구글 로그인
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("client ID 없음")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("root view controller 없음")
            return false
        }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            let user = userAuthentication.user
            guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token 누락") }
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            
            // 신규 사용자 여부 확인
            if result.additionalUserInfo?.isNewUser == true {
                self.newUser = true
                self.authenticationState = .signUpcating
                print("@@@@@@@@ 신규 사용자 @@@@@@@@@@@@@@@@@@")
            }else {
                print("@@@@@@@@ 기존 사용자 @@@@@@@@@@@@@@@@@@")
                    self.newUser = false
            }
            print("email : \(firebaseUser.email ?? "unknown") 로 로그인")
            return true
        }
        catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
            return false
        }
    }
}

extension UIApplication {
  var currentKeyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .first
  }

  var rootViewController: UIViewController? {
    currentKeyWindow?.rootViewController
  }
}
