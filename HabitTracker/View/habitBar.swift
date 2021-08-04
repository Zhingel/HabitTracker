//
//  habitBar.swift
//  HabitTracker
//
//  Created by Стас Жингель on 03.08.2021.
//

import SwiftUI

struct habitBar: View {
    var value: Float
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
            VStack {
                HStack {
                    Text("Все получится!")
                    Spacer()
                    Text("\(value*100)%")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 10)
                        .foregroundColor(.gray)
                        .cornerRadius(45)
                    Rectangle()
                        .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 10)
                        .animation(.linear)
                        .foregroundColor(Color(red: 0.631, green: 0.086, blue: 0.8))
                        .cornerRadius(45)
                }
            }
            .padding()
            }
            .frame(width:330)
            .padding(.top)
        }
        .cornerRadius(10)
        .padding()
    }
}

