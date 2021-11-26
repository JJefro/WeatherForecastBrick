//
//  CoreDataManager.swift
//  WeatherForecastBrick
//
//  Created by Jevgenijs Jefrosinins on 26/11/2021.
//

import UIKit
import CoreData

class CoreDataManager {

    // Reference to managed object context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var items: [Cities] = []

    func loadData() {
        let request: NSFetchRequest<Cities> = Cities.fetchRequest()
        do {
            let result = try context.fetch(request)
            items = result
        } catch {
            fatalError("Error in loading core data item")
        }
    }

    func saveData(city: String?) {
        if city != nil {
            let entity = NSEntityDescription.entity(forEntityName: "Cities", in: self.context)
            let shop = NSManagedObject(entity: entity!, insertInto: self.context)
            shop.setValue(city, forKey: "city")
        }
        do {
            try self.context.save()
        } catch {
            fatalError("Error in saving in core data item")
        }
        loadData()
    }

    func deleteData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
            saveData(city: nil)
        } catch let err {
            print(err.localizedDescription)
        }
    }
}
