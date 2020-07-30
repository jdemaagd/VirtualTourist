//
//  ViewController.swift
//  FatImages
//
//  Created by JON DEMAAGD on 7/4/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

// MARK: - BigImages: String

// App Transport Security:
// Apps can only access resources through a secure connection (https)
// You can change this default behavior:
// http://www.neglectedpotential.com/2015/06/working-with-apples-application-transport-security/

enum BigImages: String {
    case whale = "https://lh3.googleusercontent.com/16zRJrj3ae3G4kCDO9CeTHj_dyhCvQsUDU0VF0nZqHPGueg9A9ykdXTc6ds0TkgoE1eaNW-SLKlVrwDDZPE=s0#w=4800&h=3567"
    case shark = "https://lh3.googleusercontent.com/BCoVLCGTcWErtKbD9Nx7vNKlQ0R3RDsBpOa8iA70mGW2XcC76jKS09pDX_Rad6rjyXQCxngEYi3Sy3uJgd99=s0#w=4713&h=3846"
    case seaLion = "https://lh3.googleusercontent.com/ibcT9pm_NEdh9jDiKnq0NGuV2yrl5UkVxu-7LbhMjnzhD84mC6hfaNlb-Ht0phXKH4TtLxi12zheyNEezA=s0#w=4626&h=3701"
}

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!


    // MARK: Actions
    
    // Blocks main queue and UI: never do this!
    @IBAction func synchronousDownload(_ sender: UIBarButtonItem) {
        photoView.image = nil
        
        activityView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(1) / Double(NSEC_PER_SEC)) { () -> Void in
            if let url = URL(string: BigImages.seaLion.rawValue),
                let imgData = try? Data(contentsOf: url),
                let image = UIImage(data: imgData) {
                    self.photoView.image = image
                    self.activityView.stopAnimating()
            }
        }
    }
    
    // Creates new sync/serial queue that runs in background (does not block UI)
    @IBAction func simpleAsynchronousDownload(_ sender: UIBarButtonItem) {
        photoView.image = nil
        
        activityView.startAnimating()
        
        let url = URL(string: BigImages.shark.rawValue)

        let downloadQueue = DispatchQueue(label: "download", attributes: [])
        
        // add closure that encapsulates blocking operation
        // run it asynchronously: some time in near future
        downloadQueue.async { () -> Void in
            let imgData = try? Data(contentsOf: url!)
            let image = UIImage(data: imgData!)
            
            // UIKit: ending in View (photoView) run in main queue
            DispatchQueue.main.async(execute: { () -> Void in
                self.photoView.image = image
                self.activityView.stopAnimating()
            })
        }
    }
    
    // Uses global queue and uses a completion closure
    @IBAction func asynchronousDownload(_ sender: UIBarButtonItem) {
        photoView.image = nil

        activityView.startAnimating()
        
        withBigImage { (image) -> Void in
            self.photoView.image = image
            self.activityView.stopAnimating()
        }
    }
    
    // Used for testing blocking code
    @IBAction func setTransparencyOfImage(_ sender: UISlider) {
        photoView.alpha = CGFloat(sender.value)
    }
    
    
    // MARK: Download Big Image
    
    // This method downloads and image in the background once it's
    // finished, it runs the closure it receives as a parameter.
    // This closure is called a completion handler
    // Go download the image, and once you're done, do _this_ (the completion handler)
    func withBigImage(completionHandler handler: @escaping (_ image: UIImage) -> Void){
        
        DispatchQueue.global(qos: .userInitiated).async { () -> Void in
            if let url = URL(string: BigImages.whale.rawValue), let imgData = try? Data(contentsOf: url), let img = UIImage(data: imgData) {

                // always run handlers in main queue
                DispatchQueue.main.async(execute: { () -> Void in
                    handler(img)
                })
            }
        }
    }
}
