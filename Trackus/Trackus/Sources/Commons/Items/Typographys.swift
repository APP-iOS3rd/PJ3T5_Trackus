import SwiftUI

struct MyTypography {
    
    //타이틀
    /// 타이틀 ( size : 28 )
    static func title(text: String) -> Text {
        return Text(text)
            .font(Font.system(size: 28, weight: .bold))
            .foregroundColor(.white)
    }
    //서브 타이틀
    /// 서브 타이틀 ( size : 20 )
    static func subtitle(text: String) -> Text {
        return Text(text)
            .font(Font.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
    }
    //본문 타이틀
    /// 본문 타이틀 ( size : 17 )
    static func bodytitle(text: String) -> Text {
        return Text(text)
            .font(Font.system(size: 17, weight: .semibold))
            .foregroundColor(.white)
    }
    //본문
    /// 본문 ( size : 15, .gray )
    static func body(text: String) -> Text {
        return Text(text)
            .font(Font.system(size: 15, weight: .regular))
            .foregroundColor(.gray)
    }
}

struct Typographys: View {
    var body: some View {
        
        VStack {
            //예시
            MyTypography.title(text: "트랙어스 TrackUs")
            MyTypography.subtitle(text: "트랙어스 TrackUs")
            MyTypography.bodytitle(text: "트랙어스 TrackUs")
            MyTypography.body(text: "트랙어스 TrackUs")
            
        }
        .frame(width: 1000, height: 1000)
        .background(.black)
    }
}

#Preview {
    Typographys()
}
