//
//  MainViewController.swift
//  Application Tracker
//
//  Created by Arslan Kaan AYDIN on 19.04.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let interviewButton = UIButton()
    private let rejectButton: UIButton = UIButton()
    private let addButton: UIButton = UIButton()
    private let secondView: UIView = UIView()
    private let label: UILabel = UILabel()

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
    }
    
    func addSubviews() {
        view.addSubview(secondView)
        view.addSubview(label)
        view.addSubview(interviewButton)
        view.addSubview(rejectButton)
        view.addSubview(addButton)
    }

    func drawDesign() {
        view.backgroundColor = .systemGray6
        secondView.backgroundColor = .systemGray5
        secondView.layer.cornerRadius = 30
        label.text = "Application Tracker"
        label.font = .systemFont(ofSize: 40)
        interviewButton.setTitle("1", for: .normal)
        interviewButton.backgroundColor = .systemGreen
        interviewButton.layer.cornerRadius = 20
        interviewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 55)
        rejectButton.setTitle("0", for: .normal)
        rejectButton.backgroundColor = .systemRed
        rejectButton.layer.cornerRadius = 20
        rejectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 55)
        addButton.layer.cornerRadius = 30
        addButton.backgroundColor = .systemBlue
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
    }
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
}
