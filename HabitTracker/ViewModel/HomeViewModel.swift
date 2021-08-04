//
//  HomeViewModel.swift
//  HabitTracker
//
//  Created by Стас Жингель on 03.08.2021.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var toDo = ""
    @Published var time = Date()
    @Published var score = 0.00
    @Published var check = false
    @Published var colorIndex = 0.00
    @Published var isNewData = false
    @Published var updateItem: Task!
    @Published var isEdit = false
    @Published var history =  Date()
     let colorArray = [Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)),Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), Color(#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))]
    
    func writeData(context: NSManagedObjectContext) {
        
        //updating
        if updateItem != nil {
            updateItem.colorIndex = colorIndex
            updateItem.toDo = toDo
            updateItem.time = time
            try! context.save()
            updateItem = nil
            isNewData.toggle()
        }
        
        else {
            let newTask = Task(context: context)
            newTask.time = time
            newTask.toDo = toDo
            newTask.colorIndex = colorIndex
            
            do {
                try context.save()
                isNewData.toggle()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    func EditCheck(item: Task) {
       updateItem = item
        score = item.score
        check = item.check
    }
    func EditItem(item: Task) {
       updateItem = item
        colorIndex = item.colorIndex
        toDo = item.toDo!
        time = item.time!
        isNewData.toggle()
    }
    func delete(context: NSManagedObjectContext, item: Task)  {
        context.delete(item)
        try! context.save()
    }
    func writeHistory(context: NSManagedObjectContext) {
        let newHistory = History(context:context)
        newHistory.history = history
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
