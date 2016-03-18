//
//  EDDictionaryManager.swift
//  EnglishDaily
//
//  Created by Dong Nguyen on 3/18/16.
//  Copyright © 2016 sTeam. All rights reserved.
//

import UIKit
import Alamofire
import HTMLReader
class EDDictionaryManager: NSObject {
    
//    +(instancetype)shareInstance{
//    static DatabaseManager *_shareObject = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//    _shareObject = [[self alloc] init];
//    });
//    return _shareObject;
//    }
    
    
     static let sharedInstance = EDDictionaryManager()
    
    func lookUpWord(word: String,completionHandler: (result: NSDictionary?,error: NSError?) -> Void) {
        let URLString = "http://www.oxfordlearnersdictionaries.com/definition/english/\(word)"
        Alamofire.request(.GET, URLString)
            .responseString { responseString in
                guard responseString.result.error == nil else {
                    completionHandler(result: nil, error: responseString.result.error!)
                    return
                    
                }
                guard let htmlAsString = responseString.result.value else {
                    let error = Error.errorWithCode(.StringSerializationFailed, failureReason: "Could not get HTML as String")
                    completionHandler(result: nil, error: error)
                    return
                }
                
                let doc = HTMLDocument(string: htmlAsString)
                
                // find the table of charts in the HTML
                let tables = doc.firstNodeMatchingSelector("#hello_1__11")
                print(tables?.textContent)
              
        }
                //                var chartsTable:HTMLElement?
                //                for table in tables {
                //                    if let tableElement = table as? HTMLElement {
                //                        if self.isChartsTable(tableElement) {
                //                            chartsTable = tableElement
                //                            break
                //                        }
                //                    }
                //                }
                //
                //                // make sure we found the table of charts
                //                guard let tableContents = chartsTable else {
                //                    // TODO: create error
                //                    let error = Error.errorWithCode(.DataSerializationFailed, failureReason: "Could not find charts table in HTML document")
                //                    completionHandler(error)
                //                    return
                //                }
                //
                //                self.charts = []
                //                for row in tableContents.children {
                //                    if let rowElement = row as? HTMLElement { // TODO: should be able to combine this with loop above
                //                        if let newChart = self.parseHTMLRow(rowElement) {
                //                            self.charts?.append(newChart)
                //                        }
                //                    }
                //                }
                completionHandler(result: nil, error: nil)
        }
    }
    
    
    private func isChartsTable(tableElement: HTMLElement) -> Bool {
        if tableElement.children.count > 0 {
            let firstChild = tableElement.childAtIndex(0)
            let lowerCaseContent = firstChild.textContent.lowercaseString
            if lowerCaseContent.containsString("number") && lowerCaseContent.containsString("scale") && lowerCaseContent.containsString("title") {
                return true
            }
        }
        return false
    }
    
    
    //    private func parseHTMLRow(rowElement: HTMLElement) -> Chart? {
    //        var url: NSURL?
    //        var number: Int?
    //        var scale: Int?
    //        var title: String?
    //        // first column: URL and number
    //        if let firstColumn = rowElement.childAtIndex(1) as? HTMLElement {
    //            // skip the first row, or any other where the first row doesn't contain a number
    //            if let urlNode = firstColumn.firstNodeMatchingSelector("a") {
    //                if let urlString = urlNode.objectForKeyedSubscript("href") as? String {
    //                    url = NSURL(string: urlString)
    //                }
    //                // need to make sure it's a number
    //                let textNumber = firstColumn.textContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    //                number = Int(textNumber)
    //            }
    //        }
    //        if (url == nil || number == nil) {
    //            return nil // can't do anything without a URL, e.g., the header row
    //        }
    //
    //        if let secondColumn = rowElement.childAtIndex(3) as? HTMLElement {
    //            let text = secondColumn.textContent
    //                .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    //                .stringByReplacingOccurrencesOfString(",", withString: "")
    //            scale = Int(text)
    //        }
    //
    //        if let thirdColumn = rowElement.childAtIndex(5) as? HTMLElement {
    //            title = thirdColumn.textContent
    //                .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    //                .stringByReplacingOccurrencesOfString("\n", withString: "")
    //        }
    //        
    //        if let title = title, url = url, number = number, scale = scale {
    //            return Chart(title: title, url: url, number: number, scale: scale)
    //        }
    //        return nil
    //    }


