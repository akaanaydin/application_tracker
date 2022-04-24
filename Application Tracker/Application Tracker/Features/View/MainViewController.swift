//
//  MainViewController.swift
//  Application Tracker
//
//  Created by Arslan Kaan AYDIN on 19.04.2022.
//

import UIKit
import CoreData
import SnapKit

class MainViewController: UIViewController {
    
    private let interviewButton: UIButton = UIButton()
    private let rejectButton: UIButton = UIButton()
    private let addButton: UIButton = UIButton()
    private let secondView: UIView = UIView()
    private let label: UILabel = UILabel()
    let tableView: UITableView = UITableView()
    var companyArray = [String]()
    var jobTitleArray = [String]()
    var locationArray = [String]()
    var jobTypeArray = [String]()
    var dateArray = [Date]()
    var notesArray = [String]()
    var idArray = [UUID]()
    var interviewCountArray = [String]()
    var rejectCountArray = [String]()
    let addVC = AddViewController()
    var interviewCounter: Int = Int()
    var rejectCounter: Int = Int()
    
    //    lazy var viewModel: IInterviewTrackerViewModel = InterviewTrackerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        addSubviews()
        drawDesign()
        makeInterviewButton()
        makeRejectButton()
        makeAddButton()
        makeSecondView()
        makeLabel()
        makeTableView()
        fetchDatas()
    }
    
    func addSubviews() {
        view.addSubview(secondView)
        view.addSubview(label)
        view.addSubview(interviewButton)
        view.addSubview(rejectButton)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    func drawDesign() {
        view.backgroundColor = .systemGray6
        secondView.backgroundColor = .systemGray5
        secondView.layer.cornerRadius = 30
        tableView.backgroundColor = .systemGray5
        tableView.separatorColor = .systemGray5
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        label.text = "Interview Tracker"
        label.font = .systemFont(ofSize: 40)
        interviewButton.backgroundColor = .systemGreen
        interviewButton.layer.cornerRadius = 20
        interviewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 55)
        rejectButton.backgroundColor = .systemRed
        rejectButton.layer.cornerRadius = 20
        rejectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 55)
        addButton.layer.cornerRadius = 30
        addButton.backgroundColor = .systemBlue
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        if idArray.isEmpty {
            interviewButton.setTitle("0", for: .normal)
        }
        if rejectCountArray.isEmpty {
            rejectButton.setTitle("0", for: .normal)
        }
    }
    
    @objc func addButtonClicked(sender: UIButton!) {
        present(addVC, animated: true, completion: nil)
    }
    
    //    VIEW MODELE TASINACAK
    @objc func fetchDatas() {
        idArray.removeAll(keepingCapacity: true)
        companyArray.removeAll(keepingCapacity: true)
        jobTitleArray.removeAll(keepingCapacity: true)
        jobTypeArray.removeAll(keepingCapacity: true)
        locationArray.removeAll(keepingCapacity: true)
        dateArray.removeAll(keepingCapacity: true)
        notesArray.removeAll(keepingCapacity: true)
        rejectCountArray.removeAll(keepingCapacity: true)
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddJob")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                
                if let rejectCount = result.value(forKey: "rejectCounter") as? String {
                    rejectCountArray.append(rejectCount)
                    rejectButton.setTitle("\(rejectCountArray.count)", for: .normal)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    idArray.append(id)
                    interviewButton.setTitle("\(idArray.count)", for: .normal)
                }
                if let companyName = result.value(forKey: "companyName") as? String {
                    companyArray.append(companyName)
                }
                
                if let jobTitle = result.value(forKey: "jobTitle") as? String {
                    jobTitleArray.append(jobTitle)
                }
                
                if let jobType = result.value(forKey: "jobType") as? String {
                    jobTypeArray.append(jobType)
                }
                
                if let location = result.value(forKey: "location") as? String {
                    locationArray.append(location)
                }
                
                if let date = result.value(forKey: "date") as? Date {
                    dateArray.append(date)
                }
                
                if let notes = result.value(forKey: "notes") as? String {
                    notesArray.append(notes)
                }
                
                tableView.reloadData()
            }
        }catch {
            print(error)
        }
        
    }
    //
    
}


extension MainViewController {
    private func makeInterviewButton() {
        interviewButton.snp.makeConstraints { make in
            make.centerY.equalTo(secondView.snp.top)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(120)
            make.width.equalToSuperview().multipliedBy(0.46)
        }
    }
    
    private func makeRejectButton() {
        rejectButton.snp.makeConstraints { make in
            make.centerY.equalTo(secondView.snp.top)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(interviewButton)
            make.width.equalToSuperview().multipliedBy(0.46)
        }
    }
    
    private func makeAddButton() {
        addButton.snp.makeConstraints { make in
            make.right.equalTo(rejectButton)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(60)
        }
    }
    
    private func makeSecondView() {
        secondView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.8)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(30)
        }
    }
    
    private func makeLabel() {
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(interviewButton.snp.top)
        }
    }
    
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(interviewButton.snp.bottom).offset(20)
            make.left.equalTo(interviewButton)
            make.right.equalTo(rejectButton)
            make.bottom.equalTo(addButton.snp.top)
        }
    }
}

// Useless
extension MainViewController {
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchDatas), name: NSNotification.Name("NewData"), object: nil)
        print(companyArray)
        print(idArray)
        print(jobTypeArray)
        print(jobTitleArray)
        print(locationArray)
        print(dateArray)
        print(notesArray)
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = companyArray[indexPath.row]
        cell.backgroundColor = .systemGray5
        return cell
    }
    
    //    VIEW MODELE TASINACAK
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddJob")
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "AddJob", into: context)
        let idString = idArray[indexPath.row].uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        
        saveData.setValue("1", forKey: "rejectCounter")
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let _ = result.value(forKey: "id") as? UUID {
                    context.delete(result)
                    idArray.remove(at: indexPath.row)
                    interviewButton.setTitle("\(idArray.count)", for: .normal)
                    companyArray.remove(at: indexPath.row)
                    locationArray.remove(at: indexPath.row)
                    jobTypeArray.remove(at: indexPath.row)
                    jobTitleArray.remove(at: indexPath.row)
                    dateArray.remove(at: indexPath.row)
                    notesArray.remove(at: indexPath.row)
                    tableView.reloadData()
                    do {
                        try context.save()
                        fetchDatas()
                    }catch {
                        print(error)
                    }
                }
            }
        }catch {
            print(error)
        }
    }
    //
    
    
}

