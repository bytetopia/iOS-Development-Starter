//
//  PaletteManager.swift
//  EmojiArt
//
//  Created by anthony on 2021/11/24.
//

import SwiftUI

struct PaletteManager: View {
    
    @EnvironmentObject var store: PaletteStore
    
    @Environment(\.colorScheme) var colorScheme  // get built-in environment values
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.palettes) { palette in
                    NavigationLink(destination: PaletteEditor(palette: $store.palettes[palette])) {
                        VStack(alignment: .leading) {
                            Text(palette.name)
                            Text(palette.emojis)
                        }
                    }
                }
                .onDelete { indexSet in   // define these modifiers and the list will know how to move and delete things and will add buttons for you automatically when environment variable editMode enters .active
                    store.palettes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.palettes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Manage Palettes")
            .navigationBarTitleDisplayMode(.inline)
            .dismissable { presentationMode.wrappedValue.dismiss() }
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
    }

    
}

struct PaletteManager_Previews: PreviewProvider {
    static var previews: some View {
        PaletteManager()
            .environmentObject(PaletteStore(named: "Preview"))
    }
}
