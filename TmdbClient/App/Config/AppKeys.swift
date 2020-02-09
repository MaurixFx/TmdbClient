//
//  AppKeys.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 07-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class AppKeys {
    
    // MARK: CODES
    enum Codes {
        static let apiKey = "25a8f80ba018b52efb64f05140f6b43c"
        static let urlImage = "https://image.tmdb.org/t/p/w500"
    }
    
    // MARK: NOTIFICACIONS
    enum Notifications {
        static let START_ALERT = Notification.Name("startAlert")
        static let STOP_ALERT = Notification.Name("stopAlert")
        static let CLOSE_ALERT = Notification.Name("closeAlert")
    }
    
    // MARK: CELLS
    enum Cells {
        static let tvShows = "tvShows"
    }
    
}
