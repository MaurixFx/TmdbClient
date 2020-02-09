//
//  Utils.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 08-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class Utils {
    
    static func downloadingImageToData(posterUrl: String) -> Data? {
        guard let url = getUrlImageTvShow(posterUrl: posterUrl) else { return nil }
        if let data = try? Data(contentsOf: url) {
           return data
        }
        return nil
    }
    
    static func getUrlImageTvShow(posterUrl: String) -> URL? {
        guard let url = URL(string: "\(AppKeys.Codes.urlImage)\(posterUrl)") else {
            return nil
        }
        return url
    }
    
    static func loadJSONObject(_ fileName: String, bundle: Bundle = Bundle.main) -> [String: Any]? {
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                return jsonResult as? [String: Any]
            } catch {
                return nil
            }
        }
        return nil
    }
}
