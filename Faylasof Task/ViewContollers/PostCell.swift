//
//  PostCell.swift
//  Faylasof Task
//
//  Created by Fady Hanna on 9/14/20.
//  Copyright © 2020 Fady Hanna. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var post : Post?
    var progressHUD : ProgressHUD?
    
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        
        if self.post != nil {
            let likes = self.post!.likes_count ?? 0
            titleLabel.text = post!.title
            descriptionText.text = post!.description
            likesLabel.text = "\(likes) likes"
            cellImage.isHidden = true
            if (post!.img_url != nil) {
                progressHUD = ProgressHUD(text: "Loading Image")
                self.addSubview(progressHUD!)
                PostsManager.shared.download(imageFromURL: post!.img_url!) { (image) in
                    self.cellImage.image = image
                    self.cellImage.isHidden = false
                    self.progressHUD!.hide()
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
