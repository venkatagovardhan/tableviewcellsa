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
        
        headerLabel.text = cellItem.title
        textField.text = cellItem.fieldValue
        
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
    
    @IBAction func textDidChanged() {
        guard let cellItem = cellItem else { return }
        cellItem.textChangeCallback?(textField.text, cellItem)
    }

}

extension FormCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let cellItem = cellItem else { return true }
        let canEdit = cellItem.canEdit()
        canEdit ? () : cellItem.tapCallback?(cellItem)
        return canEdit
    }
    
}
