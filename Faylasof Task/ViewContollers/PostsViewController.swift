//
//  PostsViewController.swift
//  Faylasof Task
//
//  Created by Fady Hanna on 9/15/20.
//  Copyright © 2020 Fady Hanna. All rights reserved.
//

import UIKit
import RxSwift

class PostsViewController: UIViewController {

    var posts = [Post]()
    var progressHUD : ProgressHUD?
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newPostButton: UIButton!
    @IBAction func newPostPressed(_ sender: Any) {
        let newPostVC : AddPostViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "newPostVC") as! AddPostViewController
       newPostVC.onDoneBlock = { result in
        self.progressHUD!.show()
        self.getPosts(completion: nil)
        }
        self.present(newPostVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        self.progressHUD = ProgressHUD(text: "Loading Posts")
        self.view.addSubview(progressHUD!)
        
        getPosts(completion: nil)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        print("Will refresh data")
        getPosts(completion: {
            self.refreshControl.endRefreshing()
        })
    }
    
    func getPosts(completion: (() -> Void)?){
        let postMananger = PostsManager()
        postMananger.getPosts().subscribe(onNext: {[weak self] posts in
            self?.posts = posts
            self?.tableView.reloadData()
            self?.progressHUD!.hide()
            completion?()
        }, onError: {[weak self] error in
            self?.posts = []
            self?.tableView.reloadData()
            self?.progressHUD!.hide()
            
            let alert = UIAlertController(title: "Alert", message: "Error", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: {
                completion?()
            })
        },
           onCompleted: nil,
           onDisposed: nil)
    }
}

extension PostsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.posts[indexPath.row].img_url != nil {
            let cell = Bundle.main.loadNibNamed("PostCell", owner: self, options: nil)?.first as! PostCell
            cell.post = self.posts[indexPath.row]
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("TextPostCell", owner: self, options: nil)?.first as! TextPostCell
            cell.post = self.posts[indexPath.row]
            return cell
        }
    }
}
