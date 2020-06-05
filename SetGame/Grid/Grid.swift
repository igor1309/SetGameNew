//
//  Grid.swift
//  EmojiMemoryGame
//
//  Created by Igor Malyarov on 02.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI


/// CS193p - Developing Apps for iOS. Lecture 4
/// https://cs193p.sites.stanford.edu
///
struct Grid<Item: Identifiable, ItemView: View>: View {
    //    let axisSet: Axis.Set
    //    let columns: Int
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(
        //        _ axisSet: Axis.Set = .vertical,
        //        columns: Int = 3,
        _ items: [Item],
        @ViewBuilder viewForItem: @escaping (Item) -> ItemView
    ) {
        //        self.axisSet = axisSet
        //        self.columns = columns
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}

