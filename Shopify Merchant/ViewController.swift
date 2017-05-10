//
//  ViewController.swift
//  Shopify Merchant
//
//  Created by Kaan Ozkan on 2017-05-05.
//  Copyright © 2017 Kaan Ozkan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//	let revenueLabel = UILabel()
//	let customKeyboardLabel = UILabel()
	@IBOutlet weak var revenueLabel: UILabel!
	@IBOutlet weak var customKeyboardLabel: UILabel!

	var revenue = 0.0
	var customKeyboardsSold = 0

	let model = dataModel()

	override func viewDidLoad() {
		super.viewDidLoad()

		// The completion handler to be called when the json data is proccessed and is avalaible to use
		let completionHandler = { [weak self] (totalPrice: Double, customKeyboard : Int)  in
			self?.revenue = totalPrice
			self?.customKeyboardsSold = customKeyboard
			// run the UI related code on the main thread to disable any lag
			DispatchQueue.main.async(execute: {
				self?.setLabelContent()
			})

		}

		model.getJson(completion: completionHandler)

		// Do any additional setup after loading the view, typically from a nib.
	}

	func setLabelContent() {
		self.revenueLabel.adjustsFontSizeToFitWidth = true
		self.customKeyboardLabel.adjustsFontSizeToFitWidth = true
		self.revenueLabel.text = "Your total order revenue is : \(self.revenue)"
		self.customKeyboardLabel.text = "Number of Aerodynamic Cotton Keyboards Sold : \(self.customKeyboardsSold)"
	}

	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

