//
//  AskView.swift
//  Trackus
//
//  Created by 박소희 on 1/22/24.
//

import SwiftUI
import WebKit

// 임시로 web뷰 띄우기
struct AskView: View {
    @State private var selectedQuestionIndex: Int?

    var body: some View {
        VStack {
            // NavigationBarItems를 사용하여 좌측에 뒤로가기 버튼 및 타이틀 추가
            HStack {
                NavigationLink(destination: MyProfileView()) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(TUColor.main)
                        .padding()
                }
                
                Spacer()
                
                // 가운데에 "문의하기" 텍스트
                MyTypography.subtitle(text: "문의하기")
                Spacer()
            }
                .foregroundColor(TUColor.main)
                .background(TUColor.background)
                .navigationBarHidden(true)

                // 네이버 웹뷰 추가
                NaverWebView(urlString: "https://www.naver.com")
                    .edgesIgnoringSafeArea(.bottom)
            }
    }
}

// UIKit의 WebView를 SwiftUI에서 사용할 수 있도록 Wrapping한 View
struct NaverWebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: NaverWebView

        init(_ parent: NaverWebView) {
            self.parent = parent
        }
    }
}

#Preview {
    AskView()
}
