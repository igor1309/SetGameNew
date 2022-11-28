//
//  ContentView.swift
//  AppStorePreviews
//
//  Created by Igor Malyarov on 28.11.2022.
//  Copyright © 2022 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
