//
//  APIManager.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 4/1/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation
import Alamofire

struct APIManager {
    static var manager: SessionManager!
       
       /// GET FROM API
       ///
       /// - Parameters:
       ///   - url: URL API
       ///   - method: methods
       ///   - parameters: parameters
       ///   - encoding: encoding
       ///   - headers: headers
       ///   - completion: completion
       ///   - failure: failure
       static func request(_ url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response: Data) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
           
           let configuration = URLSessionConfiguration.default
           configuration.timeoutIntervalForRequest = 60 //30
           configuration.timeoutIntervalForResource = 60
           configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
           
           manager = Alamofire.SessionManager(configuration: configuration)
           
          // let apiURL = "baseURL" + url
           let apiURL = API.baseUrl!+url
           let api2 = (ServersManager.currentServers?.datos.url1)! + url
          // print("-- URL API: \(apiURL), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
           print("-- URL API2: \(api2), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
           manager.request(
               api2,
               method: method,
               parameters: parameters,
               encoding: encoding,
               headers: headers).responseString(
                   queue: DispatchQueue.main,
                   encoding: String.Encoding.utf8) { response in
                       
                       print("--\n \n CALLBACK RESPONSE: \(response)")
                       
                       if response.response?.statusCode == 200 {
                           guard let callback = response.data else {
                               failure(self.generateRandomError(), 0)
                               return
                           }
                           completion(callback)
                           
                       } else if response.response?.statusCode == 401 {
                           // add function automatically logout app
                       } else {
                           guard let callbackError = response.data else {
                               return
                           }
                           
                           do {
                               let decoded = try JSONDecoder().decode(
                                   APIerror.self, from: callbackError)
                               
                               
                               failure(decoded.error!,0)
                               
                               /*
                               if let messageError = decoded.data?.errors?.messages, let errorCode = decoded.statusCode {
                                   let messages = messageError.joined(separator: ", ")
                                   failure(messages, errorCode)
                               } else {
                                   failure(APIManager.generateRandomError(), 0)
                               }
                               */
                               
                           } catch _ {
                               failure(APIManager.generateRandomError(), 0)
                           }
                       }
                       
           }.session.finishTasksAndInvalidate()
           
           manager.session.invalidateAndCancel()
           
       }
       
    
    static func request4(_ url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response: Data) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
              
              let configuration = URLSessionConfiguration.default
              configuration.timeoutIntervalForRequest = 60 //30
              configuration.timeoutIntervalForResource = 60
              configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
              
              manager = Alamofire.SessionManager(configuration: configuration)
              
             // let apiURL = "baseURL" + url
        
        let apiURL = API.baseUrl4!+url
        let api2 = (ServersManager.currentServers?.datos.url2)! + url
       // print("-- URL API: \(apiURL), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
        print("-- URL API2: \(api2), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
              
              manager.request(
                  api2,
                  method: method,
                  parameters: parameters,
                  encoding: encoding,
                  headers: headers).responseString(
                      queue: DispatchQueue.main,
                      encoding: String.Encoding.utf8) { response in
                          
                          print("--\n \n CALLBACK RESPONSE: \(response)")
                          
                          if response.response?.statusCode == 200 {
                              guard let callback = response.data else {
                                  failure(self.generateRandomError(), 0)
                                  return
                              }
                              completion(callback)
                              
                          } else if response.response?.statusCode == 401 {
                              // add function automatically logout app
                          } else {
                              guard let callbackError = response.data else {
                                  return
                              }
                              
                              do {
                                  let decoded = try JSONDecoder().decode(
                                      APIerror.self, from: callbackError)
                                  
                                  
                                  failure(decoded.error!,0)
                                  
                                  /*
                                  if let messageError = decoded.data?.errors?.messages, let errorCode = decoded.statusCode {
                                      let messages = messageError.joined(separator: ", ")
                                      failure(messages, errorCode)
                                  } else {
                                      failure(APIManager.generateRandomError(), 0)
                                  }
                                  */
                                  
                              } catch _ {
                                  failure(APIManager.generateRandomError(), 0)
                              }
                          }
                          
              }.session.finishTasksAndInvalidate()
              
              manager.session.invalidateAndCancel()
              
          }
       /// GENERATE RANDOM ERROR
       ///
       /// - Returns: string error randoms
       static func generateRandomError() -> String {
           return "Oops. There is an error. Please reload."
       }
       
}

struct APIManagerGeovoy {
    static var manager: SessionManager!
    
    /// GET FROM API
    ///
    /// - Parameters:
    ///   - url: URL API
    ///   - method: methods
    ///   - parameters: parameters
    ///   - encoding: encoding
    ///   - headers: headers
    ///   - completion: completion
    ///   - failure: failure
    static func request(_ url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response: Data, String) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 //30
        configuration.timeoutIntervalForResource = 60
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        manager = Alamofire.SessionManager(configuration: configuration)
        
       // let apiURL = "baseURL" + url
        let apiURL = API.baseUrl! + url
        let api2 = (ServersManager.currentServers?.datos.url1)! + url
      //  print("-- URL API: \(apiURL), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
        print("-- URL API2: \(api2), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
        
        manager.request(
            api2,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers).responseString(
                queue: DispatchQueue.main,
                encoding: String.Encoding.utf8) { response in
                    
                    print("--\n \n CALLBACK RESPONSE: \(response)")
                    print("--\n \n statusCode : \(response.response?.statusCode)")
                    if response.response?.statusCode == 200 {
                        print("code 200")
                        guard let callback = response.data else {
                            failure(self.generateRandomError(), 0)
                            print("code 200 failure")
                            return
                        }
                        var str = ""
                        str = response.response?.value(forHTTPHeaderField: "Set-Cookie") ?? ""
                        
                      //  completion(callback)
                        completion(callback, str)
                        
                    } else if response.response?.statusCode == 401 {
                        failure("401",0)
                        // add function automatically logout app
                    } else {
                        print("else code 200")
                        guard let callbackError = response.data else {
                            print("else code 200 else")
                            return
                        }
                        
                        do {
                            print("code 200 DO")
                            let decoded = try JSONDecoder().decode(
                                APIerror.self, from: callbackError)
                            
                            
                            failure(decoded.error!,0)
                            
                            /*
                            if let messageError = decoded.data?.errors?.messages, let errorCode = decoded.statusCode {
                                let messages = messageError.joined(separator: ", ")
                                failure(messages, errorCode)
                            } else {
                                failure(APIManager.generateRandomError(), 0)
                            }
                            */
                            
                        } catch _ {
                            failure(APIManager.generateRandomError(), 0)
                        }
                    }
                    
        }.session.finishTasksAndInvalidate()
        
        manager.session.invalidateAndCancel()
        
    }
    /// GENERATE RANDOM ERROR
    ///
    /// - Returns: string error randoms
    static func generateRandomError() -> String {
        print("ERROR RANDOM")
        return "Oops. There is an error. Please reload."
    }
}

struct APIManagerServers {
    static var manager: SessionManager!
    
    /// GET FROM API
    ///
    /// - Parameters:
    ///   - url: URL API
    ///   - method: methods
    ///   - parameters: parameters
    ///   - encoding: encoding
    ///   - headers: headers
    ///   - completion: completion
    ///   - failure: failure
    static func request(_ url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response: Data) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 //30
        configuration.timeoutIntervalForResource = 60
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        manager = Alamofire.SessionManager(configuration: configuration)
        
       // let apiURL = "baseURL" + url
        let apiURL = API.baseUrlServers+url
        print("-- URL API: \(apiURL), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
        
        manager.request(
            apiURL,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers).responseString(
                queue: DispatchQueue.main,
                encoding: String.Encoding.utf8) { response in
                    
                    print("--\n \n CALLBACK RESPONSE: \(response)")
                    if response.response?.statusCode == 200 {
                        print("code 200")
                        guard let callback = response.data else {
                            failure(self.generateRandomError(), 0)
                            print("code 200 failure")
                            return
                        }
                        var str = ""
                        str = response.response?.value(forHTTPHeaderField: "Set-Cookie") ?? ""
                        
                      //  completion(callback)
                        completion(callback)
                        
                    } else if response.response?.statusCode == 401 {
                        
                        // add function automatically logout app
                    } else {
                        print("else code 200")
                        guard let callbackError = response.data else {
                            print("else code 200 else")
                            return
                        }
                        
                        do {
                            print("code 200 DO")
                            let decoded = try JSONDecoder().decode(
                                APIerror.self, from: callbackError)
                            
                            
                            failure(decoded.error!,0)
                            
                            /*
                            if let messageError = decoded.data?.errors?.messages, let errorCode = decoded.statusCode {
                                let messages = messageError.joined(separator: ", ")
                                failure(messages, errorCode)
                            } else {
                                failure(APIManager.generateRandomError(), 0)
                            }
                            */
                            
                        } catch _ {
                            failure(APIManager.generateRandomError(), 0)
                        }
                    }
                    
        }.session.finishTasksAndInvalidate()
        
        manager.session.invalidateAndCancel()
        
    }
    
    
    static func requestFit(_ url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response:  Int) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 //30
        configuration.timeoutIntervalForResource = 60
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        manager = Alamofire.SessionManager(configuration: configuration)
        
       // let apiURL = "baseURL" + url
        let apiURL = API.baseUrlServers+url
        print("-- URL API: \(apiURL), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
        
        manager.request(
            apiURL,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers).responseString(
                queue: DispatchQueue.main,
                encoding: String.Encoding.utf8) { response in
                    
                    print("--\n \n CALLBACK RESPONSE: \(response)")
                    print("--\n \n CALLBACK RESPONSE2: \(response.response?.statusCode)")
                    print("--\n \n CALLBACK RESPONSE3: \(response.data)")
              
                        print("code 200 request fit")
                       
                        
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 202 {
                        print("code 200")
                        guard let callback = response.data else {
                            failure(self.generateRandomError(), 0)
                            print("code 200 failure")
                            return
                        }
                        var str = ""
                        str = response.response?.value(forHTTPHeaderField: "Set-Cookie") ?? ""
                        
                      //  completion(callback)
                        completion(response.response!.statusCode)
                        
                    } else  {
                        completion(response.response!.statusCode)
                    }
                    
        }.session.finishTasksAndInvalidate()
        
        manager.session.invalidateAndCancel()
        
    }
    /// GENERATE RANDOM ERROR
    ///
    /// - Returns: string error randoms
    static func generateRandomError() -> String {
        print("ERROR RANDOM")
        return "Oops. There is an error. Please reload."
    }
}
