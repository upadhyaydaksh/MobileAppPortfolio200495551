//
//  Media.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 09/08/19.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper

enum MediaType : Int {
    case image = 1
    case video = 2
}

class Media: NSObject, Mappable, NSCopying, NSCoding {
    
    var id: String?
    var imageURL: String?
    var imageAspectRatio: NSNumber?
    var videoURL: String? // URL of video uploaded to server
    var image: UIImage?
    var videoLocalURL: URL? // In App URL selected from image picker
    var type : MediaType?
    var mediaUrl : String?
    
    init(id: String?, imageURL: String?, imageAspectRatio: NSNumber?, videoURL: String?, image: UIImage?, videoLocalURL: URL?, type: MediaType?, mediaUrl : String?) {
        self.id = id
        self.imageURL = imageURL
        self.imageAspectRatio = imageAspectRatio
        self.videoURL = videoURL
        self.image = image
        self.videoLocalURL = videoLocalURL
        self.type = type
        self.mediaUrl = mediaUrl
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Media(id: id, imageURL: imageURL, imageAspectRatio: imageAspectRatio, videoURL: videoURL, image: image, videoLocalURL: videoLocalURL, type: type, mediaUrl: mediaUrl)
    }
    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required public init?(map: Map){
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        id <- map["id"]
        imageURL <- map["imageURL"]
        imageAspectRatio <- map["imageAspectRatio"]
        videoURL <- map["videoURL"]
        type <- (map["type"],EnumTransform<MediaType>())
        mediaUrl <- map["mediaUrl"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.imageURL = aDecoder.decodeObject(forKey: "imageURL") as? String
        self.imageAspectRatio = aDecoder.decodeObject(forKey: "imageAspectRatio") as? NSNumber
        self.videoURL = aDecoder.decodeObject(forKey: "videoURL") as? String
        self.mediaUrl = aDecoder.decodeObject(forKey: "mediaUrl") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(imageURL, forKey: "imageURL")
        aCoder.encode(imageAspectRatio, forKey: "imageAspectRatio")
        aCoder.encode(videoURL, forKey: "videoURL")
        aCoder.encode(mediaUrl, forKey: "mediaUrl")
    }
}

