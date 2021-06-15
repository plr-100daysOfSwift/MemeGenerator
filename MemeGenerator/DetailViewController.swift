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

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMeme))

		if let image = image {
			imageView.image = image
		}
	}

	@objc func shareMeme() {
		guard let image = image,
					let imageData = image.jpegData(compressionQuality: 0.8) else { return }
		let title = "Meme"
		let vc = UIActivityViewController(activityItems: [title as Any, imageData as Any], applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}

}
