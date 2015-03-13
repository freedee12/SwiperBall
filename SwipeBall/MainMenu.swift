//
//  MainMenu.swift
//  SwiperBall
//
//  Created by Teddy Dubno on 3/10/15.
//  Copyright (c) 2015 Teddy Dubno. All rights reserved.
//

import Foundation
import UIKit
import CoreData
var username:String = ""
class MainMenu: UIViewController {
    override func viewDidAppear(animated: Bool) {
        
        
        var defaults=NSUserDefaults()
        
        if defaults.valueForKey("UserName") == nil {
            var loginAlert:UIAlertController = UIAlertController(title: "Sign Up", message: "Please sign up", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your username"
            })
            
//            loginAlert.addTextFieldWithConfigurationHandler({
//                textfield in
//                textfield.placeholder = "Your password"
//                textfield.secureTextEntry = true
//            })
            
//            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
//                alertAction in
//                let textFields:NSArray = loginAlert.textFields as AnyObject! as NSArray
//                let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
                //let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
                
                /*PFUser.logInWithUsernameInBackground(usernameTextfield.text, password: passwordTextfield.text){
                (user:PFUser!, error:NSError!)->Void in
                if user != nil{
                println("Login successfull")
                }else{
                loginAlert.message = "Username/Password combination incorrect"
                self.presentViewController(loginAlert, animated: true, completion: nil)
                }
                }*/
            //}))
            
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields:NSArray = loginAlert.textFields as AnyObject! as NSArray
                let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
                //let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
                
                var message:PFUser = PFUser()
                username = usernameTextfield.text
                defaults.setValue(username, forKey: "UserName")
                
                /*message.signUpInBackgroundWithBlock{
                (success:Bool!, error:NSError!)->Void in
                if error == nil{
                println("Sign Up successfull")
                }else{
                let errorString = error.localizedDescription
                println(errorString)
                }
                
                
                }*/
                
                
                
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
        else {
        username = defaults.valueForKey("UserName") as String
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        <#code#>
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


