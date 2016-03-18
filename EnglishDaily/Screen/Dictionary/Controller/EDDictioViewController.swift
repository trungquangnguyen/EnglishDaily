//
//  EDDictioViewController.swift
//  EnglishDaily
//
//  Created by Dong Nguyen on 3/18/16.
//  Copyright © 2016 sTeam. All rights reserved.
//

import UIKit

class EDDictioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EDDictionaryManager .sharedInstance.lookUpWord("hello") { (result, error) -> Void in
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
