//
//  AddPostViewController.swift
//  Faylasof Task
//
//  Created by Fady Hanna on 9/14/20.
//  Copyright © 2020 Fady Hanna. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,
    UITextFieldDelegate

{
    
    
    var imagePicker = UIImagePickerController()
    var onDoneBlock : ((Bool) -> Void)?
    var selectedImage : UIImage?
    var progressHUD : ProgressHUD?
    var image_url : String?
    
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func postButtonPressed(_ sender: Any) {
        
        let testPost = Post(id: nil,
                            title: postTextField.text ?? "",
                        description: postTextField.text ?? "",
                        img_url: image_url,
                        video_url: nil,
                        likes_count: nil)
        
        PostsManager.shared.postNewPost(post: testPost,
                                        image: selectedImage)
        onDoneBlock!(true)
        self.dismiss(animated: true)
        
    }
    
    
    @IBAction func chooseMediaPressed(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            postTextField.resignFirstResponder()

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
     super.viewDidLoad()
     // Do any additional setup after loading the view, typically from a nib.
        imageView.isHidden = true
        imagePicker.delegate = self
        postTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        postTextField.resignFirstResponder()
        return true;
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let data = image.jpegData(compressionQuality: 0 as CGFloat)
            self.selectedImage = UIImage(data: data!)
            self.progressHUD = ProgressHUD(text: "Uploading")
            self.view.addSubview(progressHUD!)
            
            PostsManager.shared.upload(image: selectedImage!, completion: {(file_name) in
                //Completion Callback
                self.progressHUD!.hide()
                self.image_url = file_name
                self.imageView.isHidden = false
                self.imageView.image = image
                self.postTextField.resignFirstResponder()
                
            })
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}


