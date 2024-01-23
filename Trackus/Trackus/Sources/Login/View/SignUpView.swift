//
//  SignUpView.swift
//  Trackus
//
//  Created by 최주원 on 1/20/24.
//

import SwiftUI
import PhotosUI
import Combine

struct SignUpView: View {
    @EnvironmentObject var viewModel: LoginViewModel
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
                    .environmentObject(viewModel)
            case .runningStyle:
                RunningStyleView()
                    .environmentObject(viewModel)
            case .daily:
                DailyGoalView()
                    .environmentObject(viewModel)
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
    @EnvironmentObject var viewModel: LoginViewModel
    @State private var check = false
    var body: some View {
        VStack{
            Description(image: Image(systemName: "person.circle"),title: "닉네임 입력", description: "다른 러너들에게 자신을 잘 나타낼 수 있는 닉네임을 입력해주세요!")
            
            TUTextField(placeholder: "닉네임", text: $viewModel.userInfo.username, availability: $check)
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
    @EnvironmentObject var viewModel: LoginViewModel
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
                        viewModel.userInfo.profileImageUrl = nil
                        viewModel.flow = .physical
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
                    viewModel.persistImageToStorage(image: image)
                    viewModel.flow = .physical
                }
            }
        }.padding(20)
    }
}

// MARK: - 신체 정보 입력 View
struct PhysicalView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @State private var isHeightPickerPresented = false
    @State private var isWeightPickerPresented = false
    @State private var height: Int = 170
    @State private var weight: Int = 60
    
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
                        viewModel.userInfo.height = nil
                        viewModel.userInfo.weight = nil
                        viewModel.flow = .ageGender
                    }, label: {
                        MyTypography.bodytitle(text: "건너뛰기")
                    })
                    Spacer()
                }
            }
            VStack{
                Description(image: Image(systemName: "heart"), title: "신체 정보 입력", description: "러닝 기록 분석, 칼로리 소모량 등 더욱 정확한 러닝 데이터 분석을 위해서 다음 정보가 필요합니다.")
                VStack {
                    HStack{
                        MyTypography.bodytitle(text: "키")
                            .frame(width: 50)
                            
                        BoxModifier{
                            if let height = viewModel.userInfo.height {
                                Text("\(height)")
                            }else{
                                Text("-")
                            }
                        }
                        .onTapGesture {
                            isHeightPickerPresented = true
                        }
                        .sheet(isPresented: $isHeightPickerPresented) {
                            PickerSheet(title: "키", unit: "cm",values: heights, selectedValue: $height)
                        }
                        .onChange(of: height) { setHeight in
                            viewModel.userInfo.height = setHeight
                        }
                        MyTypography.bodytitle(text: "cm")
                            .frame(width: 50)
                    }
                    .padding(8)
                    
                    // Weight
                    
                    HStack{
                        MyTypography.bodytitle(text: "몸무게")
                            .frame(width: 50)
                        BoxModifier{
                            if let weight = viewModel.userInfo.weight {
                                Text("\(weight)")
                            }else{
                                Text("-")
                            }
                        }
                        .onTapGesture {
                            isWeightPickerPresented = true
                        }
                        .sheet(isPresented: $isWeightPickerPresented) {
                            PickerSheet(title: "몸무게", unit: "kg",values: weights, selectedValue: $weight)
                        }
                        .onChange(of: weight) { setWeight in
                            viewModel.userInfo.weight = setWeight
                        }
                        MyTypography.bodytitle(text: "kg")
                            .frame(width: 50)
                    }
                    .padding(8)
                }
                .padding(.top, 40)
                
                Spacer()
                TUButton(active: viewModel.userInfo.height != nil && viewModel.userInfo.weight != nil, buttonText: "다음으로") {
                    viewModel.flow = .ageGender
                    
                }
            }
        }
        .padding(20)
    }
}

// MARK: - 연령대 및 신채정보 View

struct AgeGenderView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    private let nextflow: SignUpFlow = .runningStyle
    private let image = Image(.genderMark)
    private let title = "연령대 및 성별"
    private let description = "연령대 정보를 선택하면 더욱 정확한 러닝 데이터 및 칼로리 소모량을 측정할 수 있습니다."
    
    @State private var isAgePickerPresented = false
    @State private var age = 2 // user에 대입할때 * 10 해서 반환
    private var ages = 1..<8
    
    @State private var gender: Bool?
    
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
                VStack{
                    HStack{
                        MyTypography.bodytitle(text: "나이")
                            .frame(width: 50)
                        
                        BoxModifier{
                            if let age = viewModel.userInfo.age {
                                Text("\(age)")
                            }else{
                                Text("-")
                            }
                        }
                        .onTapGesture {
                            isAgePickerPresented = true
                        }
                        .sheet(isPresented: $isAgePickerPresented) {
                            PickerSheet(title: "연령대", unit: "0 대",values: ages, selectedValue: $age)
                        }
                        .onChange(of: age) { setAge in
                            viewModel.userInfo.age = setAge * 10
                        }
                        MyTypography.bodytitle(text: "대")
                            .frame(width: 50)
                    }
                    .padding(8)
                    
                    // 성별
                    HStack{
                        MyTypography.bodytitle(text: "성별")
                            .frame(width: 50)
                        BoxModifier(width: 72, color: gender ?? false ? TUColor.main : TUColor.box) {
                            Button(action: {
                                gender = true
                            }, label: {
                                Text("남자")
                                    .foregroundStyle(gender ?? false ? .black : .white)
                            })
                        }
                        //.background(gender ?? false ? TUColor.main : TUColor.box)
                        BoxModifier(width: 72, color: gender ?? true ? TUColor.box : TUColor.main) {
                            Button(action: {
                                gender = false
                            }, label: {
                                Text("여자")
                                    .foregroundStyle(gender ?? true ? .white : .black)
                            })
                        }
                        MyTypography.bodytitle(text: "")
                            .frame(width: 50)
                    }
                    .animation(.easeOut(duration: 0.5), value: gender)
                    .padding(8)
                }
                .padding(.top, 40)
                Spacer()
                TUButton(active: viewModel.userInfo.age != nil && gender != nil, buttonText: "다음으로") {
                    viewModel.userInfo.gender = gender
                    viewModel.flow = .runningStyle
                }
            }
        }
        .padding(20)
    }
}

// MARK: - 러닝 스타일 View

struct RunningStyleView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    private let nextflow: SignUpFlow = .daily
    private let image = Image(.runMark)
    private let title = "러닝 스타일"
    private let description = "원하는 러닝 스타일을 설정하고 그에 맞는 피드백을 받아보세요."
    
    @State private var runningStyle: Int?
    
    
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
                VStack{
                    BoxModifier(width: 200, color: runningStyle == 0 ? TUColor.main : TUColor.box) {
                        Button(action: {
                            runningStyle = 0
                        }, label: {
                            Text("0번스타일")
                                .foregroundStyle(runningStyle == 0 ? .black : .white)
                        })
                    }
                    .padding(8)
                    BoxModifier(width: 200, color: runningStyle == 1 ? TUColor.main : TUColor.box) {
                        Button(action: {
                            runningStyle = 1
                        }, label: {
                            Text("1번스타일")
                                .foregroundStyle(runningStyle == 1 ? .black : .white)
                        })
                    }
                    .padding(8)
                    BoxModifier(width: 200, color: runningStyle == 2 ? TUColor.main : TUColor.box) {
                        Button(action: {
                            runningStyle = 2
                        }, label: {
                            Text("2번스타일")
                                .foregroundStyle(runningStyle == 2 ? .black : .white)
                        })
                    }
                    .padding(8)
                    BoxModifier(width: 200, color: runningStyle == 3 ? TUColor.main : TUColor.box) {
                        Button(action: {
                            runningStyle = 3
                        }, label: {
                            Text("3번스타일")
                                .foregroundStyle(runningStyle == 3 ? .black : .white)
                        })
                    }
                    .padding(8)
                }
                .animation(.easeOut(duration: 0.2), value: runningStyle)
                .padding(.top, 20)
                Spacer()
                TUButton(active: runningStyle != nil, buttonText: "다음으로") {
                    // 러닝스타일 추가하면 추가로 작성
                    viewModel.flow = .daily
                }
            }
        }
        .padding(20)
    }
}

// MARK: - 일일 목표량 View

struct DailyGoalView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    private let nextflow: SignUpFlow = .runningStyle
    private let image = Image(.calendarMark)
    private let title = "일일 운동량"
    private let description = "하루에 정해진 운동량을 설정하고 꾸준히 뛸 수 있는 이유를 만들어 주세요."
    
    @State private var isProfilePublic: Bool = false
    @State private var setDailyGoal: Double?
    @State private var setDailyGoalString: String = ""
    
    @State private var inputError: String = ""
    
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
                HStack{
                    MyTypography.bodytitle(text: "거리")
                        .frame(width: 50)
                    BoxModifier(){
                        TextField("일일 목표", text: $setDailyGoalString)
                            .keyboardType(.decimalPad)
                            // 숫자, . 만 입력
                            .onReceive(Just(setDailyGoalString)) { newValue in
                                let filtered = newValue.filter { "0123456789.".contains($0)}
                                if filtered != newValue {
                                    self.setDailyGoalString = filtered
                                }
                            }
                    }
                    MyTypography.bodytitle(text: "km")
                        .frame(width: 50)
                }
                .padding(.top, 40)
                Spacer()
                HStack{
                    MyTypography.body(text: "사용자 프로필 공개 여부")
                    Spacer()
                    Image(systemName: isProfilePublic ? "checkmark.circle.fill": "circle")
                        .foregroundStyle(.white)
                }
                .padding(5)
                .onTapGesture {
                    self.isProfilePublic.toggle()
                }
                .animation(.easeInOut(duration: 0.2), value: isProfilePublic)
                TUButton(active: !setDailyGoalString.isEmpty || isProfilePublic != false, buttonText: "완료") {
                    viewModel.userInfo.setDailyGoal = Double(setDailyGoalString)
                    viewModel.userInfo.isProfilePublic = isProfilePublic
                    viewModel.storeUserInformation()
                    viewModel.authenticationState = .authenticated
                }
            }
        }
        .padding(20)
    }
}

// 입력 박스
struct BoxModifier<Content: View>: View {
    private let content: Content
    private let width: CGFloat
    private var color: Color = TUColor.box
    
    init(@ViewBuilder content: () -> Content) {
        self.width = 160
        self.content = content()
    }
    
    init(width: CGFloat, color: Color, @ViewBuilder content: () -> Content) {
        self.width = width
        self.content = content()
        self.color = color
    }
    
    var body: some View {
        content
            .foregroundColor(.white)
            .padding(12)
            .frame(width: width)
            .background(color)
            .cornerRadius(Constants.ViewLayoutConst.VIEW_STANDARD_CORNER_RADIUS)
    }
}

#Preview {
    SignUpView()
}
