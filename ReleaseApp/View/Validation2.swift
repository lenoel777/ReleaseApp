//
//  Validation2.swift
//  Release
//
//  Created by Glenn Leonali on 24/05/24.
//

import SwiftUI
import Vision
import CoreML

struct Validation2: View {
    @Binding var inputImage: UIImage?
    @Binding var isTB: Bool
    @Binding var isPresented: Bool
    
    @State private var classifiedText: String = ""

    var body: some View {
        VStack {
            if let inputImage = inputImage {
                Spacer()
                Image(uiImage: inputImage)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                    .scaledToFit()
                    .padding()
                Spacer()
                Button("Submit") {
                    classifyObject(inputImage)
                }
                .padding()
                Spacer()
                
                Text(classifiedText)
                    .padding()
            }
        }
    }
    
    func classifyObject(_ image: UIImage) {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            classifiedText = "Failed to load model"
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation] {
                if let firstResult = results.first {
                    DispatchQueue.main.async {
                        classifiedText = "\(firstResult.identifier) with confidence \(firstResult.confidence)"
                        print("\(classifiedText)")
                        checkIsTB(results: firstResult)
                        isPresented = false
                    }
                } else {
                    DispatchQueue.main.async {
                        classifiedText = "Nothing recognized"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    classifiedText = "Failed to classify image"
                }
            }
        }
        
        guard let ciImage = CIImage(image: image) else {
            classifiedText = "Failed to convert UIImage to CIImage"
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    classifiedText = "Failed to perform classification: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func checkIsTB(results: VNClassificationObservation) {
        if results.identifier == "teddy, teddy bear" && results.confidence >= 0.7 {
            isTB = true
        }else {
            isTB = false
        }
    }
    
}

//#Preview {
//    Validation2()
//}

