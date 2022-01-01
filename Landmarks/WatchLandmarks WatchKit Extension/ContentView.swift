//
//  ContentView.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by anthony on 2022/1/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
