//
//  FormViewModel.swift
//  test-app
//
//  Created by Mahesh Dhumpeti on 08/11/21.
//

import UIKit

enum FormFieldType {
    case dropdown, textfield
}

enum FormType {
    case sourceOfIncome, residenceType, amountRequested
}

class FormCellItem {
    var idx: Int = -1
    var cellId: String = ""
    var type: FormFieldType = .textfield
    var header: String = ""
    var fieldText: String?
    var items: [String] = []
    var tapCallback: ((FormCellItem) -> Void)?
}

protocol FormViewModelDelegate: class {
    func didTapOnCellItem(_ item: FormCellItem)
}

class FormViewModel {
    
    private var cellItems: [FormCellItem] = []
    private var response: JSONResponse?
    private var currentIndex: Int = 0
    
    typealias Header = (title: String, type: FormType, fieldType: FormFieldType)
    private var headers: [Header] = [("What is your source of income?", .sourceOfIncome, .dropdown),
                                     ("What is your residence status?", .residenceType, .dropdown),
                                     ("Additional credit line amount requested?", .amountRequested, .textfield)]
    
    weak var delegate: FormViewModelDelegate?
    
    init() {
        loadData()
    }
    
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
        addItem()
    }
    
    private func addItem() {
        guard currentIndex < headers.count else { return }
        let header = headers[currentIndex]

        let item = FormCellItem()
        item.idx = currentIndex
        item.cellId = "FormCell"
        item.type = header.fieldType
        item.header = header.title
        item.fieldText = nil
        item.tapCallback = formCellTapped

        switch header.type {
        case .sourceOfIncome:
            item.items = response?.sourceOfIncomes.compactMap { $0.description } ?? []
        case .residenceType:
            item.items = response?.sourceOfIncomes.compactMap { $0.description } ?? []
        case .amountRequested:
            item.items = response?.sourceOfIncomes.compactMap { $0.description } ?? []
        }        
        cellItems.append(item)
    }
    
    private func formCellTapped(at cellItem: FormCellItem) {
        if cellItem.idx == currentIndex {
            currentIndex += 1
            addItem()
            delegate?.didTapOnCellItem(cellItem)
        }
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
