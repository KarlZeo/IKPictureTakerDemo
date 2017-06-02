//
//  ViewController.swift
//  IKPictureTaker
//
//  Created by Karl Zeo on 01/06/2017.
//  Copyright © 2017 Karl Zeo. All rights reserved.
//

import Cocoa
import Quartz

class ViewController: NSViewController {

    @IBOutlet weak var imageview: NSImageView!
    @IBAction func btnClick(_ sender: Any) {
        
        let pictureTaker = IKPictureTaker()
        
        self.setImageInputForPictureTaker(pictureTaker: pictureTaker)
        
        let number = NSNumber(value: true)
        
        pictureTaker.setValue(number, forKey: IKPictureTakerShowEffectsKey)
        
//        pictureTaker.begin(withDelegate: self, didEnd: #selector(pictureTakerValidated(pictureTaker:returnCode:contextInfo:)), contextInfo: nil)
        
        let window = NSWindow(contentRect: NSRect(x: 100, y: 100, width: 100, height: 100), styleMask: .resizable, backing: .buffered, defer: true)
        
//        window.frame = NSRect(x: 100, y: 100, width: 100, height: 100)
        
        window.titleVisibility = .hidden
        
        window.titlebarAppearsTransparent = true
        
        window.isMovableByWindowBackground = true
        
        pictureTaker.beginSheet(for: window, withDelegate: self, didEnd: #selector(pictureTakerValidated(pictureTaker:returnCode:contextInfo:)), contextInfo: nil)
    }
    
    func setImageInputForPictureTaker(pictureTaker: IKPictureTaker) {
        
        let picUrl: URL
        
        let bundle = Bundle()
        
        if (bundle.isLoaded) {
            
            let picPath = bundle.path(forResource: "picture", ofType: "jpg")
            
            
            if ((picPath) != nil) {
                
                picUrl = URL.init(fileURLWithPath: picPath!)
                
                pictureTaker.setInputImage(NSImage.init(byReferencing: picUrl))
            }
        }
        
    }
    
    func pictureTakerValidated(pictureTaker: IKPictureTaker, returnCode: NSInteger ,contextInfo: UnsafeRawPointer) {
        if (returnCode == NSModalResponseOK) {
            
            let outputImage: NSImage = pictureTaker.outputImage()
            
            self.imageview.image = outputImage
        }
    }
    
    override func awakeFromNib() {
        let pictureTaker = IKPictureTaker()
        
        self.setImageInputForPictureTaker(pictureTaker: pictureTaker)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

