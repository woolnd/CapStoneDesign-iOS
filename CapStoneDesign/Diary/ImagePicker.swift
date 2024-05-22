//
//  ImagePicker.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/27/24.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var mode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        PHPhotoLibrary.requestAuthorization { status in
                    switch status {
                    case .authorized:
                        print("Access granted by user")
                    case .denied, .restricted:
                        print("Access denied or restricted")
                    case .notDetermined:
                        print("Access not determined yet")
                    case .limited:
                        print("Access limited")
                    @unknown default:
                        fatalError("Unknown authorization status")
                    }
                }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            parent.image = image
            parent.mode.wrappedValue.dismiss()
        }
    }
}
