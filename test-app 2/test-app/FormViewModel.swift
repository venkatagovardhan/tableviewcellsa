//
//  FormViewModel.swift
//  test-app
//
//  Created by Mahesh Dhumpeti on 08/11/21.
//

import UIKit

enum FormCellType {
    case sourceOfIncome, occupation, residenceStatus, monthlyHousingPayment, amountRequested, none
    
    var title: String {
        switch self {
        case .sourceOfIncome: return "What is your source of income?"
        case .occupation: return "What is your occupation?"
        case .residenceStatus: return "What is your residence status?"
        case .monthlyHousingPayment: return "What is your monthly housing payment?"
        case .amountRequested: return "Additional credit line amount requested?"
        default: return ""
        }
    }
    
    var description: String {
        return ""
    }
    
}

class FormCellItem {
    var cellId: String = ""
    var title: String = ""
    var description: String = ""
    var fieldValue: String?
    var items: [String] = []
    var cellType: FormCellType = .none
    var tapCallback: ((FormCellItem) -> Void)?
    var textChangeCallback: ((String?, FormCellItem) -> Void)?
    
    func canEdit() -> Bool {
        switch cellType {
        case .sourceOfIncome: return false
        case .occupation: return false
        case .residenceStatus: return false
        default: return true
        }
    }
    
    var nextCellType: FormCellType {
        switch cellType {
        case .sourceOfIncome: return .occupation
        case .residenceStatus: return .monthlyHousingPayment
        default: return .none
        }
    }
}

protocol FormViewModelDelegate: AnyObject {
    func reloadData()
}

class FormViewModel {
    
    private var cellItems: [FormCellItem] = []
    private var response: JSONResponse?
    private var entries: [FormCellType: String] = [:]

    weak var delegate: FormViewModelDelegate?
        
    init() { loadData() }
    
    private func readMockFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "mock", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func loadData() {
        guard let jsonData = readMockFile() else { return }
        response = try? JSONDecoder().decode(JSONResponse.self, from: jsonData)
        cellItems = loadDefaultItems()
    }
    
    private func loadDefaultItems() -> [FormCellItem] {
        var cellItems: [FormCellItem] = []
        
        let items = response?.sourceOfIncomes.compactMap { $0.description } ?? []
        cellItems.append(createItem(cellId: "FormCell", type: .sourceOfIncome, items: items))
        cellItems.append(createItem(cellId: "FormCell", type: .residenceStatus, items: ["abc", "xyz"]))
        cellItems.append(createItem(cellId: "FormCell", type: .amountRequested))
        
        return cellItems
    }
    
    private func createItem(cellId: String,
                            type: FormCellType,
                            items: [String] = []) -> FormCellItem {
        let item = FormCellItem()
        item.cellId = cellId
        item.title = type.title
        item.description = type.description
        item.fieldValue = entries[type]
        item.cellType = type
        item.tapCallback = formCellTapped
        item.textChangeCallback = textChanged
        item.items = items
        return item
    }
    
    private func formCellTapped(at cellItem: FormCellItem) {
        guard let index = cellItems.firstIndex(where: { $0.cellType == cellItem.cellType }),
              !cellItems.contains(where: { $0.cellType == cellItem.nextCellType }),
              cellItem.nextCellType != .none else { return }
        
        // Insert item at next index of current item
        let nextIndex = index + 1
        let newItem = createItem(cellId: "FormCell", type: cellItem.nextCellType, items: ["123", "456"])
        cellItems.insert(newItem, at: nextIndex)
        delegate?.reloadData()
    }
    
    private func textChanged(_ text: String?, cellItem: FormCellItem) {
        cellItem.fieldValue = text
        entries[cellItem.cellType] = text
    }
    
}

extension FormViewModel {
    
    func numberOfRows(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cellItem = cellItems[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellId) as? FormCell {
            cell.cellItem = cellItem
            return cell
        }
        return UITableViewCell()
    }
    
}
