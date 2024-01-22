//
//  SignUpViewModel.swift
//  Trackus
//
//  Created by 최주원 on 1/22/24.
//

import Foundation
import SwiftUI

enum SignUpFlow {
    case nickname
    case image
    case physical
    case ageGender
    case runningStyle
    case daily
}

class SignUpViewModel: ObservableObject {
    @Published var user: User
    @Published var flow: SignUpFlow = .nickname
    
    init() {
        self.user = User()
    }
}

extension SignUpViewModel {
    func persistImageToStorage(image: Image?) {
        // 사용자 uid 받아오기
        guard let uid = FirebaseManger.shared.auth.currentUser?.uid else {
            print("@@@@@@ error 1 @@@@@@")
            return }
        let ref = FirebaseManger.shared.storage.reference(withPath: uid)
        
        guard let resizedImage = image?.asUIImage().resizeWithWidth(width: 700) else {
            print("@@@@@@ error 2 @@@@@@")
            return }
        guard let  jpegData = resizedImage.jpegData(compressionQuality: 0.5) else {
            
            print("@@@@@@ error 3 @@@@@@")
            return }
        // 이미지 포맷
        //guard let imageData = self.image?.jpegDA
        ref.putData(jpegData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to push image to Storage: \(error)")
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error{
                    print("Failed to retrieve downloadURL: \(error)")
                    return
                }
                print("Successfully stored image with url: \(url?.absoluteString ?? "")")
                
                // stroe에 등록
                guard let url = url else {return}
                //self.storeUserInformation(imageProfileUrl: url)
                self.user.profileImageUrl = url.absoluteString
            }
        }
    }
    
    // 사용자 정보 저장
    func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = FirebaseManger.shared.auth.currentUser?.uid else {
            print("@@@@@@ error 1 @@@@@@")
            return }
        // 해당부분 자료형 지정 필요
        let userData = ["uid": uid,
                        "username": user.username,
                        "weight": user.weight ?? "",
                        "height": user.height ?? "",
                        "age": user.age ?? "",
                        "gender": user.gender ?? "",
                        "isProfilePublic": user.isProfilePublic,
                        "isProSubscriber": false,
                        "profileImageUrl": user.profileImageUrl ?? "",
                        "setDailyGoal": user.setDailyGoal ?? ""] as [String : Any]
        FirebaseManger.shared.firestore.collection("users").document(uid).setData(userData){ error in
            if let error = error {
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
