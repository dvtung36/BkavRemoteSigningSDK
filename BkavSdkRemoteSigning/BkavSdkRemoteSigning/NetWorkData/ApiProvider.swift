//
//  ApiProvider.swift
//  BkavSdkRemoteSigning
//
//  Created by Dam Viet Tung on 21/03/2023.
//

import Foundation

struct ApiProvider{
     ///Api Login
     static func loginWithPassWord(completion: @escaping(LoginErrorModel, String) -> Void,userName:String, passWord:String) -> Void {
          
          let url = URL(string: "https://ekycapi.demozone.vn/auth/signin")!

          let jsonString = ["email" : "\(userName)", "password" : "\(passWord)"]
          
          guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonString, options: []) else {
                  return
              }

          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.httpBody = httpBody
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")

          let dataTask = URLSession.shared.dataTask(with: request){ (data, response, error) in
              
               if data == nil {
                    completion(LoginErrorModel(status: false, messageError: "Đã có lỗi xảy ra. Quý khách vui lòng thử lại sau !"), "")
                    return
                  }
               let dataAsString = String(data: data!, encoding: .utf8)
               
               guard error == nil else {
                     return
                  }

                let decoder = JSONDecoder()
               
               do {
                       
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary

                    let status = jsonResult?["status"] as! String 
                    
                    
                    do {
                         if(status == "OK"){
                              let dataJson = jsonResult?["data"] as! [String: Any]
                              let jsonData = try? JSONSerialization.data(withJSONObject:dataJson)
                              let responseLoginMode = try decoder.decode(ResponseLoginMode.self, from: jsonData!) as ResponseLoginMode
                              let defaults = UserDefaults.standard
                              defaults.set(responseLoginMode.accessToken, forKey: "accessToken")
                              
                              completion(LoginErrorModel(status: true, messageError: ""), responseLoginMode.accessToken)
                         }
                         else{
                              let message = jsonResult?["message"] as! String
                              completion(LoginErrorModel(status: false, messageError: message), "")
                         }
                    }
                    catch {
                         completion(LoginErrorModel(status: false, messageError: "\(error)"), "")
                    }
                    
                     } catch {
                          completion(LoginErrorModel(status: false, messageError: "\(error)"),"")
                          return
                     }
            }
            dataTask.resume()
        }

}
