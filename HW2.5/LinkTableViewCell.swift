//
//  LinkTableViewCell.swift
//  HW2.5
//
//  Created by Арслан on 24.01.2022.
//

import UIKit
import SnapKit

class LinkTableViewCell: UITableViewCell {
    
    private let lineView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let linkImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Group")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: LinkModel) {
        self.titleLabel.text = model.title
    }
    
    func setUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(linkImageView)
        linkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(18)
        }
        
        linkImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanleIv)))
    }
    
    
    @objc func hanleIv() {
        print("DEBUG: Hello ")
    }
}
