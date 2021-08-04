//
//  Home.swift
//  HabitTracker
//
//  Created by Стас Жингель on 03.08.2021.
//

import SwiftUI
import CoreData

struct Home: View {
    @State var flag = false
    @Environment(\.presentationMode) var presentationMode
    var value: Float {
    let checkedHabitsCount = resuts.filter { ctask in
        ctask.check
    }.count
    return Float(checkedHabitsCount) / Float(resuts.count)
}
    @StateObject var homeData = HomeViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "time", ascending: true)], animation: .spring()) var resuts: FetchedResults<Task>
    @FetchRequest(entity: History.entity(), sortDescriptors: [NSSortDescriptor(key: "history", ascending: true)], animation: .spring()) var Historyresuts: FetchedResults<History>
    var body: some View { 
        TabView {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        habitBar(value: value)
                        ForEach(resuts) { task in
                            NavigationLink(destination:
                                            VStack {
                                                
                                            
                                                    
                                              
                                                Button(action: {
                                                    homeData.delete(context: context, item: task)
//                                                    context.delete(task)
//                                                    try! context.save()
                                                }, label: {
                                                    Text("Удалить")
                                                })
                                            }
                                            .navigationBarTitle(task.toDo!, displayMode: .inline)
                                            .toolbar(content: {
                                                ToolbarItem(placement: .automatic) {
                                                    Button(action: {
                                                        homeData.EditItem(item: task)
                                                    }) {
                                                        Text("Править")
                                                    }
                                                }
                                        }))
                            {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.white)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(task.toDo ?? "")
                                                .font(.headline)
                                            Text("Каждый день в \(task.time ?? Date(), style: .time)")
                                                .font(.caption)
                                                .foregroundColor(.gray) // MARK: gray2 ??
                                                .padding(.bottom)
                                            Spacer()
                                            Text("Счётчик: \(Int(task.score))")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                                .padding(.top)
                                        }
                                        Spacer()
                                        Button(action: {task.check.toggle()
                                            if task.check {
                                                task.score += 1.00
                                                homeData.EditCheck(item: task)
                                                
                                            }
                                        }) {
                                            Image(systemName: task.check ? "checkmark.circle.fill" : "circle")
                                                .font(.largeTitle)
                                        }
                                    }
                                    .padding()
                                }
                                .foregroundColor(homeData.colorArray[Int(task.colorIndex)])
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            
                        }
                    }
                }
                .background(Color(red: 0.949, green: 0.949, blue: 0.969))
                .navigationTitle("Сегодня")
                .toolbar {
                    Button(action: {
                        homeData.isNewData.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 0.631, green: 0.086, blue: 0.8))
                    }
                }
            }
            .tabItem {
                Image(systemName: "rectangle.grid.1x2.fill")
                Text("Привычки")
            }
            Text("information")
            .tabItem {
                Image(systemName: "info.circle.fill")
                Text("Информация")
            }
        }
        .fullScreenCover(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }
}
