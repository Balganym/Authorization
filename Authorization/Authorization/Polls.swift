//
//  Polls.swift
//  Authorization
//
//  Created by mac on 07.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import ObjectMapper
import Alamofire

struct Polls: Mappable {
    
    var title = ""
    var image = ""
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        image <- map["image"]
    }
    
    static func getPolls(completion: @escaping ([Polls]?, String?) -> Void) {
        
        let url = "https://apivotem.solf.io/api/polls/feed/"
        
        Alamofire.request(url, method: .post).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    let results = json["result"] as! [[String: Any]]
                    completion(results.map { Polls(JSON: $0)! }, nil)
                default:
                    completion(nil, "Неизвестная ошибка")
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
