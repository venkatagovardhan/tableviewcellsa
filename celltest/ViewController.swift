//
//  ViewController.swift
//  celltest
//
//  Created by Mahesh Dhumpeti on 01/08/22.
//

import UIKit

class StatusCell: UITableViewCell {
        
    static let cellId = String(describing: StatusCell.self)
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
}

typealias Info = (title: String, subTitle: String)

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableData: [Info] = [("sdvhjsdvjhsvjc sdvhjsdvjhsvjcjsdvjhsvjc", "sdvhjsdvjhsvjc"),
                             ("sdvhjsdvjhsvjc", "sdvhjsdvjhsvjc sdvhjsdvjhsvjc sdvhjsdvjhsvjc"),
                             ("sdvhjsdvjhsvjc sdvhjsdvjhsvjcsdvhjsdvjhsvjc sdvhjsdvjhsvjc", "sdvhjsdvjhsvjc sdvhjsdvjhsvjcsdvhjsdvjhsvjcsdvhjsdvjhsvjcsdvhjsdvjhsvjcsdvhjsdvjhsvjc")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
        tableView.reloadData()
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatusCell.cellId) as? StatusCell
        else { return UITableViewCell() }
        
        cell.containerView.backgroundColor = .lightGray
        
        let info = tableData[indexPath.row]
        
        cell.titleLabel.text = info.title
        cell.subTitleLabel.text = info.subTitle
        
        if tableData.count == 1 {
            cell.containerView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 8)
        } else if indexPath.row == 0 {
            cell.containerView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 8)
        } else if indexPath.row == tableData.count - 1 {
            cell.containerView.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 8)
        } else {
            cell.containerView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 0)
        }
        
        return cell
    }
    
}

extension UIView {
    
   func roundCorners(corners: CACornerMask, radius: CGFloat) {
       layer.cornerRadius = radius
       layer.maskedCorners = corners
    }
    
}

