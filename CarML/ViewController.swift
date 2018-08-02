//
//  ViewController.swift
//  CarML
//
//  Created by Sergio Ulloa on 1/8/18.
//  Copyright © 2018 Sergio Ulloa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let cars = Cars()
    
    // MARK: IBOutlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var segmentedControlModel: UISegmentedControl!
    @IBOutlet weak var switchExtras: UISwitch!
    @IBOutlet weak var labelKms: UILabel!
    @IBOutlet weak var sliderKms: UISlider!
    @IBOutlet weak var segmentedControlStatus: UISegmentedControl!
    @IBOutlet weak var labelPrice: UILabel!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stackView.setCustomSpacing(25, after: self.segmentedControlModel)
        self.stackView.setCustomSpacing(25, after: self.switchExtras)
        self.stackView.setCustomSpacing(25, after: self.sliderKms)
        self.stackView.setCustomSpacing(50, after: self.segmentedControlStatus)
        
        self.calculatePrice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    @IBAction func calculatePrice() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        let formattedKms = formatter.string(for: self.sliderKms.value) ?? "0"
        self.labelKms.text = "Kilometraje: \(formattedKms) km"
        
        if let prediction = try? cars.prediction(modelo: Double(self.segmentedControlModel.selectedSegmentIndex),
                                                 extras: self.switchExtras.isOn ? Double(1.0) : Double(0.0),
                                                 kilometraje: Double(self.sliderKms.value),
                                                 estado: Double(self.segmentedControlStatus.selectedSegmentIndex)) {
            let clampValue = max(500, prediction.precio)
            formatter.numberStyle = .currency
            
            self.labelPrice.text = formatter.string(for: clampValue)
        } else {
            self.labelPrice.text = "ERROR"
        }
    }
}
