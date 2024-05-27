//
//  GamePlay2View.swift
//  Release
//
//  Created by Glenn Leonali on 24/05/24.
//

import SwiftUI
import Vision
import CoreML

struct GamePlay2View: View {
    @Binding var path: NavigationPath
    @StateObject private var audioManager = AudioManager()
    
    @State private var showLayer1 = false
    @State private var comfortButton = false
    @State private var showLayer2 = false
    @State private var showLayer3 = false
    @State private var showLayer4 = false
    @State private var showLayer5 = false
    @State private var showChallenge = false
    
    @State private var isTB = false
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
                Text("Little Girl")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .padding(.bottom, 4)
                
                Text("Mom, why are you crying?")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 42, design: .monospaced))
                    .padding(.bottom, 48)
            }
            .opacity(showLayer1 ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: showLayer1)
            .padding()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        comfortButton = false
                        playScene2()
                    }) {
                        Text("> Comfort her")
                            .font(.system(size: 24, design: .monospaced))
                            .fontWeight(.bold)
                            .padding()
                            .border(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(64)
                }
            }
            .opacity(comfortButton ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: comfortButton)
            
            VStack(alignment: .center) {
                Spacer()
                Text("Mother")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .padding(.bottom, 4)
                
                Text("Thank you, kind stranger. I'm fine now.")
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
                
                Text("I must have looked very stupid just now.")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 42, design: .monospaced))
                    .padding(.bottom, 48)
            }
            .opacity(showLayer3 ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: showLayer3)
            .padding()
            
            VStack(alignment: .center) {
                Spacer()
                Text("Mother")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, design: .monospaced))
                    .padding(.bottom, 4)
                
                Text("Long story short.. I just lost my one and only daughter recently in a very gruesome... accident.")
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
                
                Text("Today is her birthday.. Can you accompany me to give this birthday gift to her?")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 42, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .horizontal], 48)
            }
            .opacity(showLayer5 ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.2), value: showLayer5)
            .padding()
            
            ZStack {
                VStack(alignment: .center) {
                    Spacer()
                    Text("CHALLENGE 2")
                        .font(.system(size: 28, design: .monospaced))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 48)
                    Text("Find a Teddy Bear!")
                        .font(.system(size: 36, design: .monospaced))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                    Button(action: {
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
                        Validation2(inputImage: $inputImage, isTB: $isTB, isPresented: $showingValidation)
                            .interactiveDismissDisabled(true)
                    }
                    .onChange(of: showingValidation) { newValue in
                        playAnswerScreen()
                    }
                
                VStack {
                    Text("SHE DOESN'T LIKE THE GIFT :(")
                        .font(.system(size: 28, design: .monospaced))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                    .background(Color.red)
                    .opacity(wrongAnswer ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.2), value: wrongAnswer)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                VStack {
                    Text("SHE LIKES THE GIFT :)")
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
            audioManager.playSound(filename: "momcry")
            audioManager.setVolume(0.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            showLayer1 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            showLayer1 = false
            audioManager.playMusic(filename: "tearful-99147")
            audioManager.setVolume(0.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            comfortButton = true
        }
    }
    
    func playScene2(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showLayer2 = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            showLayer2 = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            showLayer3 = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 11.0) {
            showLayer3 = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
            showLayer4 = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 18.0) {
            showLayer4 = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 19.0) {
            showLayer5 = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 25.0) {
            showLayer5 = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 26.0) {
            audioManager.stopSound()
            showChallenge = true
        }
    }
    
    func playAnswerScreen(){
        if isTB {
            rightAnswer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                rightAnswer = false
                path.append("scene3")
            }
        }else {
            wrongAnswer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                wrongAnswer = false
            }
        }
    }
    
}
