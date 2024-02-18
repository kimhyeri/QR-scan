//
//  ContentView.swift
//  QR-scan
//
//  Created by Hye Ri Kim on 2024/02/18.
//

import CoreImage.CIFilterBuiltins
import Observation
import SwiftUI

@Observable class QR {
    var emailAddress = ""

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var qrCode: Image {
        filter.message = Data(emailAddress.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgimg)
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "xmark")
    }
}

struct ContentView: View {
    @State private var viewModel = QR()

    var body: some View {
        Form {
            TextField("Enter your email address", text: $viewModel.emailAddress)

            Section("QR code") {
                viewModel.qrCode
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    ContentView()
}
