//
//  TestSDK.swift
//  BkavSdkRemoteSigning
//
//  Created by Dam Viet Tung on 21/03/2023.
//

import Foundation

public class ModulLogin{
   
     public func loginEkycWithPassWord(completion: @escaping(String) -> Void,userName: String, passWord: String)-> Void{
          
           
          Repository.login(completion: { LoginErrorModel, accessToken in
 
               completion(accessToken)
               
          }, userName:  userName, passWord: passWord)
           
       
      }
}
