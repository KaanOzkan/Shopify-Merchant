//
//  dataModel.swift
//  Shopify Merchant
//
//  Created by Kaan Ozkan on 2017-05-06.
//  Copyright © 2017 Kaan Ozkan. All rights reserved.
//

import Foundation

class dataModel {
	var customKeyboard = 0
	var totalPrice = 0.0

	init() {}

	func getJson (completion : @escaping (Double, Int) -> Void) {
		let url = URL(string: "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")

		let task = URLSession.shared.dataTask(with: url!) { data, response, error in
			if(error == nil) {
				if let data = data {
					do {
						let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
						// pass the callback
						self.parseJson(jsonData, completion: completion)
					}
					catch {
						print("Error while deserializing JSON")
					}
				}
			}

		}
		task.resume()
		return
	}

	func parseJson(_ jsonDictionary : [String:Any], completion : (Double, Int) -> Void) {
		let orders = jsonDictionary["orders"] as? [[String:Any]]
		//print(orders)
		for order in orders! {
			let lineItems = order["line_items"] as? [[String:Any]]
			for lineItem in lineItems! {
				if lineItem["title"] as? String == "Aerodynamic Cotton Keyboard" {
					if let quantity = lineItem["quantity"] as? Int{
						self.customKeyboard += quantity
					}
				}
			}
			self.totalPrice += Double((order["total_price"] as! String))!
		}
		print(customKeyboard)
		print(totalPrice)
		completion(self.totalPrice, self.customKeyboard)
	}
}
