//
//  ContentView.swift
//  Core-ML
//
//  Created by Daria on 08.05.2022.
//

//import SwiftUI
//import CoreML
//import AVFoundation

//func loadAudioSignal(audioURL: NSURL) -> (signal: [Float], rate: Double, frameCount: Int) {
//    let url = NSBundle.mainBundle().URLForResource("1_OOFFICE_snr_10.wav", withExtension: "wav")
//    let file = try! AVAudioFile(forReading: url!)
//    let format = AVAudioFormat(commonFormat: .PCMFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false)
//
//    let buf = AVAudioPCMBuffer(PCMFormat: format, frameCapacity: 1024)
//    try! file.readIntoBuffer(buf)
//
//    // this makes a copy, you might not want that
//    let floatArray = Array(UnsafeBufferPointer(start: buf.floatChannelData[0], count:Int(buf.frameLength)))
//
//    print("floatArray \(floatArray)\n")
//}

//func enhanceAudio() -> dns48_11decc9d8e3f0998Output? {
//
//    do {
//
//
//        let config = MLModelConfiguration()
//        let model = try dns48_11decc9d8e3f0998(configuration: config)
//        let prediction = model.prediction(input: <#T##dns48_11decc9d8e3f0998Input#>)
//
//    } catch {
//
//    }
//    return nil
//}



//let fileURL: NSURL = NSURL(fileURLWithPath: filePath)
//let audioFile = try AVAudioFile(forReading: fileURL as URL)
//let audioFormat = audioFile.processingFormat
//let audioFrameCount = UInt32(audioFile.length)
//let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
//
//try audioFile.read(into: audioFileBuffer!)
//
//extension AudioBuffer {
//    func array() -> [Float] {
//        return Array(UnsafeBufferPointer(self))
//    }
//}
//
//extension AVAudioPCMBuffer {
//    func array() -> [Float] {
//        return self.audioBufferList.pointee.mBuffers.array()
//    }
//}
//
//extension Array where Element: FloatingPoint {
//    mutating func buffer() -> AudioBuffer {
//        return AudioBuffer(mNumberChannels: 1, mDataByteSize: UInt32(self.count * MemoryLayout<Element>.size), mData: &self)
//    }
//}
//
//let array = audioFileBuffer?.array()
//print(array?.count) //Optional(2705408)

//struct ContentView: View {
//    var body: some View {
//        Text("Audio Denoising")
//            .padding()
//    }
//    let filePath: String = Bundle.main.path(forResource: "1_OOFFICE_snr_10", ofType: "wav")!
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
