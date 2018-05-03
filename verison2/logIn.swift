//
//  logIn.swift
//  Flipper
//
//  Created by 尹笑康 on 2018/5/3.
//  Copyright © 2018年 CSE 208-Group India. All rights reserved.
//

import Foundation
struct  logInToFlipper {
    private  static var userInformationFileName =  "userInformation"
    private  static var DocunmentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    private  static var userInformationFileURL = DocunmentDirURL.appendingPathComponent(userInformationFileName).appendingPathExtension("txt")
    
    public static func register( userName : String , password : String ) -> Bool{
        var contentOfFile = ""
        do{
            contentOfFile = try String(contentsOf: userInformationFileURL)
        }catch let error as NSError{
            Swift.print(error)
        }
        
        let users = contentOfFile.components(separatedBy: "\n")
        for user in users{
            if user.components(separatedBy: "+").count > 1{
                if user.components(separatedBy: "+")[0].elementsEqual(userName){
                    return false
                }
            }
        }
        contentOfFile.append(userName + "+" + password+"\n")
        do{
            try contentOfFile.write(to: userInformationFileURL, atomically: true, encoding: String.Encoding.utf8)
        }catch let error as NSError{
            Swift.print(error)
        }
        return true
    }
    
    public static func logIn(userName : String , password : String ) -> Bool{
        var contentOfFile = ""
        do{
            contentOfFile = try String(contentsOf: userInformationFileURL)
        }catch let error as NSError{
            Swift.print(error)
        }
        
        let users = contentOfFile.components(separatedBy: "\n")
        for user in users{
            if user.components(separatedBy: "+").count > 1{
                if user.components(separatedBy: "+")[0].elementsEqual(userName) && user.components(separatedBy: "+")[1].elementsEqual(password){
                    return true
                }
            }
        }
        return false
    }
    
    
}
