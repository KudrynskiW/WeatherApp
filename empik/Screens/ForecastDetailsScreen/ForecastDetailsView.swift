//
//  ForecastDetailsView.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import UIKit

class ForecastDetailsView: UIViewController {
    let viewModel: ForecastDetailsViewModelProtocol?
   
    init(viewModel: ForecastDetailsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewModel = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .yellow
    }
}
