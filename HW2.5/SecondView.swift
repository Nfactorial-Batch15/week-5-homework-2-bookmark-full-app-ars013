//
//  SecondView.swift
//  HW2.5
//
//  Created by Арслан on 24.01.2022.
//

import UIKit
import SnapKit

class SecondView: UIViewController {
    
    private var links: [LinkModel] = Storage.linkModels {
        // более менее реактивный U
        didSet {
            if links.count > 0 {
                checkLinks()
            }
            
            if links.count == 0 {
                checkLinks()
            }
        }
    }
    
    private func checkLinks() {
        if links.isEmpty {
            tableView.isHidden = true
            label2.isHidden = false
        } else {
            tableView.isHidden = false
            label2.isHidden = true
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Bookmark App"
        label.textColor = .black
        label.frame = CGRect(x: 130, y: 56, width: 130, height: 22)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Save your first \n     bookmark"
        label.textColor = .black
        label.frame = CGRect(x: 75, y: 366, width: 358, height: 92)
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()

    var but: UIButton = {
        let but = UIButton(frame: CGRect(x: 16, y: 710, width: 350, height: 58))
        but.backgroundColor = .black
        but.setTitle("Add bookmark", for: .normal)
        but.setTitleColor(.white, for: .normal)
        but.layer.cornerRadius = 16


        return but
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLinks()
        
        view.backgroundColor = .white
        
        but.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        view.addSubview(label)

        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "LinkTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(42)
        }
        
        
        view.addSubview(label2)

        view.addSubview(but)
    }
    
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Change", message: .none, preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Bookmark title"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alert.addTextField { field in
            field.placeholder = "Bookmark link"
            field.returnKeyType = .continue
            field.keyboardType = .URL
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("dismissed")
            
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {_ in
            guard let fields = alert.textFields, fields.count == 2 else {
                return
            }
            let titleField = fields[0]
            let linkField = fields[1]
            guard let title = titleField.text, !title.isEmpty,
                  let link = linkField.text, !link.isEmpty else {
                      print("Invalid entries")
                      return
                  }
            
            print("Title: \(title)")
            print("Link: \(link)")
            
            self.addNewLinkToArray(title: title, link: link)
        }))
        
        present(alert, animated: true)
        
    }
    
    private func addNewLinkToArray(title: String, link: String) {
        self.links.append(LinkModel(title: title, link: link))
        Storage.linkModels.append(LinkModel(title: title, link: link))
        self.tableView.reloadData()
    }
    
    

}

extension SecondView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: indexPath) as? LinkTableViewCell else { return UITableViewCell() }
        cell.configure(model: links[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
