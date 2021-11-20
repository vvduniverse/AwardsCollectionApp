//
//  CustomGridView.swift
//  AwardsCollectionApp
//
//  Created by Alexey Efimov on 17.11.2021.
//

import SwiftUI

struct CustomGridView<Content, T>: View where Content: View {
    let items: [T]
    let columns: Int
    let content: (CGFloat, T) -> Content
    var rows: Int {
        items.count / columns
    }
    
    var body: some View {
        GeometryReader { geometry in
            let sideLength = geometry.size.width / CGFloat(columns)
            ScrollView {
                VStack {
                    ForEach(0...rows, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0..<columns) { columnIndex in
                                if let index = indexFor(row: rowIndex, column: columnIndex) {
                                    content(sideLength, items[index])
                                } else {
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func indexFor(row: Int, column: Int) -> Int? {
        let index = row * columns + column
        return index < items.count ? index : nil
    }
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView(items: [11, 3, 7, 17, 5, 2, 1], columns: 3) {sideLength, item in
            Text("\(item)")
                .frame(width: sideLength, height: sideLength)
                
        }
    }
}
