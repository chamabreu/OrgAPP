//
//  FullSizePhotoVC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 30.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

 /*

import UIKit
import Photos

class FullSizePhotoVC: UIViewController {
	@IBOutlet weak var fullSizePhotoImageView: UIImageView!

	var imageManager = PHImageManager()
	var photoAssets: PHFetchResult<PHAsset>!
	var photoIdentifiers: [String] = []
	var selectedPhoto: Int = 0

	let photoSize = CGSize(width: (UIScreen.main.bounds.width * UIScreen.main.scale), height: (UIScreen.main.bounds.height * UIScreen.main.scale))


    override func viewDidLoad() {
        super.viewDidLoad()
		fullSizePhotoImageView.contentMode = .scaleAspectFit

		presentedPhoto(selectedPhoto)

		let tapReco = UITapGestureRecognizer(target: self, action: #selector(showHideNavBar))
		fullSizePhotoImageView.addGestureRecognizer(tapReco)

		let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipePhoto))
		leftSwipe.direction = .left
		let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipePhoto))
		rightSwipe.direction = .right
		let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipePhoto))
		downSwipe.direction = .down

		fullSizePhotoImageView.addGestureRecognizer(leftSwipe)
		fullSizePhotoImageView.addGestureRecognizer(rightSwipe)
		fullSizePhotoImageView.addGestureRecognizer(downSwipe)

	}


	@objc func showHideNavBar() {
		navigationController?.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
	}

	@objc func swipePhoto(swipe: UISwipeGestureRecognizer) {
		switch swipe.direction {
		case .left:
			if selectedPhoto < photoAssets.count - 1 {
				selectedPhoto += 1
				presentedPhoto(selectedPhoto)
			}
		case .right:
			if selectedPhoto > 0 {
				selectedPhoto -= 1
				presentedPhoto(selectedPhoto)
			}
		case .down:
			navigationController?.setNavigationBarHidden(false, animated: false)
			navigationController?.popViewController(animated: true)
		default:
			break

		}
	}

	func presentedPhoto(_ index: Int) {
		let options = PHImageRequestOptions()
		options.version = .original
		imageManager.requestImage(for: photoAssets[index], targetSize: photoSize, contentMode: .aspectFit, options: options) { (image, _) in
			self.fullSizePhotoImageView.image = image
		}
	}
}


*/
