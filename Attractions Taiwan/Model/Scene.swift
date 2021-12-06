//
//  Sence.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/6.
//

import Foundation

struct Scene: Hashable {
    var name: String = ""
    var city: String = ""
    var address: String = ""
    var description: String = ""
    var photoCount: Int = 0
    var photos: [String] = ["", "", ""]
}

extension Scene {
    static func generateData( sourceArray: inout [Scene]){
        sourceArray = []
    }
}
