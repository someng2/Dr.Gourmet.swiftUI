//
//  SettingView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/22.
//

import SwiftUI

struct SettingView: View {
    
    let version = 1.0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("버전 정보")
                    .font(.custom("NanumSquareB", size: 16))
                    .foregroundColor(Color("LabelColor"))
                Spacer()
                Text("\(String(format: "%.1f", version))")
                    .font(.custom("NanumSquareR", size: 15))
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            Divider()
            NavigationLink {
                FeedbackView()
            } label: {
                HStack(alignment: .top) {
                    Text("의견 보내기")
                        .font(.custom("NanumSquareB", size: 16))
                        .foregroundColor(Color("LabelColor"))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("LabelColor"))
                }
            }
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            
//            Divider()
//            Button {
//                // TODO: 앱스토어 이동
//            } label: {
//                HStack(alignment: .top) {
//                    Text("앱 평가하기")
//                        .font(.custom("NanumSquareB", size: 16))
//                        .foregroundColor(Color("LabelColor"))
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(Color("LabelColor"))
//                }
//
//            }
//            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            
            Spacer()
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
