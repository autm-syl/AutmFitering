//
//  AutmFilteringViewController.swift
//  Autm-Filtering
//
//  Created by Sylvanas on 7/17/19.
//

import UIKit

public protocol AutmFilteringDelegate {
    func autmFilteringImageDidFilter(image: UIImage)
    func autmFilteringDidCancel()
}

open class AutmFilteringViewController: UIViewController {
    
    public var delegate: AutmFilteringDelegate?
    
    
    fileprivate let filterNameList = [
        "No Filter",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CILinearToSRGBToneCurve",
        "CISRGBToneCurveToLinear"
    ]
    
    fileprivate let filterDisplayNameList = [
        "Normal",
        "Chrome",
        "Fade",
        "Instant",
        "Mono",
        "Noir",
        "Process",
        "Tonal",
        "Transfer",
        "Tone",
        "Linear"
    ]
    
    fileprivate var filterIndex = 0
    fileprivate let context = CIContext(options: nil)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!

    open var imageOrigin: UIImage?
    fileprivate var smallImage: UIImage?
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func loadView() {
        if let view = UINib(nibName: "AutmFilteringViewController", bundle: Bundle(for: self.classForCoder)).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
            if let image = self.imageOrigin {
                imageView?.image = image
                smallImage = resizeImage(image: image)
            }
        }
    }

    
    override open func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib.init(nibName: "AutmFilteringViewCell", bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier: "AutmFilteringViewCell");
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        self.perform(#selector(reloadCollectonDM), with: nil, afterDelay: 0.5)
    }

    @objc func reloadCollectonDM(){
        collectionView.reloadData();
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.autmFilteringDidCancel()
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtnClicked(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.autmFilteringImageDidFilter(image: (imageView?.image)!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageViewDidSwipeRight(_ sender: Any) {
        if filterIndex == filterNameList.count - 1 {
            filterIndex = 0
            imageView?.image = imageOrigin
        } else {
            filterIndex += 1
        }
        if filterIndex != 0 {
            applyFilter()
        }
        updateCellFont()
        scrollCollectionViewToIndex(itemIndex: filterIndex)
    }
    @IBAction func imageViewDidSwipeLeft(_ sender: Any) {
        if filterIndex == 0 {
            filterIndex = filterNameList.count - 1
        } else {
            filterIndex -= 1
        }
        if filterIndex != 0 {
            applyFilter()
        } else {
            imageView?.image = imageOrigin
        }
        updateCellFont()
        scrollCollectionViewToIndex(itemIndex: filterIndex)
    }
    
    //
    func applyFilter() {
        let filterName = filterNameList[filterIndex]
        if let image = self.imageOrigin {
            let filteredImage = createFilteredImage(filterName: filterName, image: image)
            imageView?.image = filteredImage
        }
    }
    
    func createFilteredImage(filterName: String, image: UIImage) -> UIImage {
        // 1 - create source image
        let sourceImage = CIImage(image: image)
        
        // 2 - create filter using name
        let filter = CIFilter(name: filterName)
        filter?.setDefaults()
        
        // 3 - set source image
        filter?.setValue(sourceImage, forKey: kCIInputImageKey)
        
        // 4 - output filtered image as cgImage with dimension.
        let outputCGImage = context.createCGImage((filter?.outputImage!)!, from: (filter?.outputImage!.extent)!)
        
        // 5 - convert filtered CGImage to UIImage
        let filteredImage = UIImage(cgImage: outputCGImage!)
        
        return filteredImage
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        let ratio: CGFloat = 0.3
        let resizedSize = CGSize(width: Int(image.size.width * ratio), height: Int(image.size.height * ratio))
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

extension AutmFilteringViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 120, height: 164)
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutmFilteringViewCell", for: indexPath) as! AutmFilteringViewCell
        var filteredImage = smallImage
        if indexPath.row != 0 {
            filteredImage = createFilteredImage(filterName: filterNameList[indexPath.row], image: smallImage!)
        }
        
        cell.imageView.image = filteredImage
        cell.filterNameLabel.text = filterDisplayNameList[indexPath.row]
        updateCellFont()
        return cell
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNameList.count
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterIndex = indexPath.row
        if filterIndex != 0 {
            applyFilter()
        } else {
            imageView?.image = imageOrigin
        }
        updateCellFont()
        scrollCollectionViewToIndex(itemIndex: indexPath.item)
    }
    
    func updateCellFont() {
        // update font of selected cell
        if let selectedCell = collectionView?.cellForItem(at: IndexPath(row: filterIndex, section: 0)) {
            let cell = selectedCell as! AutmFilteringViewCell
            cell.filterNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        for i in 0...filterNameList.count - 1 {
            if i != filterIndex {
                // update nonselected cell font
                if let unselectedCell = collectionView?.cellForItem(at: IndexPath(row: i, section: 0)) {
                    let cell = unselectedCell as! AutmFilteringViewCell
                    if #available(iOS 8.2, *) {
                        cell.filterNameLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.thin)
                    } else {
                        // Fallback on earlier versions
                        cell.filterNameLabel.font = UIFont.systemFont(ofSize: 14.0)
                    }
                }
            }
        }
    }
    
    func scrollCollectionViewToIndex(itemIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: 0)
        self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}


