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
	var header = ""
	var footer = ""

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Memes"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))

		memes = [UIImage]()

	}

	@objc func addMeme() {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		present(imagePicker, animated: true)
	}

	func setHeader() {
		let ac = UIAlertController(title: "Header", message: "This text will appear at the top of your meme.", preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac] action in
			guard let string: String = ac?.textFields?[0].text else { return }
			self?.header = string
			self?.setFooter()
		}))
		ac.addAction(UIAlertAction(title: "No thanks", style: .cancel) { [weak self] _ in
			self?.setFooter()
		})
		present(ac, animated: true)
	}

	func setFooter () {
		let ac = UIAlertController(title: "Footer", message: "This text will appear at the bottom of your meme.", preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac] action in
			guard let string: String = ac?.textFields?[0].text else { return }
			self?.footer = string
			self?.createMeme()
		}))
		ac.addAction(UIAlertAction(title: "No thanks", style: .cancel) { [weak self] _ in
			self?.createMeme()
		})
		present(ac, animated: true)
	}

	func createMeme() {
		guard let currentImage = currentImage else { return }
		let size = currentImage.size
		let renderer = UIGraphicsImageRenderer(size: size)
		let meme = renderer.image { ctx in
			let rectangle = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
			currentImage.draw(in: rectangle)

			let attributes: [NSAttributedString.Key: Any] = [
				.font: UIFont.boldSystemFont(ofSize: 48),
				.foregroundColor: UIColor.white,
			]
			let headerRectangle = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: size.width - 40, height: 100))
			let footerRectangle = CGRect(origin: CGPoint(x: 20, y: rectangle.size.height - 100), size: CGSize(width: size.width - 40, height: 100))

			let headerString = NSAttributedString(string: header, attributes: attributes)
			headerString.draw(in: headerRectangle)

			let footerString = NSAttributedString(string: footer, attributes: attributes)
			footerString.draw(in: footerRectangle)

		}

		memes.insert(meme, at: 0)
		collectionView.reloadData()
	}

	// MARK:- UIImagePickerControllerDelegate Methods

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage]  as? UIImage else { return }
		currentImage = image
		dismiss(animated: true) { [weak self] in
			self?.setHeader()
		}
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

