//
//  PhotoPicker.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/12/21.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var avatarImageData: Data
    @Binding var imageHasChanged: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        init(photoPicker:PhotoPicker) {
            self.photoPicker = photoPicker
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.5), let compressedImage = UIImage(data: data) else {
                    //show error or alert
                    return
                }
                photoPicker.avatarImageData = data
                photoPicker.imageHasChanged = true
            } else {
                // return an error show an alert
            }
            picker.dismiss(animated: true)
        }
    }
    
}
