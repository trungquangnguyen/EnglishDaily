//
//  EDDictioViewController.swift
//  EnglishDaily
//
//  Created by Dong Nguyen on 3/18/16.
//  Copyright © 2016 sTeam. All rights reserved.
//

import UIKit

class EDDictioViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.autocapitalizationType = .None;
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchWord(searchBar.text)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.endEditing(true)
        searchWord(searchBar.text)
    }
    
    func searchWord(word : String?){
        EDDictionaryManager.sharedInstance.lookUpWord(word!) { (result, error) -> Void in
            if((result) != nil) {
                self.textView.text = result?.createTextFromModel()
                print(result);
            }
        }
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
