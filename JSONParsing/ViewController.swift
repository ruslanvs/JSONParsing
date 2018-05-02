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
    let created_at: Date
    let updated_at: Date
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonUrlString = "http://localhost:8000/schools"
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }

            let schoolsDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //>> is this a good way or should I rather format the date output on the back end?
            schoolsDecoder.dateDecodingStrategy = .formatted(dateFormatter)

            do {
                let schools = try
                    schoolsDecoder.decode([School].self, from: data)
                print( schools )
            } catch let jsonErr {
                print( "JSON parsing error:", jsonErr )
            }
            
            
            
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

