//
//  SuccessViewController.swift
//  success-demo
//
//  Created by Mahesh Dhumpeti on 04/01/22.
//

import UIKit

struct CardVO {
    let nameOnCard: String
    let last4DigitsOfAcctNo: String
    let fullCardName: String
    let isPrimary: Bool
}

class SuccessViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    private let viewModel = SuccessViewModel()
    
    func setCardsData(_ cards: [CardVO]) {
        viewModel.cards = cards
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        headerLabel.text = "Your card is ready to use."
        messageLabel.text = "The following card has been activated."
        
        continueBtn.setTitle("Continue", for: .normal)
        continueBtn.backgroundColor = .blue
        continueBtn.setTitleColor(.white, for: .normal)
        
        tableView.separatorStyle = .none
    }
    
    @IBAction func continueBtnTapped() {
        print("Continue tapped")
    }
    
    @IBAction func closeBtnTapped() {
        dismiss(animated: true, completion: nil)
    }

}

extension SuccessViewController:
    UITableViewDataSource,
    UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.cellId) as? CardCell
        else { return UITableViewCell() }
        cell.enabledCorners = viewModel.getCorners(for: indexPath.row)
        cell.card = viewModel.getCard(for: indexPath)
        return cell
    }
    
}
