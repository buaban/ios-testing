//
//  FirstViewController.swift
//  salary-manager
//
//  Created by Chuentiwa Chuencharoensuk on 10/11/16.
//  Copyright © 2016 Buataitom. All rights reserved.
//

import UIKit
import GRDB

struct cellData {
    let transactionName : String!
    let amount : Double!
    let id : Int!
}

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cellDataArray = [cellData]()
    var selectedItemId: Int = 0    
    let pickerData: [String:Double] = ["THB":1, "USD":0.027941, "EUR":0.02556, "HKD":0.2168, "JPY":3.2906, "SGD":0.040184]
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.register(defaults: ["selected_ccy_row" : 0])

        picker.selectRow(getDefaultCcyRow(), inComponent: 0, animated: true)
        
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
    
    func getDefaultCcyRow() -> Int {
        let selected_item: Int = UserDefaults.standard.value(forKey: "selected_ccy_row") as! Int
        
        return selected_item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return [String] (pickerData.keys)[row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return calculateCell(indexPath)
    }
    
    func calculateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TransactionCell", owner: self, options: nil)?.first as! TransactionCell
        
        let formattedAmount = covertToCurrency(number: cellDataArray[indexPath.row].amount,ccy: getSelectedCcy())
        
        //let formattedAmount = NumberFormatter.localizedString(from: NSNumber(value: cellDataArray[indexPath.row].amount.rounded()), number: NumberFormatter.Style.decimal)
        
        cell.AmountLabel.text = formattedAmount
        cell.AmountLabel.textAlignment = NSTextAlignment.right
        cell.AmountLabel.accessibilityValue = formattedAmount
        
        cell.TransactionLabel.text = cellDataArray[indexPath.row].transactionName
        cell.TransactionLabel.accessibilityValue = cellDataArray[indexPath.row].transactionName
        
        
        return cell
    }
    
    func covertToCurrency(number: Double, ccy: String) -> String {
        let fxRate: Double = pickerData[ccy]!
        let decimalPlaces: Int = (fxRate>=1) ? 0 : 2
        let convertedNumber = number * fxRate
        let formattedAmount: String = formatNumber(number: NSNumber(value: convertedNumber), decimalPlaces: decimalPlaces)
        
        
        return formattedAmount
    }
    
    func getSelectedCcy() -> String {
        let ind = self.picker.selectedRow(inComponent: 0)
        let title: String = pickerView(self.picker, titleForRow: ind, forComponent: 0)!
        
        return title
    }
    
    func formatNumber(number: NSNumber, decimalPlaces: Int) -> String {
        var result: String = ""
        
        let intFormatter = NumberFormatter()
        intFormatter.numberStyle = NumberFormatter.Style.decimal
        intFormatter.maximumFractionDigits = 0
        
        let doubleFormatter = NumberFormatter()
        doubleFormatter.numberStyle = NumberFormatter.Style.decimal
        doubleFormatter.maximumFractionDigits = 2
        doubleFormatter.minimumFractionDigits = 2
        
        
        if decimalPlaces == 0 {
            result = intFormatter.string(from: number)!
        }
        else {
            result = doubleFormatter.string(from: number)!
        }

        
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "TransactionDetailsViewController") as! TransactionDetailsViewController
        destination.transactionId = cellDataArray[indexPath.row].id
        //self.present(destination, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.setValue(row, forKey: "selected_ccy_row")
        self.tableView.reloadData()
    }
    
}

