//
//  ContentView.swift
//  Azure-cognitive-services-speech-SwiftUI
//
//  Created by intiser Ahmed on 14/02/2024.
//

import SwiftUI

struct SpeechRecognitionView: View {
    @StateObject var recognitionManager = SpeechRecognitionManager()

    var body: some View {
        VStack {
            Text(recognitionManager.recognitionResult)
                .foregroundColor(.black)
                .lineLimit(nil)
                .padding()
                .font(.title2)

            Image("mic.fill")
                .font(.system(size: 24))
                .foregroundColor(.black)

            HStack {
                Button(action: {
                    recognitionManager.isMicSlash.toggle()
                    if recognitionManager.isMicSlash {
                        recognitionManager.stopRecording()
                    } else {
                        recognitionManager.recognizeFromMic()
                    }
                }) {
                    Text("Start Recording")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .font(.title2)
                }
                .padding()
            }.padding()
        }
    }
}

#Preview {
    SpeechRecognitionView()
}
