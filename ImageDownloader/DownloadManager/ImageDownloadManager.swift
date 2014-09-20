//
//  ImageDownloadManager.swift
//  ImageDownloader
//
//  Created by Manish Rathi on 20/09/14.
//  Copyright (c) 2014 Rathi Inc. All rights reserved.
//
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//
//

import Foundation
import UIKit

/**
* CallBacks
*/

typealias DownloadingImageCompletionBlock = (image:UIImage?,imageUrl:NSURL,error:NSError?) -> Void
typealias DownloadingImageProgressBlock = (imageUrl:NSURL,downloadProgress:NSProgress) -> Void


class ImageDownloadManager : NSObject {
    
    /**
    * Download-Queue
    */
   private var downloadQueue:NSOperationQueue!
    
    
    //***********************************************************************
    // MARK: - Singleton Instance
    //***********************************************************************
    class var sharedInstance : ImageDownloadManager {
        
    struct staticVars {
        static var onceToken : dispatch_once_t = 0
        static var instance : ImageDownloadManager? = nil
        }
        dispatch_once(&staticVars.onceToken) {
            staticVars.instance = ImageDownloadManager()
        }
        return staticVars.instance!
    }
    
    //Init
    override init() {
        downloadQueue=NSOperationQueue()
    }
    
    //***********************************************************************
    // MARK: - Download Image Here
    //***********************************************************************
    func downloadImageWithUrlString(urlString: NSString, withCompletionHandler completionHandler:DownloadingImageCompletionBlock, withDownloadProgressHandler progressHandler:DownloadingImageProgressBlock) {
        
        //Download-Now
        let url:NSURL=NSURL.URLWithString(urlString)
        downloadImageWithUrl(url, withCompletionHandler: completionHandler, withDownloadProgressHandler: progressHandler)
    }
    
    func downloadImageWithUrl(url: NSURL, withCompletionHandler completionHandler:DownloadingImageCompletionBlock, withDownloadProgressHandler progressHandler:DownloadingImageProgressBlock) {
        //Create New Download-Task
        var downloadingImageTask:DownloadTask = DownloadTask().initWithImageUrl(url, withOperationQueue: downloadQueue, withCompletionHandler: completionHandler, withDownloadProgressHandler: progressHandler)
        
        //Start Download
        downloadingImageTask.downloadTask?.resume()
    }
    
    
}