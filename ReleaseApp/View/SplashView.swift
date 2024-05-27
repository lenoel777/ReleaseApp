//
//  SplashView.swift
//  Release
//
//  Created by Glenn Leonali on 18/05/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack {
            if isActive {
                ContentView()
            }else {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .background(Color.black)
                    
                    VStack {
                        Image("ReleaseLogo")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(CGSize(width: 0.8, height: 0.8))
                    }
                    .padding()
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
