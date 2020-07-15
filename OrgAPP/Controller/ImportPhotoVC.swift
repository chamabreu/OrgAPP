//
//  ImportPhotoVC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 28.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//
/*
import UIKit
import Photos

class ImportPhotoVC: UICollectionViewController {
	@IBOutlet var allPhotosCollView: UICollectionView!
	@IBOutlet weak var importButton: UIBarButtonItem!

	var thisProject: Project!
	var photosVC: PhotosVC!

	var allPhotos: PHFetchResult<PHAsset>!
	let imageManager = PHImageManager()
	var photoSize = CGSize(width: 0, height: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
		let options = PHFetchOptions()
		options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
		allPhotos = PHAsset.fetchAssets(with: options)

		let collectionFlowLayout = allPhotosCollView.collectionViewLayout as! UICollectionViewFlowLayout
		let cellSize = CGSize(width: ((allPhotosCollView.frame.width - 6) / 3), height: ((allPhotosCollView.frame.width - 6) / 3))
		collectionFlowLayout.itemSize = cellSize

		photoSize = CGSize(width: (cellSize.width * UIScreen.main.scale), height: (cellSize.width * UIScreen.main.scale))

		allPhotosCollView.delegate = self
		allPhotosCollView.dataSource = self
		allPhotosCollView.register(UINib(nibName: S.CustomCells.photoCell, bundle: nil), forCellWithReuseIdentifier: S.CustomCells.photoCell)

		allPhotosCollView.allowsMultipleSelection = true

    }

	@IBAction func importSelectedPhotos(_ sender: UIBarButtonItem) {
		for index in allPhotosCollView.indexPathsForSelectedItems! {
			if photosVC.photoAssets != nil {
				if !photosVC.photoAssets.contains(allPhotos[index.item]) {
					let newPhoto = Photo()
					newPhoto.photoLocalIdentifier = allPhotos[index.item].localIdentifier
					_ = RealmFuncs.Save.object(object: newPhoto)
					RealmFuncs.Edit.setParent(of: newPhoto, to: thisProject)
				}
			}else {
				let newPhoto = Photo()
				newPhoto.photoLocalIdentifier = allPhotos[index.item].localIdentifier
				_ = RealmFuncs.Save.object(object: newPhoto)
				RealmFuncs.Edit.setParent(of: newPhoto, to: thisProject)
			}
		}

		navigationController?.popViewController(animated: true)
	}




}



//MARK: -  UICollectionView Delegate & Datasource
extension ImportPhotoVC {
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}


	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return allPhotos.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: S.CustomCells.photoCell, for: indexPath) as! PhotoCCC
		cell.photoView.contentMode = .scaleAspectFill
		imageManager.requestImage(for: allPhotos[indexPath.row], targetSize: photoSize, contentMode: .aspectFill, options: .none) { (photoForCell, _) in
			cell.photoView.image = photoForCell
		}
		if cell.isSelected {
			cell.selectCheckMark.isHidden = false
			cell.selectOverlay.isHidden = false
		}else {
			cell.selectCheckMark.isHidden = true
			cell.selectOverlay.isHidden = true
		}
		return cell
	}

	override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		let cell = allPhotosCollView.cellForItem(at: indexPath) as! PhotoCCC
		cell.selectCheckMark.isHidden = false
		cell.selectOverlay.isHidden = false

		return true
	}

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if allPhotosCollView.indexPathsForSelectedItems!.count > 0 {
			importButton.isEnabled = true
		}
	}

	override func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
		let cell = allPhotosCollView.cellForItem(at: indexPath) as! PhotoCCC
		cell.selectCheckMark.isHidden = true
		cell.selectOverlay.isHidden = true
		return true
	}

	override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		if allPhotosCollView.indexPathsForSelectedItems!.count == 0 {
			importButton.isEnabled = false
		}
	}


}


*/
