//
//  FormCell.swift
//  test-app
//
//  Created by Mahesh Dhumpeti on 08/11/21.
//

import UIKit

class FormCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var cellItem: FormCellItem? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        guard let cellItem = cellItem else { return }
        
        headerLabel.text = cellItem.header
        textField.text = cellItem.fieldText
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension FormCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let cellItem = cellItem else { return true }
        cellItem.tapCallback?(cellItem)
        return cellItem.type == .textfield
    }
    
}
