//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Paul Richardson on 15/06/2021.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
	
	var memes: [UIImage]!
	var currentImage: UIImage?

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Memes"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))

		memes = [UIImage]()

	}

	@objc func addMeme() {

		chooseImage()

		// prompt for header text

		// prompt for footer text

		// create image

	}

	func chooseImage() {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		present(imagePicker, animated: true)
	}

	// MARK:- UIImagePickerControllerDelegate Methods

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage]  as? UIImage else { return }
		currentImage = image
		dismiss(animated: true)
	}

	// MARK:- UICollectionView Data Source Methods

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return memes.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard	let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Meme", for: indexPath) as? MemeCell else { fatalError("Unable to dequeue Meme Cell") }

		cell.imageView.image = memes[indexPath.item]

		return cell

	}

}

