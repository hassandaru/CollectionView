//
//  ViewController.swift
//  CollectionView
//
//  Created by Hassan Sohail Dar on 1/9/2022.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        fillPicturesArray()

    }

    func fillPicturesArray() {
        let fn = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fn.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                //this is a picture to add to array
                pictures.append(item)
            }
        }

        pictures.sort()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pictures.count)
        return pictures.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            fatalError("Could not find cell.")
        }
            cell.imageView?.image = UIImage(named: pictures[indexPath.item])
            return cell

        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ImageCell") as? DetailViewController {
            vc.title = pictures[indexPath.item]
            vc.selectedImage =  pictures[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

