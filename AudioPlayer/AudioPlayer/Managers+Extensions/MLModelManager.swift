//
//  MLModelManager.swift
//  AudioPlayer
//
//  Created by Daria on 15.05.2022.
//

import Foundation
import AVFoundation
import CoreML

class MLModelManager {
    
    static let sharedManager = MLModelManager()
    var url: URL?
    var model: denoiser?
    
    private init() {
        do {
            let config = MLModelConfiguration()

            model = try denoiser(configuration: config)
        } catch {
            print("Error initialize model")
        }
    }
    
    func enhanceAudio(_ name: String) -> Bool {
        guard let floatArrayOfAudio = convertAudio(name) else {
            return false
        }
        let coreMLArray = try! MLMultiArray(shape: [1, 1, 240000], dataType: .float32)
        
        for (index, element) in floatArrayOfAudio.enumerated() {
            coreMLArray[index] = NSNumber(value: element)
        }
        
        let inputModel = denoiserInput(noisy_wav_signal: coreMLArray)
        var outputModel = [Float32]()
        do {
            let output = try model?.prediction(input: inputModel)
            outputModel.removeAll()
            for index in 0...239999 {
                outputModel.append(output?.var_748[index] as! Float32)
            }
            convertToAudio(outputModel)
            return true
        } catch {
            print("error input")
        }
        
        return false
    }
    
    private func convertAudio(_ name: String) -> [Float32]? {
        let url = Bundle.main.url(forResource: name, withExtension: "wav")
        let file = try! AVAudioFile(forReading: url!)
        guard let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false) else {
            return nil
        }

        guard let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: 16000 * 15) else {
            return nil
        }
        try! file.read(into: buf)

        // this makes a copy, you might not want that
        let floatArray = Array(UnsafeBufferPointer(start: buf.floatChannelData?[0], count:Int(buf.frameLength)))
        return floatArray
    }
    
    private func convertToAudio(_ array: [Float32]) {
        let SAMPLE_RATE =  Float64(16000.0)

        let directory = NSTemporaryDirectory()
        let fileName = NSUUID().uuidString

        // This returns a URL? even though it is an NSURL class method
        url = NSURL.fileURL(withPathComponents: [directory, fileName])!
        
        let outputFormatSettings = [
            AVFormatIDKey:kAudioFormatLinearPCM,
            AVLinearPCMBitDepthKey:32,
            AVLinearPCMIsFloatKey: true,
            //  AVLinearPCMIsBigEndianKey: false,
            AVSampleRateKey: SAMPLE_RATE,
            AVNumberOfChannelsKey: 1
            ] as [String : Any]

        let audioFile = try? AVAudioFile(forWriting: url!, settings: outputFormatSettings, commonFormat: AVAudioCommonFormat.pcmFormatFloat32, interleaved: true)

        guard let bufferFormat = AVAudioFormat(settings: outputFormatSettings) else {
            return
        }

        let outputBuffer = AVAudioPCMBuffer(pcmFormat: bufferFormat, frameCapacity: AVAudioFrameCount(array.count))
        
        for i in 0..<array.count {
            outputBuffer?.floatChannelData!.pointee[i] = Float( array[i] )
        }
        
        outputBuffer?.frameLength = AVAudioFrameCount( array.count )

            do {
                try audioFile?.write(from: outputBuffer!)
            } catch let error as NSError {
                print("error:", error.localizedDescription)
            }
        
    }
    
}
