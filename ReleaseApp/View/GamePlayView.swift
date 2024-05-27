//
//  GamePlayView.swift
//  Release
//
//  Created by Glenn Leonali on 18/05/24.
//

import SwiftUI
import Vision
import CoreML

struct GamePlayView: View {
    @Binding var path: NavigationPath
    @StateObject private var audioManager = AudioManager()
    
    @State private var showLayer1 = false
    @State private var showLayer2 = false
    @State private var showLayer3 = false
    @State private var showLayer4 = false
    @State private var showChallenge = false
    @State private var isFemale = false
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
            
            Text("You see nothing...")
                .foregroundStyle(Color.white)
                .font(.system(size: 52, design: .monospaced))
                .opacity(showLayer1 ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.3), value: showLayer1)
            
            Text("You feel nothing...")
                .foregroundStyle(Color.white)
                .font(.system(size: 52, design: .monospaced))
                .opacity(showLayer2 ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.3), value: showLayer2)
            
            Text("You hear... something")
                .foregroundStyle(Color.white)
                .font(.system(size: 52, design: .monospaced))
                .opacity(showLayer3 ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.3), value: showLayer3)
            
            VStack(alignment: .center) {
                Spacer()
                Text("Little Girl")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .padding(.bottom, 4)
                    
                Text("Mom... Where are you?")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 42, design: .monospaced))
                    .padding(.bottom, 48)
            }
            .opacity(showLayer4 ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: showLayer4)
            .padding()
            
            ZStack {
                VStack(alignment: .center) {
                    Spacer()
                    Text("CHALLENGE 1")
                        .font(.system(size: 28, design: .monospaced))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 48)
                    Text("Help little girl\nfind her mom!")
                        .font(.system(size: 36, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                    Button(action: {
                        print("Start button clicked 2")
                        showingImagePicker = true
                        //                    path.append("scene1challenge")
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
                        Validation(inputImage: $inputImage, isFemale: $isFemale, isPresented: $showingValidation)
                            .interactiveDismissDisabled(true)
                    }
                    .onChange(of: showingValidation) { newValue in
                        playAnswerScreen()
                    }
                
                VStack {
                    Text("NOT HER MOM :(")
                        .font(.system(size: 28, design: .monospaced))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                    .background(Color.red)
                    .opacity(wrongAnswer ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.2), value: wrongAnswer)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                VStack {
                    Text("YOU FOUND HER MOM :)")
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            showLayer1 = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            showLayer2 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            showLayer2 = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            showLayer3 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.0) {
            audioManager.playSound(filename: "girlcry")
            audioManager.setVolume(0.3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 14.0) {
            showLayer3 = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 22.0) {
            showLayer4 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
            showLayer4 = false
            showChallenge = true
            audioManager.fadeOutMusic()
        }
    }
    
    func playAnswerScreen(){
        if isFemale {
            rightAnswer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                rightAnswer = false
                path.append("scene2")
            }
        }else {
            wrongAnswer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                wrongAnswer = false
            }
        }
    }
    
}
