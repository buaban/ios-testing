//
//  TableViewCellTransaction1.swift
//  salary-manager
//
//  Created by Chuentiwa Chuencharoensuk on 10/14/16.
//  Copyright © 2016 Buataitom. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var TransactionLabel: UILabel!
   
    
    @IBOutlet weak var AmountLabel: UILabel!
    
    var cellDelegate: TransactionCellProtocol?
    
    
    @IBAction func buttonTap(sender: AnyObject) {
        if let delegate = cellDelegate {
            delegate.cellTapped(cell: self)
        }
    }
    
    
}
