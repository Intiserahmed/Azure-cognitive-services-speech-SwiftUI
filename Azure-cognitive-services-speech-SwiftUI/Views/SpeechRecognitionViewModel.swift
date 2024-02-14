//
//  SpeechRecognitionViewModel.swift
//  Azure-cognitive-services-speech-SwiftUI
//
//  Created by intiser Ahmed on 14/02/2024.
//

import MicrosoftCognitiveServicesSpeech
import SwiftUI

class SpeechRecognitionManager: ObservableObject {
    @Published var recognitionResult: String = ""
    var recognizer: SPXSpeechRecognizer?

    func recognizeFromMic() {
        do {
            var speechConfig: SPXSpeechConfiguration?
            do {
                try speechConfig = SPXSpeechConfiguration(subscription: SpeechConfig.subscriptionKey, region: SpeechConfig.serviceRegion)
            } catch {
                print("error \(error) happened")
                speechConfig = nil
            }
            speechConfig?.speechRecognitionLanguage = "en-US"

            let audioConfig = SPXAudioConfiguration()

            recognizer = try! SPXSpeechRecognizer(speechConfiguration: speechConfig!, audioConfiguration: audioConfig)

            recognizer?.addRecognizingEventHandler { _, evt in
                let intermediateResult = evt.result.text ?? "(no result)"
                print("intermediate recognition result: \(evt.result.text ?? "(no result)")")
                self.updateRecognitionResult(text: intermediateResult)
            }

            updateRecognitionResult(text: "Listening ...")
            print("Listening...")

            let result = try recognizer?.recognizeOnce()
            _ = result?.text ?? "(no result)"
            print("recognition result: \(result?.text ?? "(no result)")")

            updateRecognitionResult(text: result?.text)

        } catch {
            print("Error initializing recognizer: \(error)")
        }
    }

    func stopRecording() {
        do {
            try recognizer?.stopContinuousRecognition()
        } catch {
            print("Error stopping recognition: \(error)")
        }
    }

    private func updateRecognitionResult(text: String?) {
        DispatchQueue.main.async {
            self.recognitionResult = text ?? ""
        }
    }
}
