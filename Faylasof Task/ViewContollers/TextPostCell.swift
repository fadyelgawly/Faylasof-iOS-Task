//
//  TextPostCell.swift
//  Faylasof Task
//
//  Created by Fady Hanna on 9/16/20.
//  Copyright © 2020 Fady Hanna. All rights reserved.
//

import UIKit

class TextPostCell: UITableViewCell {
    
    var post : Post?
    var progressHUD : ProgressHUD?
    
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
        }
    }
}
