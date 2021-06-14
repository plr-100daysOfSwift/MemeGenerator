//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Paul Richardson on 15/06/2021.
//

import UIKit

class ViewController: UICollectionViewController {

	var memes: [UIImage]!

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Memes"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))

		memes = [UIImage]()

	}

	@objc func addMeme() {

		// pick an image

		// prompt for header text

		// prompt for footer text

		// create image

	}


}

