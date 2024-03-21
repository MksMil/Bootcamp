//
//  MyGrid.swift
//  Bootcamp
//
//  Created by Миляев Максим on 08.03.2024.
//
// VGrid
// columns - fixed / flexible / adaptive

import SwiftUI

let blue = Color(red: 0, green: 146/255.0, blue: 219/255.0)

struct MyGrid: View {
    
    func makeItems(_ count: Int) -> [Color] { Array(repeating: blue, count: count) }
    
    var itemsFirst: [Color] = Array(repeating: blue, count: 10)
    
    var body: some View {
        //          This Example
        //      demonstrate an unpredictable
        //        results of grid composing
        
        ScrollView(.vertical){
            VStack{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], content: {
                    ForEach(itemsFirst.indices, id:\.self) { idx in
                        itemsFirst[idx].frame(height: 50)
                    }
                })
                .padding()
                .frame(width: 350)
                .border(Color.red, width: 3)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100)),
                    GridItem(.flexible(minimum: 180))
                ]) {
                    ForEach(itemsFirst.indices, id: \.self) { idx in
                        itemsFirst[idx].measured.frame(height: 50)
                    }
                }
                .frame(width: 300)
                .border(Color.red, width: 3)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100)),
                    GridItem(.adaptive(minimum: 40)),
                    GridItem(.flexible(minimum: 180))
                ]) {
                    ForEach(itemsFirst.indices,id: \.self) { idx in
                        itemsFirst[idx].measured.frame(height: 50)
                    }
                }
                .frame(width: 300)
                .border(Color.red,width: 3)
            }
        }
    }
}

#Preview {
    MyGrid()
}
