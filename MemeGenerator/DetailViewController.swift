//
//  DetailViewController.swift
//  MemeGenerator
//
//  Created by Paul Richardson on 15/06/2021.
//

import UIKit

class DetailViewController: UIViewController {

	var image: UIImage?
	@IBOutlet var imageView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()

		if let image = image {
			imageView.image = image
		}
	}

}
