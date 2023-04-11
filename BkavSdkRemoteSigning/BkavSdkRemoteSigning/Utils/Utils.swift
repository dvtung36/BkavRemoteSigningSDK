//
//  Utils.swift
//  BkavSdkRemoteSigning
//
//  Created by Dam Viet Tung on 21/03/2023.
//

import Foundation

struct LoginErrorModel{
     
     var status: Bool
     var messageError: String

}

struct ResponseLoginMode:Decodable{
     
     var tokenId:String
     var tokenKey: String
     var accessToken: String
     var type: String
     var refreshToken:String
     
}
