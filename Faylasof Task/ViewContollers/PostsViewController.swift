//
//  PostsViewController.swift
//  Faylasof Task
//
//  Created by Fady Hanna on 9/15/20.
//  Copyright © 2020 Fady Hanna. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func testButton(_ sender: Any) {
        PostsManager.shared.getAllPosts(completion: { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        })
    }
    
    var posts = [Post]()
    var progressHUD : ProgressHUD?
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var newPostButton: UIButton!
    
    @IBAction func newPostPressed(_ sender: Any) {
        let newPostVC : AddPostViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "newPostVC") as! AddPostViewController
        
       newPostVC.onDoneBlock = { result in
        self.newPostButton.isHidden = true
        self.progressHUD!.show()
        PostsManager.shared.getAllPosts(completion: { (posts) in
            self.posts = posts
            self.tableView.reloadData()
            self.progressHUD!.hide()
            self.newPostButton.isHidden = false
        })
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
        self.tableView.addSubview(refreshControl) // not required when using UITableViewController
        progressHUD = ProgressHUD(text: "Loading Posts")
        self.view.addSubview(progressHUD!)
        self.newPostButton.isHidden = true

        PostsManager.shared.getAllPosts(completion: { (posts) in
            self.posts = posts
            self.tableView.reloadData()
            self.progressHUD!.hide()
            self.newPostButton.isHidden = false
        })
        
    }
    @objc func refresh(_ sender: AnyObject) {
        print("Will refresh data")
        self.newPostButton.isHidden = true
        PostsManager.shared.getAllPosts(completion: { (posts) in
            self.posts = posts
            self.tableView.reloadData()
            self.newPostButton.isHidden = false
            self.tableView.scroll(to: .top, animated: true)
            self.tableView.refreshControl = nil
            self.refreshControl.endRefreshing()
            print("Data refreshed")
        })
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
