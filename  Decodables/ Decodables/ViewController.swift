//
//  ViewController.swift
//   Decodables
//
//  Created by Rafael M. Trasmontero on 12/29/17.
//  Copyright © 2017 LetsBuildTuts. All rights reserved.
//

// OBJECTIVE: Parse the JSON using Decodables, using the 4 URLS

// 1. JSON URL w/ a Single Dictionary of a Course:
//  https://api.letsbuildthatapp.com/jsondecodable/course
// 2. JSON URL w/ an Array of Two Dictonaries of Courses:
// https://api.letsbuildthatapp.com/jsondecodable/courses
// 3. JSON URL where the Array of Courses are inside a Websitedescription:
// https://api.letsbuildthatapp.com/jsondecodable/website_description
// 4. JSON URL w/ an Array of Dictionaries with Missing/Empty properties:
// https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields


import UIKit

//~ Traditional Model Object to Reflect the JSON in the URL
struct Course {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    
    init (json:[String:Any]){
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? "N/A"
        link = json["link"] as? String ?? "N/A"
        imageUrl = json["imageUrl"] as? String ?? "N/A"
    }
}

//*1&2 Model Object to Reflect the JSON in the link #1&2 using Decodables
struct Course1234: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}

//*3 Model Object to Reflect the JSON in link #3 using Decodables
struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course1234]
}

//*4 Model Object to Reflact the JSON in link #4 using Decodables
struct CoursesWithMissingFields {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchJOSNURLTradionally()
        //fetchJOSNURL1()
        //fetchJOSNURL2()
        //fetchJOSNURL3()
        fetchJOSNURL4()
    }

    //~
    func fetchJOSNURLTradionally(){
        let stringURL = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let url = URL(string: stringURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, errror) in
            guard let receivedData = data else {return}
            let dataAsString = String(data: receivedData, encoding: .utf8)
            print(dataAsString ?? "No data to convert to string")
            do{
                guard let json = try JSONSerialization.jsonObject(with: receivedData, options: .mutableContainers) as? [String:Any] else {return}
                print(json)
                let theCourse = Course(json: json)
                print("THE COURSE:",theCourse)
            }catch let jsonError {
                print("ERROR PARSING JSON:",jsonError)
            }
        
        } .resume()
        
    }
    
    
    //*1.
    func fetchJOSNURL1(){
        let stringURL = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let url = URL(string: stringURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, errror) in
            guard let receivedData = data else {return}
            let dataAsString = String(data: receivedData, encoding: .utf8)
            print(dataAsString ?? "No data to convert to string")
            do{
                let course = try JSONDecoder().decode(Course1234.self, from: receivedData)  //<---Course123.self
                print("THE COURSE IS:",course)
            }catch let jsonError {
                print("ERROR PARSING JSON:",jsonError)
            }
            
            } .resume()
        
    }
    
    //*2.
    func fetchJOSNURL2(){
        let stringURL = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: stringURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, errror) in
            guard let receivedData = data else {return}
            let dataAsString = String(data: receivedData, encoding: .utf8)
            print(dataAsString ?? "No data to convert to string")
            do{
                let courses = try JSONDecoder().decode([Course1234].self, from: receivedData)   //<---[Course123].self
                print("THE COURSES ARE:",courses)
            }catch let jsonError {
                print("ERROR PARSING JSON:",jsonError)
            }
            
            } .resume()
        
    }

    //*3.
    func fetchJOSNURL3(){
        let stringURL = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        guard let url = URL(string: stringURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, errror) in
            guard let receivedData = data else {return}
            let dataAsString = String(data: receivedData, encoding: .utf8)
            print(dataAsString ?? "No data to convert to string")
            do{
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: receivedData)
                print("THE WEBSITE NAME & DESCRIPTION IS:",websiteDescription.name + websiteDescription.description )
                print("THE COURSES INSIDE ARE:",websiteDescription.courses)
            }catch let jsonError {
                print("ERROR PARSING JSON:",jsonError)
            }
            
            } .resume()
        
    }
    
    //*4.
    func fetchJOSNURL4(){
        let stringURL = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        guard let url = URL(string: stringURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, errror) in
            guard let receivedData = data else {return}
            let dataAsString = String(data: receivedData, encoding: .utf8)
            print(dataAsString ?? "No data to convert to string")
            do{
                let courses = try JSONDecoder().decode([CoursesWithMissingFields].self, from: receivedData)
                print("THE COURSES WITH MISSING FIELDS ARE:",courses)
            }catch let jsonError {
                print("ERROR PARSING JSON:",jsonError)
            }
            
            } .resume()
        
    }
    
}

