//
//  FirstViewController.swift
//  salary-manager
//
//  Created by Chuentiwa Chuencharoensuk on 10/11/16.
//  Copyright © 2016 Buataitom. All rights reserved.
//

import UIKit
import GRDB


class TransactionsTableViewController_obs: UITableViewController {
    
    var cellDataArray = [cellData]
    var selectedItemId: Int = 0
    
    override func viewDidLoad() {
        do {
            let dbPath = Bundle.main.path(forResource: "salary-manager-data", ofType: "db")
            let dbQueue = try DatabaseQueue(path: dbPath!)
            try dbQueue.inDatabase { db in
                for row in Row.fetch(db, "SELECT * FROM transactions") {
                    let title: String = row.value(named: "title")
                    let amount: Double = row.value(named: "amount")
                    let id : Int = row.value(named: "id")
                    let cell = cellData(transactionName: title, amount: amount, id: id)
                    cellDataArray.append(cell)
                }
            }

        } catch {
            print("Error occurred \(error)")
        }
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TransactionCell", owner: self, options: nil)?.first as! TransactionCell
        
        let formattedAmount = NumberFormatter.localizedString(from: NSNumber(value: cellDataArray[indexPath.row].amount.rounded()), number: NumberFormatter.Style.decimal)

        cell.AmountLabel.text = String(formattedAmount)
        cell.AmountLabel.textAlignment = NSTextAlignment.right
        cell.AmountLabel.accessibilityValue = String(formattedAmount)
        cell.TransactionLabel.text = cellDataArray[indexPath.row].transactionName
        //cell.AmountLabel = cellDataArray[indexPath.row].amount
        
        return cell
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueTest") {
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            let detailVC = segue.destination as! TransactionDetailsViewController;
            detailVC.transactionId =
        }
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        storyboard
        let destination = storyboard.instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
        destination.transactionId = cellDataArray[indexPath.row].id
        //self.present(destination, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
        
    }

}

