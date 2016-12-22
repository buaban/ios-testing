//
//  TransactionDetailsViewController.swift
//  salary-manager
//
//  Created by Chuentiwa Chuencharoensuk on 12/14/16.
//  Copyright © 2016 Buataitom. All rights reserved.
//

import UIKit
import GRDB

class TransactionDetailsViewController : UIViewController
{
    var transactionId: Int = 0

    @IBOutlet weak var transactionName: UILabel!
    
    @IBOutlet weak var transactionAmount: UILabel!
    
    @IBOutlet weak var transactionRemark: UILabel!
    
    override func viewDidLoad() {
        do {
            let dbPath = Bundle.main.path(forResource: "salary-manager-data", ofType: "db")
            let dbQueue = try DatabaseQueue(path: dbPath!)
            try dbQueue.inDatabase { db in
                for row in Row.fetch(db, "SELECT * FROM transactions WHERE id=\(transactionId)") {
                    let title: String = row.value(named: "title")
                    let amount: Double = row.value(named: "amount")
                    //let id : Int = row.value(named: "id")
                    let remark : String = row.value(named: "remark")
                    
                    transactionName.text = title
                    
                    let formattedAmount = NumberFormatter.localizedString(from: NSNumber(value: amount.rounded()), number: NumberFormatter.Style.decimal)
                    
                    transactionAmount.text = String(formattedAmount)
                    transactionAmount.textAlignment = NSTextAlignment.right
                    
                    transactionRemark.text = remark
                    
                }
            }
            
        } catch {
            print("Error occurred \(error)")
        }
    }
}
