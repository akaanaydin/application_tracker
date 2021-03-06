//
//  AddViewController.swift
//  Application Tracker
//
//  Created by Arslan Kaan AYDIN on 23.04.2022.
//

import UIKit
import CoreData
import SnapKit

class AddViewController: UIViewController {
        
    // MARK: - UI ELEMENTS
    let companyName: UITextField = UITextField()
    private let labelCompany: UILabel = UILabel()
    let jobTitle: UITextField = UITextField()
    private let labelJobTitle: UILabel = UILabel()
    let location: UITextField = UITextField()
    private let labelLocation: UILabel = UILabel()
    let jobType: UITextField = UITextField()
    private let labelJobType: UILabel = UILabel()
    let notes: UITextView = UITextView()
    private let labelNotes: UILabel = UILabel()
    let interviewDate: UIDatePicker = UIDatePicker()
    private let labelInterviewDate: UILabel = UILabel()
    private let saveButton: UIButton = UIButton()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - CONFIGURE FUNCTION
    func configure() {
        drawDesign()
        addSubviews()
        keyboardDismiss()
        makeSaveButton()
        makeLabelCompany()
        makeCompanyName()
        makeJobTitle()
        makeLabelJobTitle()
        makeLocation()
        makeLabelLocation()
        makeJobType()
        makeLabelJobType()
        makeInterviewDate()
        makeLabelInterviewDate()
        makeNotes()
        makeLabelNotes()
    }
    
    // MARK: - DESIGN FUNCTION
    func drawDesign() {
        
        // View
        view.backgroundColor = .white
        
        // Company
        labelCompany.text = "Company"
        labelCompany.font = .boldSystemFont(ofSize: 25)
        companyName.borderStyle = .roundedRect
        companyName.placeholder = "Company Name"
        
        //  Job Title
        labelJobTitle.text = "Job Title"
        labelJobTitle.font = .boldSystemFont(ofSize: 25)
        jobTitle.borderStyle = .roundedRect
        jobTitle.placeholder = "Job Title"
        
        // Job Type
        labelJobType.text = "Job Type"
        labelJobType.font = .boldSystemFont(ofSize: 25)
        jobType.borderStyle = .roundedRect
        jobType.placeholder = "Job Type"
        
        // Location
        labelLocation.text = "Location"
        labelLocation.font = .boldSystemFont(ofSize: 25)
        location.borderStyle = .roundedRect
        location.placeholder = "Location"
        
        // Interv??ew Date
        labelInterviewDate.text = "Interview Date"
        labelInterviewDate.font = .boldSystemFont(ofSize: 25)
        
        // Notes
        labelNotes.text = "Notes"
        labelNotes.font = .boldSystemFont(ofSize: 25)
        notes.font = .boldSystemFont(ofSize: 20)
        notes.layer.borderWidth = 1
        
        // Save Button
        saveButton.layer.cornerRadius = 30
        saveButton.backgroundColor = .systemBlue
        saveButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        saveButton.tintColor = .white
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - ADDSUBVIEW FUNCTION
    func addSubviews() {
        view.addSubview(companyName)
        view.addSubview(labelCompany)
        view.addSubview(jobTitle)
        view.addSubview(labelJobTitle)
        view.addSubview(jobType)
        view.addSubview(labelJobType)
        view.addSubview(location)
        view.addSubview(labelLocation)
        view.addSubview(notes)
        view.addSubview(labelNotes)
        view.addSubview(interviewDate)
        view.addSubview(labelInterviewDate)
        view.addSubview(saveButton)
    }
    
    // MARK: - KEYBOARD DISMISS FUNCTION FOR TOUCH ANYWHERE
    func keyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - SAVE BUTTON FUNCTION
    @objc func saveButtonClicked(sender: UIButton) {
        
        // MARK: CORE DATA SAVE DATAS
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "AddJob", into: context)
        
        // MARK: SAVE DATAS ACCORDING TO FORKEYS
        saveData.setValue(UUID(), forKey: "id")
        saveData.setValue(companyName.text!, forKey: "companyName")
        saveData.setValue(jobTitle.text!, forKey: "jobTitle")
        saveData.setValue(location.text!, forKey: "location")
        saveData.setValue(jobType.text!, forKey: "jobType")
        saveData.setValue(notes.text!, forKey: "notes")
        saveData.setValue(interviewDate.date, forKey: "date")
        
        do {
            try context.save()
            print("Success")
        }catch {
            print(error)
        }
        
        // MARK: NOTIFICATION SEND FOR OBSERVER AFTER SAVE DATAS
        NotificationCenter.default.post(name: .init(rawValue: "NewData"), object: nil)
        
        // MARK: DELETE TEXT FIELDS AFTER SAVE DATAS
        companyName.text = ""
        jobTitle.text = ""
        location.text = ""
        jobType.text = ""
        notes.text = ""
        
        // MARK: DISMISS VIEW AFTER CLICKED BUTTON
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - EXTENSIONS

// MARK: SNAPKIT CONFIGURES
extension AddViewController {
    
    private func makeSaveButton() {
        saveButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(60)
        }
    }
    
    private func makeLabelCompany() {
        labelCompany.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.centerY.equalTo(companyName)
        }
    }
    
    private func makeCompanyName() {
        companyName.snp.makeConstraints { make in
            make.top.equalTo(labelCompany)
            make.left.equalTo(labelCompany.snp.right)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    private func makeLabelJobTitle() {
        labelJobTitle.snp.makeConstraints { make in
            make.top.equalTo(labelCompany.snp.bottom).offset(20)
            make.left.equalTo(labelCompany)
            make.right.equalTo(labelCompany)
            make.centerY.equalTo(jobTitle)
        }
    }
    
    private func makeJobTitle() {
        jobTitle.snp.makeConstraints { make in
            make.top.equalTo(companyName.snp.bottom).offset(20)
            make.left.equalTo(companyName)
            make.right.equalTo(companyName)
        }
    }
    
    private func makeLabelLocation() {
        labelLocation.snp.makeConstraints { make in
            make.top.equalTo(labelJobTitle.snp.bottom).offset(20)
            make.left.equalTo(labelJobTitle)
            make.right.equalTo(labelJobTitle)
            make.centerY.equalTo(location)
        }
    }
    
    private func makeLocation() {
        location.snp.makeConstraints { make in
            make.top.equalTo(jobTitle.snp.bottom).offset(20)
            make.left.equalTo(jobTitle)
            make.right.equalTo(jobTitle)
        }
    }
    
    private func makeLabelJobType() {
        labelJobType.snp.makeConstraints { make in
            make.top.equalTo(labelLocation.snp.bottom).offset(20)
            make.left.equalTo(labelLocation)
            make.right.equalTo(labelLocation)
            make.centerY.equalTo(jobType)
        }
    }
    
    private func makeJobType() {
        jobType.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom).offset(20)
            make.left.equalTo(location)
            make.right.equalTo(location)
        }
    }
    
    private func makeLabelInterviewDate() {
        labelInterviewDate.snp.makeConstraints { make in
            make.top.equalTo(labelJobType.snp.bottom).offset(20)
            make.left.equalTo(labelJobType)
            make.right.equalTo(labelJobType)
            make.centerY.equalTo(interviewDate)
        }
    }
    
    private func makeInterviewDate() {
        interviewDate.snp.makeConstraints { make in
            make.top.equalTo(jobType.snp.bottom).offset(20)
            make.left.equalTo(jobType)
            make.right.equalTo(jobType)
        }
    }
    
    private func makeLabelNotes() {
        labelNotes.snp.makeConstraints { make in
            make.top.equalTo(labelInterviewDate.snp.bottom).offset(20)
            make.left.equalTo(labelInterviewDate)
            make.right.equalTo(labelInterviewDate)
        }
    }
    
    private func makeNotes() {
        notes.snp.makeConstraints { make in
            make.top.equalTo(labelNotes.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(saveButton.snp.top).offset(-20)
            
        }
    }
    
}
