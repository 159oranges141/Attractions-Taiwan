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
        sourceArray = [
                      Scene(name: "Taipei 101", city: "Taipei", address: "No. 7 Xinyi Road Section 5, Xinyi District, Taipei City 11049, Taiwan", description: "just 101", photoCount: 2, photos: ["101_1.jpg","101_2.jpg"])
        ]
    }
}
