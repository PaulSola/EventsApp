//
//  JSONParser.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/27/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

typealias RequestCompletion = (Data?,URLResponse?,Error?)

enum ParseResult<T>{
    case success(T)
    case failure(String)
}

class JSONParser {
    
    typealias result<T> = (ParseResult<T>) -> Void
    
    static func parse<T: Decodable, EndPoint : EndPointType>(of type: T.Type,
                                    api : EndPoint,
                                    routerCompletion: RequestCompletion,
                                    completion: @escaping result<T>) {

        
        func shouldRefresh(){
            let authManager = AuthManager()
            
            func tryRequestAgain(){
                if TokenManager.getTokenStatus() {
                    let router = Router<EndPoint>()
                    router.request(api) { (data, response, error) in
                        parseAfterRefresh(of: T.self, routerCompletion: (data, response, error), completion: { (result) in
                            switch result {
                            case .failure(let error):
                                completion(.failure(error))
                            case .success(let object):
                                completion(.success(object))
                            }
                        })
                    }
                    print("Try Request again") }
                else {completion(.failure("Token is not valid"))}
            }
            
            if AuthManager.getRefreshStatus() != true{
                //AuthManager.setRefreshStatus(true)
                authManager.refreshToken() { (error) in
                    AuthManager.setRefreshStatus(false)
                    error == nil ? tryRequestAgain(): completion(.failure(error!))
                }
            }
            else{
                DispatchQueue.main.async {
                    while AuthManager.getRefreshStatus() == true {}
                    print("waited")
                    tryRequestAgain()
                }
                
            }
        }
        
            if routerCompletion.2 != nil {
                completion(.failure("Please check your network connection."))
            }
            if let response = routerCompletion.1 as? HTTPURLResponse {
                //print(response)
                let result = Network.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = routerCompletion.0 else {
                        completion(.failure(NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        
                        print( try JSONSerialization.jsonObject(with:
                            responseData, options: []))
                        
                        let apiResponse: T = try JSONDecoder().decode(T.self, from: responseData)
                        completion(.success(apiResponse))
                    }catch {
                        
                        completion(.failure(NetworkResponse.unableToDecode.rawValue + error.localizedDescription))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                case .outDatedToken:
                    print(AuthManager.getRefreshStatus())
                   shouldRefresh()
                }
            }
    }
    
    private static func customParse(routerCompletion: RequestCompletion,
    completion: @escaping(_ result: Any?,_ error: String?)->()) {
        if routerCompletion.2 != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = routerCompletion.1 as? HTTPURLResponse {
                let result = Network.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = routerCompletion.0 else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with:
                            responseData, options: [])
                        completion(apiResponse , nil)
                        
                    }catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil ,networkFailureError)
                case .outDatedToken:
                    completion(nil, "RIP")
                }
            }
    }
    
    private static func parseAfterRefresh<T: Decodable>(of type: T.Type,
                                                routerCompletion: RequestCompletion,
                                                completion: @escaping result<T>) {
        if routerCompletion.2 != nil {
            completion(.failure("Please check your network connection."))
        }
        if let response = routerCompletion.1 as? HTTPURLResponse {
            let result = Network.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = routerCompletion.0 else {
                    completion(.failure(NetworkResponse.noData.rawValue))
                    return
                }
                do {
                    let apiResponse: T = try JSONDecoder().decode(T.self, from: responseData)
                    completion(.success(apiResponse))
                }catch {
                    completion(.failure(NetworkResponse.unableToDecode.rawValue))
                }
            case .failure(let networkFailureError):
                completion(.failure(networkFailureError))
            case .outDatedToken:
                completion(.failure("RIP"))
            }
        }
        
    }
}
