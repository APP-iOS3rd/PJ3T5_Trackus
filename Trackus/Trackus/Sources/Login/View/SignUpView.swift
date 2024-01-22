//
//  SignUpView.swift
//  Trackus
//
//  Created by 최주원 on 1/20/24.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage


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


struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    //@Environment(\.dismiss) var dismiss
    
    var body: some View {
        TUCanvas.CustomCanvasView {
            switch viewModel.flow {
            case .nickname:
                NickNameView()
                    .environmentObject(viewModel)
            case .image:
                ImageView()
                    .environmentObject(viewModel)
            case .physical:
                PhysicalView()
                    .environmentObject(viewModel)
            case .ageGender:
                AgeGenderView()
            case .runningStyle:
                RunningStyleView()
            case .daily:
                DailyGoalView()
            }
        }
        .animation(.easeInOut, value: viewModel.flow)
    }
}

// MARK: - 위쪽 설명 부분 UI
struct Description: View {
    var image: Image? = nil
    let title: String
    let description: String
    
    var body: some View {
        VStack{
            if let image = image {
                Spacer()
                    .frame(maxHeight: 60)
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50,height: 50)
                    .foregroundStyle(.white)
            }else{
                Spacer()
                    .frame(maxHeight: 120)
            }
            MyTypography.title(text: title)
                .padding(.top, 10)
            MyTypography.body(text: description)
                .padding(.top, 10)
        }
    }
}

// MARK: - 닉네임 입력
struct NickNameView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @State private var check = false
    var body: some View {
        VStack{
            Description(image: Image(systemName: "person.circle"),title: "닉네임 입력", description: "다른 러너들에게 자신을 잘 나타낼 수 있는 닉네임을 입력해주세요!")
            
            TUTextField(placeholder: "닉네임", text: $viewModel.user.username, availability: $check)
                .padding(.top, 40)
            
            Spacer()
            TUButton(active: check, buttonText: "다음으로") {
                viewModel.flow = .image
            }
        }
        .padding(20)
    }
}

// MARK: - 프로필 사진 선택
struct ImageView:View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    
    var body: some View {
        ZStack{
            // 건너뛰기 버튼
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        // 입력값 nil 처리 -> flow 다음차례
                    }, label: {
                        MyTypography.bodytitle(text: "건너뛰기")
                    })
                    Spacer()
                }
            }
            VStack{
                Description(image: Image(systemName: "person.circle"), title: "프로필 사진 선택", description: "다른 러너들에게 자신을 잘 나타낼 수 있는 프로필 이미지를 설정해주세요!")
                
                // 프로필 이미지 선택
                PhotosPicker(selection: $selectedPhoto,
                             matching: .images,
                             photoLibrary: .shared()) {
                    if let image = self.image {
                        ZStack{
                            image
                                .resizable()
                                .frame(width: 128, height: 128)
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 190))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 70)
                                        .stroke( .gray, lineWidth: 2)
                                )
                            Button(action: {
                                self.image = nil
                            }, label: {
                                Image(systemName: "minus.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 30))
                                    .foregroundColor(.accentColor)
                            })
                            .offset(x: 50, y: 50)
                        }
                        
                    }else{
                        ZStack{
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding(24)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 190))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 70)
                                        .stroke( .gray, lineWidth: 4)
                                )
                                .foregroundStyle(.gray)
                            Image(systemName: "plus.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                                .offset(x: 50, y: 50)
                        }
                    }
                }
                // 비동기 처리 - 이미지 로딩때문에 다른 부분 실행 안되는 부분 방지
                             .task(id: selectedPhoto) {
                                 image = try? await selectedPhoto?.loadTransferable(type: Image.self)
                             }
                             .animation(.easeInOut, value: image)
                             .padding(.top, 40)
                
                Spacer()
                TUButton(active: image != nil, buttonText: "다음으로") {
                    viewModel.flow = .physical
                }
            }
        }.padding(20)
    }
}

// MARK: - 신체 정보 입력
struct PhysicalView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @State private var height: Int = 150
    @State private var weight: Int = 50
    @State private var isHeightPickerPresented = false
    @State private var isWeightPickerPresented = false
    
    let heights = 120..<230 // 키 범위
    let weights = 20..<150 // 체중 범위
    
    var body: some View {
        ZStack{
            // 건너뛰기 버튼
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        // 입력값 nil 처리 -> flow 다음차례
                    }, label: {
                        MyTypography.bodytitle(text: "건너뛰기")
                    })
                    Spacer()
                }
            }
            VStack{
                Description(image: Image(systemName: "heart"), title: "신체 정보 입력", description: "러닝 기록 분석, 칼로리 소모량 등 더욱 정확한 러닝 데이터 분석을 위해서 다음 정보가 필요합니다.")
                VStack {
                    Text("Height: \(height) cm")
                        .foregroundColor(.white)
                        .onTapGesture {
                            isHeightPickerPresented = true
                        }
                        .sheet(isPresented: $isHeightPickerPresented) {
                            PickerSheet(title: "키", unit: "cm",values: heights, selectedValue: $height)
                            //.presentationDetents([.height(250)])
                        }
                    
                    // Weight
                    Text("Weight: \(weight) kg")
                        .foregroundColor(.white)
                        .onTapGesture {
                            isWeightPickerPresented = true
                        }
                        .sheet(isPresented: $isWeightPickerPresented) {
                            PickerSheet(title: "몸무게", unit: "kg",values: weights, selectedValue: $weight)
                        }
                }
                .padding(.top, 40)
                
                Spacer()
                TUButton(active: false, buttonText: "다음으로") {
                    
                }
            }
        }
        .padding(20)
    }
}

// MARK: - 연령대 및 신채정보

struct AgeGenderView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    private let nextflow: SignUpFlow = .runningStyle
    private let image = Image(.genderMark)
    private let title = "연령대 및 성별"
    private let description = "연령대 정보를 선택하면 더욱 정확한 러닝 데이터 및 칼로리 소모량을 측정할 수 있습니다."
    
    var body: some View {
        ZStack{
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        viewModel.flow = nextflow
                    }, label: {
                        MyTypography.bodytitle(text: "건너뛰기")
                    })
                    Spacer()
                }
            }
            VStack{
                Description(image: image, title: title, description: description)
            }
        }
        .padding(20)
    }
}

// MARK: - 러닝 스타일

struct RunningStyleView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    private let nextflow: SignUpFlow = .daily
    private let image = Image(.runMark)
    private let title = "러닝 스타일"
    private let description = "원하는 러닝 스타일을 설정하고 그에 맞는 피드백을 받아보세요."
    
    var body: some View {
        ZStack{
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        viewModel.flow = nextflow
                    }, label: {
                        MyTypography.bodytitle(text: "건너뛰기")
                    })
                    Spacer()
                }
            }
            VStack{
                Description(image: image, title: title, description: description)
            }
        }
        .padding(20)
    }
}

// MARK: - 일일 목표량

struct DailyGoalView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    private let nextflow: SignUpFlow = .runningStyle
    private let image = Image(.calendarMark)
    private let title = "일일 운동량"
    private let description = "하루에 정해진 운동량을 설정하고 꾸준히 뛸 수 있는 이유를 만들어 주세요."
    
    var body: some View {
        ZStack{
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        viewModel.flow = nextflow
                    }, label: {
                        MyTypography.bodytitle(text: "건너뛰기")
                    })
                    Spacer()
                }
            }
            VStack{
                Description(image: image, title: title, description: description)
            }
        }
        .padding(20)
    }
}



#Preview {
    SignUpView()
}
