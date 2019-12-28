//
//  CellViewModel.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 5/12/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

protocol CellViewModel {
    associatedtype CellType : UIView
    func setup(cell: CellType)
}

struct AddViewCellModel : CellViewModel {
    func setup(cell: AddViewCellModel) {
        <#code#>
    }
}
