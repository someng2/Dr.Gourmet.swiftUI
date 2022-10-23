//
//  LaunchView.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/21.
//

import SwiftUI

struct LaunchView: View {
    @State var showingSplash = true
    @StateObject var vm: PlaceListViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                if self.showingSplash {
                    VStack {
                        Image("circleAppLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Spacer().frame(height:12)
                        Text("쩝쩝박사")
                            .font(.custom("Jalnan", size: 25))
                    }
                } else {
                    HomeView(vm: vm)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        
                        self.showingSplash = false
                        
                    }
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(vm: PlaceListViewModel())
    }
}
