//
//  NewDataView.swift
//  HabitTracker
//
//  Created by Стас Жингель on 03.08.2021.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10.0) {
                Text("Название")
                TextField("Бегать по утрам, спать 8 часов и т.п.", text: $homeData.toDo)
                Text("Цвет")
                HStack {
                    ForEach(0..<5) { current in
                            Button(action: {
                                homeData.colorIndex = Double(current)
                            }, label: {
                                Image(systemName: homeData.colorIndex == Double(current) ? "largecircle.fill.circle":"circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(homeData.colorArray[current])
                            })
                            
                            }
                }
                Text("Время")
                DatePicker("", selection: $homeData.time, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
//   не могу задействовать удалить                     homeData.delete(context: context, item: <#T##Task#>)
                    }) {
                        Text("Удалить привычку")
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
            } .padding()

                .toolbar(content: {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {homeData.writeData(context: context)}) {
                            Text("Сохранить")
                        }
                        .disabled(homeData.toDo == "" ? true : false)
                        .opacity(homeData.toDo == "" ? 0.5 : 1)
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {homeData.isNewData.toggle()}) {
                            Text("Отменить")
                        }
                    }
                })
                .navigationBarTitle("Создать", displayMode: .inline)
        }
        .accentColor(Color(red: 0.631, green: 0.086, blue: 0.8))
    }
    
}

