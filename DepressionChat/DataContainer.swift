//
//  DataContainer.swift
//  LoseWeightWallpaper
//
//  Created by Qing Jiao on 13/6/17.
//  Copyright © 2017 Qing Jiao. All rights reserved.
//

import Foundation

class DataContainer {
  static let shared = DataContainer()
  private init() {}
  
  var name: String? {
    set {
      if let target = newValue {
        UserDefaults.standard.set(target, forKey: "name")
      }
    }
    get {
      if let v = UserDefaults.standard.object(forKey: "name") as? String {
        return v
      }
      return nil
    }
  }
  
}
