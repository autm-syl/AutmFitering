//
//  ViewController.swift
//  AutmFitering
//
//  Created by sylvanas on 07/17/2019.
//  Copyright (c) 2019 sylvanas. All rights reserved.
//

import UIKit

import AutmFitering

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chooseImageBtnClicked(_ sender: Any) {
        self.pickImage();
    }
    
    
    // pick image
    func pickImage() {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.videoQuality = UIImagePickerController.QualityType(rawValue: 100)!
            self.present(imagePickerController, animated: true, completion: nil)
            
        } else {
            //
        }
    }
    
    
    // image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any] ) {
        if let img = info[.originalImage] as? UIImage {
            dismiss(animated: true, completion: nil)
            
            // AutmFiltering, AutmFilteringViewController
            let autm = AutmFilteringViewController.init();
            autm.imageOrigin = img;
            autm.delegate = self
          
            present(autm, animated: true, completion: nil)
            
        } else {
            // not imagetype
        }
    }
}

extension ViewController:AutmFilteringDelegate {
    func autmFilteringImageDidFilter(image: UIImage) {
        //
        self.imageView.image = image;
    }
    
    func autmFilteringDidCancel() {
        //
    }
    
    
}
