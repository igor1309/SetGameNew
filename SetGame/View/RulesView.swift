//
//  RulesView.swift
//  SetGame
//
//  Created by Igor Malyarov on 07.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RulesView: View {
    
    var textView: some View {
        VStack(spacing: 16) {
            Text("Правила игры в Сет")
                .foregroundColor(.primary)
                .font(.headline)
            
            Text("""
Колода состоит из 81 карты. Одинаковых карт в колоде нет.

На стол выкладывается 12 карт. Нужно найти Сет (см. ниже). Если Сета нет, можно запросить дополнительные карты.

Игра продолжается до тех пор, пока не закончится колода и не будут найдены все сеты.

Сет состоит из трёх карт, которые удовлетворяют всем условиям:
- все карты имеют одинаковое количество символов или же 3 различных значения;
- все карты имеют один и тот же символ или же 3 различных символа;
- все карты имеют одинаковую текстуру или же 3 различных варианта текстуры;
- все карты имеют один и тот же цвет или же 3 различных цвета.
""")
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
    var body: some View {
        VStack {
            HStack {
                textView
                Spacer()
            }
            Spacer()
        }
        .background(Color.selectedCardBackground.edgesIgnoringSafeArea(.all))
        .colorScheme(.dark)
    }
}
struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
        .previewColorSchemes()
    }
}
