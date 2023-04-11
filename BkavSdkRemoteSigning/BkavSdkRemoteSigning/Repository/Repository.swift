//
//  Repository.swift
//  BkavSdkRemoteSigning
//
//  Created by Dam Viet Tung on 21/03/2023.
//

import Foundation

public class Repository{
     
     static func login (completion: @escaping(LoginErrorModel, String) -> Void, userName:String, passWord:String) -> Void{
          ApiProvider.loginWithPassWord(completion: { LoginErrorModel,accessToken  in
               completion(LoginErrorModel, accessToken)
          }, userName: userName, passWord: passWord)
           
     }
}
