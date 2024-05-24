//
//  LoadingVC.swift
//  iOS_KOSIGNSTORE
//
//  Created by Bong Kokkheang on 4/11/22.
//

import UIKit

class LoadingVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gif = UIImage.gifImageWithName("progress")
        imageView.image = gif
    }
}
