//
//  UserDefaultProtocol.swift
//  salary-manager
//
//  Created by Chuentiwa Chuencharoensuk on 12/16/16.
//  Copyright © 2016 Buataitom. All rights reserved.
//

import Foundation

protocol UserDefaultProtocol: UserDefaults {
    func cellTapped(cell: TransactionCell)
}
