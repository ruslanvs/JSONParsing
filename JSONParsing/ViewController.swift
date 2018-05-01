//
//  ViewController.swift
//  JSONParsing
//
//  Created by Ruslan Suvorov on 5/1/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

struct School: Decodable {
    let id: UUID
    let title: String
    let created_at: String
    let updated_at: String
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonUrlString = "http://localhost:8000/schools"
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let schools = try
                    JSONDecoder().decode([School].self, from: data)
                print( schools )
            } catch let jsonErr {
                print( jsonErr )
            }
            
            
            
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

