//
//  CoreDataViewModel.swift
//  Application Tracker
//
//  Created by Arslan Kaan AYDIN on 24.04.2022.
//

import Foundation
import UIKit
import CoreData

protocol IInterviewTrackerViewModel {
    func fetchDatas()
    func saveDatas()
}

final class InterviewTrackerViewModel: IInterviewTrackerViewModel {
    
    
    let addVC = AddViewController()
    let mainVC = MainViewController()
    
    func saveDatas() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
              let context = appDelegate.persistentContainer.viewContext
              let saveData = NSEntityDescription.insertNewObject(forEntityName: "AddJob", into: context)
              
        
                saveData.setValue(UUID(), forKey: "id")
                saveData.setValue(addVC.companyName.text!, forKey: "companyName")
                saveData.setValue(addVC.jobTitle.text!, forKey: "jobTitle")
                saveData.setValue(addVC.location.text!, forKey: "location")
                saveData.setValue(addVC.jobType.text!, forKey: "jobType")
                saveData.setValue(addVC.notes.text!, forKey: "notes")
                saveData.setValue(addVC.interviewDate.date, forKey: "date")
        
              do {
                  try context.save()
                  print("Success")
              }catch {
                  print(error)
              }
    }
    


    func fetchDatas() {
        mainVC.idArray.removeAll(keepingCapacity: true)
        mainVC.companyArray.removeAll(keepingCapacity: true)
        mainVC.jobTitleArray.removeAll(keepingCapacity: true)
        mainVC.jobTypeArray.removeAll(keepingCapacity: true)
        mainVC.locationArray.removeAll(keepingCapacity: true)
        mainVC.dateArray.removeAll(keepingCapacity: true)
        mainVC.notesArray.removeAll(keepingCapacity: true)

                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddJob")
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let results = try context.fetch(fetchRequest)
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            mainVC.idArray.append(id)
                        }
                        if let companyName = result.value(forKey: "companyName") as? String {
                            mainVC.companyArray.append(companyName)
                        }
                        
                        if let jobTitle = result.value(forKey: "jobTitle") as? String {
                            mainVC.jobTitleArray.append(jobTitle)
                        }
                        
                        if let jobType = result.value(forKey: "jobType") as? String {
                            mainVC.jobTypeArray.append(jobType)
                        }
                        
                        if let location = result.value(forKey: "location") as? String {
                            mainVC.locationArray.append(location)
                        }
                        
                        if let date = result.value(forKey: "date") as? Date {
                            mainVC.dateArray.append(date)
                        }
                        
                        if let notes = result.value(forKey: "notes") as? String {
                            mainVC.notesArray.append(notes)
                        }
                       
                        mainVC.tableView.reloadData()
                    }
                }catch {
                    print(error)
                }
                
    }
}


