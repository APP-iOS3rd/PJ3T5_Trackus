//
//  LoginViewModel.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class FirebaseManger: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    var flow: SignUpFlow = .nickname
    
    static let shared = FirebaseManger()
    
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}


enum AuthenticationState {
    case unauthenticated
    case authenticating
    case signUpcating
    case authenticated
}

enum SignUpFlow {
    case nickname
    case image
    case physical
    case ageGender
    case runningStyle
    case daily
}

class LoginViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage: String = ""
    @Published var user: Firebase.User?
    @Published var displayName: String = ""
    @Published var newUser: Bool = false
    
    @Published var userInfo: User
    @Published var flow: SignUpFlow = .nickname
    
    init() {
        self.userInfo = User()
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
    
    // MARK: - 로그아웃
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.authenticationState = .unauthenticated
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - 회원탈퇴
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            self.authenticationState = .unauthenticated
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            self.authenticationState = .unauthenticated
            print("deletAccount Error!!")
            return false
        }
    }
}

enum AuthenticationError: Error {
  case tokenError(message: String)
}

extension LoginViewModel {
    // MARK: - 구글 로그인
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


extension LoginViewModel {
    // MARK: - 이미지 저장 부분
    func persistImageToStorage(image: Image?) {
        // 사용자 uid 받아오기
        guard let uid = FirebaseManger.shared.auth.currentUser?.uid else {
            print("@@@@@@ error 1 @@@@@@")
            return }
        let ref = FirebaseManger.shared.storage.reference(withPath: uid)
        
        // 이미지 크기 줄이기
        guard let resizedImage = image?.asUIImage().resizeWithWidth(width: 700) else {
            print("@@@@@@ error 2 @@@@@@")
            return }
        guard let  jpegData = resizedImage.jpegData(compressionQuality: 0.5) else {
            
            print("@@@@@@ error 3 @@@@@@")
            return }
        // 이미지 포맷
        ref.putData(jpegData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to push image to Storage: \(error)")
                return
            }else{
                print("@@@@@ 이미지 업로드 성공 @@@@@@@@")
            }
            
            ref.downloadURL { url, error in
                if let error = error{
                    print("Failed to retrieve downloadURL: \(error)")
                    return
                }
                print("Successfully stored image with url: \(url?.absoluteString ?? "")")
                
                // 이미지 url 저장
                print("======================== 이미지 저장부분 ========================")
                guard let url = url else {return}
                self.userInfo.profileImageUrl = url.absoluteString
            }
        }
    }
    
    // MARK: - 사용자 정보 저장
    func storeUserInformation() {
        guard let uid = FirebaseManger.shared.auth.currentUser?.uid else {
            print("@@@@@@ error 1 @@@@@@")
            return }
        // 해당부분 자료형 지정 필요
        let userData = ["uid": uid,
                        "username": userInfo.username,
                        "weight": userInfo.weight ?? "",
                        "height": userInfo.height ?? "",
                        "age": userInfo.age ?? "",
                        "gender": userInfo.gender ?? "",
                        "isProfilePublic": userInfo.isProfilePublic,
                        "isProSubscriber": false,
                        "profileImageUrl": userInfo.profileImageUrl ?? "",
                        "setDailyGoal": userInfo.setDailyGoal ?? ""] as [String : Any]
        FirebaseManger.shared.firestore.collection("users").document(uid).setData(userData){ error in
            if error != nil {
                print("@@@@@@ error 1 @@@@@@")
                return
            }
            print("success")
            
        }
    }
}

// Image -> UIImage로 변환
extension Image {
    func asUIImage() -> UIImage {
        // Image를 UIImage로 변환하는 확장 메서드
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let size = controller.view.intrinsicContentSize
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}


// Image -> UIImage로 변환
extension UIImage {
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
