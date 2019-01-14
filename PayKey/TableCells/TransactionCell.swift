//
//  TransactionCell.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblOriginalAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureTransaction(transaction: Transaction) {
        let multiplier = DataManager.shared.getConversionValue(to: desiredCurrency, from: transaction.currency ?? "")
        self.lblAmount.text = (multiplier != 0) ? "\((transaction.amountValue * multiplier).rounded(toPlaces: 2)) GBP" : "No Conversion Available"
        self.lblOriginalAmount.text = transaction.amount
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
