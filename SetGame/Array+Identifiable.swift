//
//  Array+Identifiable.swift
//  MemoryGameLecture4
//
//  Created by Igor Malyarov on 29.05.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
