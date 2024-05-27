//
//  ContentView.swift
//  Release
//
//  Created by Glenn Leonali on 17/05/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var path = NavigationPath()
    @StateObject private var audioManager = AudioManager()
    @State private var isMuted = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .onTapGesture(perform: {
                                isMuted.toggle()
                                if isMuted {
                                    audioManager.setVolume(0)
                                } else {
                                    audioManager.setVolume(0.2)
                                }
                            })
                    }
                    Spacer()
                }
                .padding()
                
                VStack {
                    Text("RELEASE")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 72, design: .monospaced))
                    
                    Button(action: {
                        path.append("scene1")
                        audioManager.fadeOutMusic()
                    }) {
                        Text("Play")
                            .font(.system(size: 24, design: .monospaced))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .navigationDestination(for: String.self) { scene in
                        switch scene {
                        case "scene1":
                            GamePlayView(path: $path)
                        case "scene2":
                            GamePlay2View(path: $path)
                        case "scene3":
                            GamePlay3View(path: $path)
                        case "ending":
                            EndingView()
                        default:
                            Text("Unknown scene")
                        }
                    }
                }
                
                .navigationBarBackButtonHidden()
                .onAppear{
                    audioManager.playMusic(filename: "background")
                    audioManager.setVolume(0.2)
                }
            }
            .background(Color.black)
        }
    }
}

#Preview {
    ContentView()
}
