//
//  UIImage+Additions.swift
//  BodyFixers
//
//  Created by Harshit on 17/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit
import ImageIO
import AVFoundation
import AVKit

extension URL {
    func sizeOfImageOnURL() -> (width: Int?, height: Int?) {
        if let imageSource = CGImageSourceCreateWithURL(self as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                return (pixelWidth, pixelHeight)
            }
        }
        return (nil, nil)
    }
    
    func thumbnailImageFromVideoURL(playIconVisible: Bool? = true) -> UIImage? {
        let asset = AVAsset(url: self)
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMake(value: 1, timescale: 2)
        let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        if img != nil {
            let frameImg  = UIImage(cgImage: img!)
            if playIconVisible! {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                let imgv = UIImageView(frame: view.frame)
                imgv.image = frameImg
                imgv.contentMode = .scaleAspectFill
                view.addSubview(imgv)
                let playIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                playIcon.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
                playIcon.contentMode = .scaleAspectFit
                playIcon.image = #imageLiteral(resourceName: "video-play")
                view.addSubview(playIcon)
                if let viewImage = view.image() {
                    return viewImage
                }
            } else {
                return frameImg
            }
        }
        return nil
    }
}

extension UIImage {
    
    func base64StringWithMaxSize(sizeInMB: Double) -> String {
        return self.dataWithMaxSize(sizeInMB: sizeInMB).base64EncodedString(options: .lineLength64Characters)
    }
    
    func dataWithMaxSize(sizeInMB: Double) -> Data {
        //Now use image to create into NSData format
        var compression: CGFloat = 1.0
        
        var imageData: Data = self.jpegData(compressionQuality: compression)!
        
        while (Double(imageData.count)/Double(1024 * 1024)) > sizeInMB {
            compression -= 0.1
            if compression <= 0 {
                break
            }
            imageData = self.jpegData(compressionQuality: compression)!
        }
        
        return imageData
    }
    
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
    
    func compressImage(compression: CGFloat) -> Data {
        
        var actualHeight : CGFloat = self.size.height
        var actualWidth : CGFloat = self.size.width
        let maxHeight : CGFloat = 1704
        let maxWidth : CGFloat = 960.0
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        var compressionQuality = compression
        
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }
        
        
        let rect = CGRect(x: 0, y: 0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        if let img = UIGraphicsGetImageFromCurrentImageContext() {
            
            if let imageData = img.jpegData(compressionQuality: compressionQuality) {
                UIGraphicsEndImageContext()
                return imageData
            }
        }
        return Data()
    }
    
    func roundedImage(radius: CGFloat) -> UIImage {
        let imageView: UIImageView = UIImageView(image: self)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
