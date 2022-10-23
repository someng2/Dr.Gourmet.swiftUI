//
//  FeedbackView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/22.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack(alignment: .center) {
            Spacer()
            VStack {
                Text("카카오톡 오픈채팅방을 통해")
                Spacer().frame(height: 5)
                Text("궁금한 점이나 의견을 편하게 보내주세요.")
                Spacer().frame(height: 20)
                Text("이용자 분들의 솔직한 의견은")
                Spacer().frame(height: 5)
                Text("쩝쩝박사 운영에 큰 도움이 됩니다 ❤️")
            }.font(.custom("NanumSquareR", size: 15))
                .foregroundColor(Color("LabelColor"))
//            Spacer().frame(height: 100)
             
            Spacer()
            Link(destination: URL(string: "https://open.kakao.com/o/sacWLhJe")!) {
                HStack(spacing: 20) {
                    Image("kakaoLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                    Text("1:1 오픈채팅 참여하기")
                        .font(.custom("NanumSquareB", size: 16))
                        .foregroundColor(.white)
                        
                        
                }.frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color("SecondaryOrange"))
                    .cornerRadius(35)
            }
            Spacer().frame(height: 30)
            
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("의견 보내기")
                        .font(.custom("HancomMalangMalang-Bold", size: 19))
                        .foregroundColor(Color.black)
                }
            }
        }
        .toolbarBackground(
            Color("PrimaryColor"),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(height: 40)
            }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
