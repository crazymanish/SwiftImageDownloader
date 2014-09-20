//
//  HomeScreenTableViewController.swift
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

import UIKit
import Foundation

class HomeScreenTableViewController: UITableViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var imageList = NSMutableArray()
    
    //***********************************************************************
    // MARK: - viewDidAppear
    //***********************************************************************
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //Fetch Images
        self.handleFetchImageButton(nil)
        
        //reload table
        self.tableView.reloadData()
    }
    
    
    //***********************************************************************
    // MARK: - UITableViewDataSource
    //***********************************************************************

    //numberOfRowsInSection
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return imageList.count
    }
    
    //cellForRowAtIndexPath
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell : HomeScreenTableViewCell=tableView.dequeueReusableCellWithIdentifier("HomeScreenTableViewCell", forIndexPath: indexPath) as HomeScreenTableViewCell
        
        //Configure the cell...
        
        //Image UrlString
        let imageUrlString: NSString  = imageList[indexPath.row] as String
        
        //Set Url
        cell.imageUrlString.text = imageUrlString
        
        //Download-Image Now
        cell.thumbView.downloadImageWithUrlString(imageUrlString)
        
       // println("Url is \(imageUrlString)")
        
        return cell
    }
    
    
    //***********************************************************************
    // MARK: - Handle Fetch Button IBAction
    //***********************************************************************
    @IBAction func handleFetchImageButton(sender: AnyObject?) {

        
        let start=1
        let end=19
        for index in 1...3 {
            for pageNumber in start...end {
                var urlString:String=""
                switch index {
                case 1:
                    urlString="http://img.mangahit.com/manga/0916/054046/%02d.jpg"
                case 2:
                    urlString="http://img.mangahit.com/manga/0916/054037/%02d.jpg"
                case 3:
                    urlString="http://img.mangahit.com/manga/0916/054022/%02d.jpg"
                default:
                    println("default called....")
                }
                urlString = NSString(format:urlString,pageNumber) as String
                
                //Add-Object
                imageList.addObject(urlString)
            }
        }
       // println("Urls are \(imageList)")
    }
    
}