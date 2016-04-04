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
    
    func lookUpWord(word: String,completionHandler: (result: Dictionary<String, Any>?,error: NSError?) -> Void) {
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
                var wordResult = Dictionary<String, Any>()
                wordResult["word"] = word
                
                // Get type of word
                var typeWords = [String]()
                if let types = doc.firstNodeMatchingSelector(".webtop-g"){
                    let posTags = types.nodesMatchingSelector(".pos")
                    for posTag in posTags {
                        typeWords.append(posTag.textContent)
                    }
                }
                wordResult["typeWords"] = typeWords.joinWithSeparator(", ")
                
                // get pronunciation of word
                var pronunciationDic: [String:String] = Dictionary<String, String>()
                if let pronunciationTag = doc.firstNodeMatchingSelector(".pron-gs"){
                    let phoneTags = pronunciationTag.nodesMatchingSelector("span .phon")
                    if phoneTags.count == 2 {
                        pronunciationDic["proBre"] = phoneTags[0].textContent
                        pronunciationDic["proName"] = phoneTags[1].textContent
                    }
                    if let pronunciationSoundUS = pronunciationTag.firstNodeMatchingSelector(".pron-uk"){
                        if let pronunciationSoundUSURL =  pronunciationSoundUS.objectForKeyedSubscript("data-src-mp3") as? String{
                            pronunciationDic["proBreSound"] = pronunciationSoundUSURL
                        }
                    }
                    if let pronunciationSoundUS = pronunciationTag.firstNodeMatchingSelector(".pron-us"){
                        if let pronunciationSoundUSURL =  pronunciationSoundUS.objectForKeyedSubscript("data-src-mp3") as? String{
                            pronunciationDic["proNameSound"] = pronunciationSoundUSURL
                        }
                    }
                }
                
                
                wordResult["proBre"] = pronunciationDic["proBre"]
                wordResult["proName"] = pronunciationDic["proName"]
                wordResult["proBreSound"] = pronunciationDic["proBreSound"]
                wordResult["proNameSound"] = pronunciationDic["proNameSound"]
                // get description of word
                
                let sngsTags = doc.nodesMatchingSelector(".sn-gs")
                var descriptionWords = [NSDictionary]()
                for sngsTag in sngsTags {
                    if let sngTag = sngsTag as? HTMLElement {
                        // fetch all sn-g tag in s-ngs
                        for sngsElement in sngTag.children {
                            if let sngElement = sngsElement as? HTMLElement { // TODO: should be able to combine this with loop above
                                if let newDes = self.parseSngRow(sngElement) {
                                    descriptionWords.append(newDes);
                                }
                            }
                        }
                    }
                }
                wordResult["descriptionWords"] = descriptionWords
                
                completionHandler(result: wordResult, error: nil)
        }
        
        completionHandler(result: nil, error: nil)
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
    
    
    private func parseSngRow(rowElement: HTMLElement) -> NSDictionary? {
        var describle: [String:String] = Dictionary<String, String>()
        describle["def"] = rowElement.firstNodeMatchingSelector(".def")?.textContent
        describle["ex"] = rowElement.firstNodeMatchingSelector(".x-g .x")?.textContent
        
        return describle
    }
    
}




