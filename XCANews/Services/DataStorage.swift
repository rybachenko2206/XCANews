//
//  DataStorage.swift
//  XCANews
//
//  Created by Roman Rybachenko on 27.06.2022.
//

import Foundation

protocol DataStorage: Actor {
    associatedtype D
    
    func save(_ value: D)
    func load() -> D?
}

actor PlistDataStorage<D: Codable>: DataStorage where D: Equatable {
    private var saved: D?
    private let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    private var dataUrl: URL {
        guard let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("\(filename).plist")
        else { fatalError("can't get path to file") }
        
        pl("path to bookmarks file: \n\(url)")
        return url
    }
    
    func save(_ value: D) {
        if let saved = self.saved, saved == value { return }
        
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .binary
            let data = try encoder.encode(value)
            try data.write(to: dataUrl, options: .atomic)
            self.saved = value
        } catch {
            pl(error.localizedDescription)
            assertionFailure()
        }
    }
    
    func load() -> D? {
        do {
            let data = try Data(contentsOf: dataUrl)
            let decoder = PropertyListDecoder()
            let value = try decoder.decode(D.self, from: data)
            self.saved = value
            return value
        } catch {
            pl(error.localizedDescription)
            return nil
        }
    }
}
