//
//  HealFlatTextFieldContainter+CountryList.swift
//  heal_ios
//
//  Created by Francis Myat on 10/12/22.
//
// swiftlint: disable force_cast

import Foundation
import UIKit

extension HealFlatTextFieldContainer {
    public struct Cache {
        static var states: [String]!
        static var codes: [String]!
        static var types: [String]!
    }
    
    public struct JSONKey {
        static let stateArray = "State"
        static let stateName = "State"
        
        static let stateCodeArray = "Description"
        static let stateCodeName = "Description"
        
        static let typeArray = "Type"
        static let typeName = "Type"
    }
    
    public func getTypes() -> [String] {
        loadIfNotLoaded()
        return Cache.types
    }
    public func getCodes() -> [String] {
        loadStateCode(state: numberTextField.text ?? "")
//        loadIfNotLoaded()
        return Cache.codes
    }
    public func getStates() -> [String] {
        loadIfNotLoaded()
        return Cache.states
    }
    
    public func loadIfNotLoaded() {
        if Cache.states == nil {
            load()
        }
    }
    
    public func load() {
        Cache.states = []
        Cache.codes = []
        Cache.types = []
        
        if let url = Bundle.main.url(forResource: "nrc-infos", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: url)
                
                let raw = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let json = raw as! [String: Any]
                
                let _states = json[ JSONKey.stateArray ] as! [[String: Any]]
                
                for each in _states {
                    Cache.states.append(each[ JSONKey.stateName ] as! String)
                    
                    let _stateCodeArray = each[ JSONKey.stateCodeArray ] as! [[String: Any]]
                    
                    for e in _stateCodeArray {
                        Cache.codes.append(e[ JSONKey.stateCodeName ] as! String)
                    }
                }
                
                let _types = json[ JSONKey.typeArray ] as! [[String: Any]]
                
                for each in _types {
                    Cache.types.append(each[ JSONKey.typeName ] as! String)
                }
                
            } catch { }
        }
    }
    
    public func loadStateCode(state: String) {
        Cache.codes = []
        
        if let url = Bundle.main.url(forResource: "nrc-infos", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: url)
                
                let raw = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let json = raw as! [String: Any]
                
                let _states = json[ JSONKey.stateArray ] as! [[String: Any]]
                
                for each in _states {
                    
                    if let stateName = each[ JSONKey.stateName ] as? String,
                       stateName == state {
                        let _stateCodeArray = each[ JSONKey.stateCodeArray ] as! [[String: Any]]
                        
                        for e in _stateCodeArray {
                            Cache.codes.append(e[ JSONKey.stateCodeName ] as! String)
                        }
                    }
                    
                }
                
            } catch { }
        }
    }
}
