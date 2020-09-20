//
//  PostsManager.swift
//  Faylasof Task
//
//  Created by Fady Hanna on 9/14/20.
//  Copyright © 2020 Fady Hanna. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseStorage
import RxSwift

class PostsManager {

    // MARK: - Properties

    static let shared = PostsManager()
    
    var db: Firestore!
    var images = [UIImage]()
    var imageNames = [String]()
    
    func postNewPost(post: Post, image : UIImage?){
        
        _ = db.collection("posts").addDocument(data: post.asDictionary) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
    
    func getPosts() -> Observable<[Post]> {
        return Observable.create { observer -> Disposable in
            let collectionRef = self.db.collection("posts")
            var posts = [Post]()
            collectionRef.getDocuments { (querySnapshot, err) in
                if let docs = querySnapshot?.documents {
                    
                    for post in docs {
                        
                        var id: Int?
                        var title: String
                        var description: String
                        var img_url: String?
                        var video_url: String?
                        var likes_count: Int?
                        
                        if post["id"] != nil {
                            id = post["id"] as? Int
                        }
                        
                        title = post["title"] as! String
                        description = post["description"] as! String
                        
                        if post["img_url"] != nil {
                            img_url = post["img_url"] as? String
                        }
                        
                        if post["video_url"] != nil {
                            video_url = post["video_url"] as? String
                        }
                        if post["likes_count"] != nil {
                            likes_count = post["likes_count"] as? Int
                        }
                        
                        let tempPost = Post(id: id,
                                         title: title,
                                         description: description,
                                         img_url: img_url,
                                         video_url: video_url,
                                         likes_count: likes_count)
                        posts.append(tempPost)
                   
                    }
                }
                observer.onNext(posts)
            }
            return Disposables.create()
        }
    }
    
    func upload(image: UIImage, completion: ((String) -> Void)?){
        let fileName = "\(String.randomAlphaNumericString(length: 10)).png"
        let storage = Storage.storage().reference().child(fileName)
        if let uploadData = image.pngData(){
            storage.putData(uploadData, metadata: nil, completion: { (metadata,error) in
                if error != nil {
                    print("Upload Error\(error?.localizedDescription ?? "nil")")
                    return
                }
                print (metadata!.name!)
                completion?(metadata!.name!)
            })
        }
    }
    
    func download(imageFromURL : String, completion: ((UIImage) -> Void)?) {
        
        if let index = imageNames.firstIndex(of: imageFromURL) {
            completion!(self.images[index])
        } else {
            let storage = Storage.storage().reference().child(imageFromURL)
            storage.getData(maxSize: 20 * 1024 * 1024) { (data, error) -> Void in
                if error != nil {
                    print("Download Error: \(error?.localizedDescription ?? "nil")")
                    return
                }
                if let image = UIImage(data: data!) {
                    self.imageNames.append(imageFromURL)
                    self.images.append(image)
                    
                    completion?(image)
                } else {
                    print("Download Error: Couldn't parse image")
                }
            }
        }
    }
    
     init() {
        db = Firestore.firestore()
    }

        
    
    
}
