//
//  PaletteStore.swift
//  EmojiArt
//
//  Created by anthony on 2021/11/21.
//

import SwiftUI

struct Palette: Identifiable, Codable {
    var name: String
    var emojis: String
    var id: Int
    
    // fileprivate init to make sure that you can only add new palette with the method in PaletteStore
    // to make sure the inner id is unique
    fileprivate init(name: String, emojis: String, id: Int) {
        self.name = name
        self.emojis = emojis
        self.id = id
    }
}

class PaletteStore: ObservableObject {
    let name: String
    
    @Published var palettes = [Palette]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "PaletteStore:" + name
    }
    
    private func storeInUserDefaults() {
        // need to serialize the list of Palette to list of array strings to save it to UserDefaults
        
        // bad implementation
        // UserDefaults.standard.set(palettes.map{ [$0.name, $0.emojis, String($0.id)] }, forKey: userDefaultsKey)
        
        // better implementation
        UserDefaults.standard.set(try? JSONEncoder().encode(palettes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        // things get from UserDefaults is type Any, need to cast explicitly
        
        // bad implementation
        /*
        if let palettesAsPropertyList = UserDefaults.standard.array(forKey: userDefaultsKey) as? [[String]] {
            for paletteArray in palettesAsPropertyList {
                if paletteArray.count == 3, let id = Int(paletteArray[2]), !palettes.contains(where: { $0.id == id }) {
                    let palette = Palette(name: paletteArray[0], emojis: paletteArray[1], id: id)
                    palettes.append(palette)
                }
            }
        }
        */
        
        // better implementation
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedPalettes = try? JSONDecoder().decode(Array<Palette>.self, from: jsonData) {
            palettes = decodedPalettes
        }
        
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if palettes.isEmpty {
            print("using build-in palettes")
            // load some default value
            insertPalette(named: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜")
            insertPalette(named: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳")
            insertPalette(named: "Music", emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻")
            insertPalette(named: "Animals", emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔")
            insertPalette(named: "Animal Faces", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲")
            insertPalette(named: "Flora", emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻")
            insertPalette(named: "Weather", emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪")
            insertPalette(named: "COVID", emojis: "💉🦠😷🤧🤒")
            insertPalette(named: "Faces", emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠")
        } else {
            print("successfully loaded palettes from UserDefaults: \(palettes)")
        }
    }
    
    // MARK: - Intent
    
    // get a palette at certain index
    func palette(at index: Int) -> Palette {
        let safeIndex = min(max(index, 0), palettes.count - 1)
        return palettes[safeIndex]
    }
    
    // remove palette at certain index
    @discardableResult
    func removePalette(at index: Int) -> Int {
        if palettes.count > 1, palettes.indices.contains(index) {
            palettes.remove(at: index)
        }
        return index % palettes.count
    }
    
    // insert palette at certain index
    // note that index != id, index is for the palettes array, id just for unique identifier inside the Palette and is not visible to users
    func insertPalette(named name: String, emojis: String? = nil, at index: Int = 0) {
        let uniqueNewId = (palettes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let palette = Palette(name: name, emojis: emojis ?? "", id: uniqueNewId)
        let safeIndex = min(max(index, 0), palettes.count)
        palettes.insert(palette, at: safeIndex)
    }
    
    
}

