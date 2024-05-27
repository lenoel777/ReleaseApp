//
//  EndingView.swift
//  Release
//
//  Created by Glenn Leonali on 18/05/24.
//

import SwiftUI

struct EndingView: View {
    @StateObject private var audioManager = AudioManager()
    
    @State private var showLayer = false
    @State private var animate = false
    @State private var exitButton = false
    
    let credits = [
        "CREDITS",
        "Writer: Glenn Leonali",
        "Designer: Glenn Leonali",
        "Developer: Glenn Leonali",
        "Special Thanks: All My Friends and Mentors",
        "",
        "MUSIC",
        "Inspiring Cinematic Ambient - Aleksey Chistilin from Pixabay",
        "Happy Birthday (Music Box Version) - Cumpleaños Feliz from Youtube",
        "Tearful - Oleksii Kaplunskyi from Pixabay",
        "",
        "NANO CHALLENGE 2",
        "APPLE DEVELOPER ACADEMY @BINUS C7S1",
        "@GLENNLEONALI",
        ""
    ]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("They that love beyond the world cannot be seperated by it. Death cannot kill what never dies.")
                    .foregroundStyle(Color.white)
                    .frame(width: UIScreen.main.bounds.width*4/5)
                    .font(.system(size: 42, design: .monospaced))
                    .multilineTextAlignment(.center)
                
                
                Text("- William Penn")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding()
            }.opacity(showLayer ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.3), value: showLayer)
            
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    ForEach(credits, id: \.self) { credit in
                        Text(credit)
                            .font(.system(size: 24, design: .monospaced))
                    }
                    Image("ReleaseLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/4)
                    Text("RELEASE © 2024")
                        .font(.system(size: 36, design: .monospaced))
                }
                .offset(y: animate ? -UIScreen.main.bounds.height*5/4 : UIScreen.main.bounds.height*5/4)
                .animation(Animation.linear(duration: 20), value: animate)
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .opacity(animate ? 1.0 : 0.0)
            
            VStack {
                Text("THANKS FOR PLAYING")
                    .font(.system(size: 48, design: .monospaced))
                    .fontWeight(.bold)
                Button(action: {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                }, label: {
                    Text("EXIT")
                })
                .font(.system(size: 32, design: .monospaced))
                .fontWeight(.bold)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(15)
            }
            .opacity(exitButton ? 1.0 : 0.0)
        }
        .onAppear(perform: {playEnding()})
        .navigationBarBackButtonHidden()
    }
    
    func playEnding() {
        audioManager.playMusic(filename: "tearful-99147")
        audioManager.setVolume(0.3)
        
        showLayer = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            showLayer = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            animate = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
            exitButton = true
            audioManager.fadeOutMusic()
        }
    }
}

#Preview {
    EndingView()
}
