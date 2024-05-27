//
//  GamePlay3View.swift
//  Release
//
//  Created by Glenn Leonali on 25/05/24.
//

import SwiftUI
import Vision
import CoreML

struct GamePlay3View: View {
    @Binding var path: NavigationPath
    @StateObject private var audioManager = AudioManager()
    
    @State private var showLayer1 = false
    @State private var showLayer2 = false
    @State private var showLayer3 = false
    @State private var showChallenge = false
    
    @State private var showLayer4 = false
    @State private var showLayer5 = false
    
    @State private var isPlant = false
    @State private var wrongAnswer = false
    @State private var rightAnswer = false
    
    @State private var showingImagePicker = false
    @State private var showingValidation = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
                .background(Color.black)
            
            VStack(alignment: .center) {
                Spacer()
                Text("Mother")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .padding(.bottom, 4)
                
                Text("Can you join me to sing the last Happy Birthday song for her?")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 42, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 48)
            }
            .opacity(showLayer1 ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: showLayer1)
            .padding()
            
            VStack(alignment: .center) {
                Spacer()
                Text("Mother")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .padding(.bottom, 4)
                
                Text("Oh my poor child...")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 42, design: .monospaced))
                    .padding(.bottom, 48)
            }
            .opacity(showLayer2 ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: showLayer2)
            .padding()
            
            VStack(alignment: .center) {
                Spacer()
                Text("Mother")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .padding(.bottom, 4)
                
                Text("This may be your last birthday, but you are always in my heart.")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 42, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 48)
            }
            .opacity(showLayer3 ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: showLayer3)
            .padding()
            
            ZStack {
                VStack(alignment: .center) {
                    Spacer()
                    Text("CHALLENGE 3")
                        .font(.system(size: 28, design: .monospaced))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 48)
                    Text("Find a small Plant!")
                        .font(.system(size: 36, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("Start")
                            .font(.system(size: 24, design: .monospaced))
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding(.bottom, 48)
                    
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                    .background(Color.gray)
                    .opacity(showChallenge ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.2), value: showChallenge)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                            .interactiveDismissDisabled(true)
                    }
                    .onChange(of: inputImage) { newValue in
                        if newValue != nil {
                            showingValidation = true
                        }
                    }
                    .sheet(isPresented: $showingValidation){
                        Validation3(inputImage: $inputImage, isPlant: $isPlant, isPresented: $showingValidation)
                            .interactiveDismissDisabled(true)
                    }
                    .onChange(of: showingValidation) { newValue in
                        playAnswerScreen()
                    }
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("Mother")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 24, design: .monospaced))
                        .padding(.bottom, 4)
                    
                    Text("This plant represents a new life, I'm sure that is what she wants for me.")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 42, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .padding([.bottom, .horizontal], 48)
                }
                .opacity(showLayer4 ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.2), value: showLayer4)
                .padding()
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("Mother")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 24, design: .monospaced))
                        .padding(.bottom, 4)
                    
                    Text("Focus on life and not dwelling in the past.")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 42, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .padding([.bottom, .horizontal], 48)
                }
                .opacity(showLayer5 ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.2), value: showLayer5)
                .padding()
                
                VStack {
                    Text("WHAT IS THIS?! :(")
                        .font(.system(size: 28, design: .monospaced))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                    .background(Color.red)
                    .opacity(wrongAnswer ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.2), value: wrongAnswer)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                VStack {
                    Text("YOU GOT THE RIGHT PLANT :)")
                        .font(.system(size: 28, design: .monospaced))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                    .background(Color.green)
                    .opacity(rightAnswer ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.2), value: rightAnswer)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
            }
            
        }
        .onAppear() {
            playScene()
        }
        .navigationBarBackButtonHidden()
    }
    
    func playScene() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showLayer1 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            showLayer1 = false
            audioManager.playSound(filename: "hbdMusicbox")
            audioManager.setVolume(0.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            showLayer2 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            showLayer2 = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 32.0) {
            showLayer3 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 37.0) {
            showLayer3 = false
            showChallenge = true
        }
        
    }
    
    func playScene2(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showLayer4 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            showLayer4 = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            showLayer5 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 16.0) {
            showLayer5 = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 17.0) {
            path.append("ending")
        }
    }
    
    func playAnswerScreen(){
        if isPlant {
            rightAnswer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                showChallenge = false
                rightAnswer = false
                playScene2()
            }
        }else {
            wrongAnswer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                wrongAnswer = false
            }
        }
    }
    
}
