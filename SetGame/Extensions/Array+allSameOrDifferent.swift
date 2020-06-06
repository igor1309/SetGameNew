//
//  Array+allSameOrDifferent.swift
//  SetGame
//
//  Created by Igor Malyarov on 06.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func allSameOrDifferent() -> Bool {
        guard !self.isEmpty else { return true }
        
        let first = self.first!
        let allSame = self.allSatisfy { $0 == first }
        
        let allDifferent = self.count == Set(self).count
        
        return allSame || allDifferent
    }
}
