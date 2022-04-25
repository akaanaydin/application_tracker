//
//  InterviewCell.swift
//  Application Tracker
//
//  Created by Arslan Kaan AYDIN on 25.04.2022.
//

import UIKit
import SnapKit

class InterviewCell: UITableViewCell {
    
    private let companyNameLabel: UILabel = UILabel()
    private let jobTitleLabel: UILabel = UILabel()
    private let locationLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let jobTypeLabel: UILabel = UILabel()
    private let notesLabel: UILabel = UILabel()

    enum Identifier: String {
            case custom = "AKA"
        }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews()
        makeCompanyLabel()
    }
    
    private func addSubviews() {
        addSubview(companyNameLabel)
    }
}

extension InterviewCell {
    private func makeCompanyLabel() {
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
        }
    }
}
