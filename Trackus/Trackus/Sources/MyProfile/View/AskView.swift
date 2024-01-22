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
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: MyProfileView()) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .padding()
                    }
                    Spacer()
                    
                    Text("문의하기")
                        .font(.title)
                        .padding()
                    
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
