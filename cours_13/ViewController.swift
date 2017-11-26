//
//  ViewController.swift
//  cours_13
//
//  Created by João Carlos Fernandes Neto on 17-11-24.
//  Copyright © 2017 João Carlos Fernandes Neto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
//************************************
    @IBOutlet weak var student_name_tableview: UITableView!
    @IBOutlet weak var student_name_Fild: UITextField!
//************************************
    let userDefaultsObj = UserDefaultsManager()
//************************************
    typealias studentName = String
    typealias couseName = String
    typealias gradeCouse = Double
//************************************
    var studentGredes: [studentName: [couseName: gradeCouse]]!
//************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
    }
//************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentGredes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = [studentName](studentGredes.keys)[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editinsStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editinsStyle == UITableViewCellEditingStyle.delete {
            let name = [studentName](studentGredes.keys)[indexPath.row]
            studentGredes[name] = nil
            userDefaultsObj.setKey(theValue: studentGredes as AnyObject, theKey: "gradeCouse")
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = [studentName](studentGredes.keys)[indexPath.row]
        userDefaultsObj.setKey(theValue: name as AnyObject, theKey: "name")
        performSegue(withIdentifier: "seg", sender: nil)
    }
//************************************
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//************************************
    func loadUserDefaults() {
        if userDefaultsObj.doesKeyExist(theKey: "gradeCouse") {
            studentGredes = userDefaultsObj.getValue(theKey: "gradeCouse") as! [studentName: [couseName: gradeCouse]]
        } else {
            studentGredes = [studentName: [couseName: gradeCouse]]()
        }
    }
//************************************
    @IBAction func addstudent(_ sender: UIButton) {
        if student_name_Fild.text != "" {
            studentGredes[student_name_Fild.text!] = [couseName: gradeCouse]()
            student_name_Fild.text = ""
            userDefaultsObj.setKey(theValue: studentGredes as AnyObject, theKey: "gradeCouse")
            student_name_tableview.reloadData()
        }
    }
}
//************************************



