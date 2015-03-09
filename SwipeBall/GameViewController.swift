//
//  GameViewController.swift
//  SwipeBall
//
//  Created by Teddy Dubno on 1/21/15.
//  Copyright (c) 2015 Teddy Dubno. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData
var open = false

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    @IBOutlet weak var settingsView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        /*settingsView.center = view.center
        settingsView.frame = CGRect(x: self.view.frame.width/10, y: self.view.frame.height - self.view.frame.height/10, width: self.view.frame.width/2, height: self.view.frame.height/2)*/
            }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBAction func redButton(sender: AnyObject) {
        GameScene().chanagecolor(UIColor.redColor())
    }
    @IBOutlet weak var highscorelable: UILabel!
    @IBAction func greenButton(sender: AnyObject) {
        GameScene().chanagecolor(UIColor.greenColor())
    }
    @IBAction func blueButton(sender: AnyObject) {
        GameScene().chanagecolor(UIColor.blueColor())
    }
    @IBAction func grayButton(sender: AnyObject) {
        GameScene().chanagecolor(UIColor.lightGrayColor())

    }
    @IBAction func uSwipe(sender: AnyObject) {
        GameScene().uSwipe()
    }
    @IBAction func dSwipe(sender: AnyObject) {
        GameScene().dSwipe()
    }
    @IBAction func lSwipe(sender: AnyObject) {
        GameScene().lSwipe()
    }
    @IBAction func rSwipe(sender: AnyObject) {
        GameScene().rSwipe()
    }
    @IBAction func settingButton(sender: AnyObject) {
    //settingsView.center = view.center
        if open {settingsView.hidden = true
        open = false
        GameScene().unpause()}
        
        else {
            highscorelable.text = "High Score: \(highScore)"
            settingsView.hidden = false
        open = true
        GameScene().pause()}
    }
    @IBAction func settingsClose(sender: AnyObject) {
        settingsView.hidden = true
        open = false
        GameScene().unpause()
        
    }
}
