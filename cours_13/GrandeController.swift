//
//  GrandeController.swift
//  cours_13
//
//  Created by João Carlos Fernandes Neto on 17-11-24.
//  Copyright © 2017 João Carlos Fernandes Neto. All rights reserved.
//************************************
import UIKit
import Foundation
//************************************
class GrandeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
//************************************
    let userDefaultsObj = UserDefaultsManager()
//************************************
    @IBOutlet weak var grandeField: UITextField!
    @IBOutlet weak var couseField: UITextField!
    @IBOutlet weak var student_name_label: UILabel!
    @IBOutlet weak var course_grande_tableveiw: UITableView!
//************************************
    typealias studentName = String
    typealias couseName = String
    typealias gradeCouse = Double
//************************************
    var studentGredes: [studentName: [couseName: gradeCouse]]!
    var arrayOfCourse: [couseName]!
    var arrayOfGrades: [gradeCouse]!
//************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        student_name_label.text = userDefaultsObj.getValue(theKey: "name") as? String
        loadUserDefaults()
        fillUpArray()
    }
//************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCourse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = course_grande_tableveiw.dequeueReusableCell(withIdentifier: "proto")!
        if let aCourse = cell.viewWithTag(100) as! UILabel! {
            aCourse.text = arrayOfCourse[indexPath.row]
        }
        if let aGrande = cell.viewWithTag(101) as! UILabel! {
            aGrande.text = String(arrayOfGrades[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = [studentName](studentGredes.keys)[indexPath.row]
        userDefaultsObj.setKey(theValue: name as AnyObject, theKey: "name")
        performSegue(withIdentifier: "proto", sender: nil)
    
    }
  //************************************
    func fillUpArray() {
        let name = student_name_label.text
        let couses_and_grands = studentGredes[name!]
        arrayOfCourse = [couseName](couses_and_grands!.keys)
        arrayOfGrades = [gradeCouse](couses_and_grands!.values)
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
    @IBAction func addCourseAndGrande(_ sender: UIButton) {
        let name = student_name_label.text!
        var student_courses = studentGredes[name]!
        student_courses[couseField.text!] = gradeCouse(grandeField.text!)
        studentGredes[name] = student_courses
        userDefaultsObj.setKey(theValue: studentGredes as AnyObject, theKey: "gradeCouse")
        fillUpArray()
        course_grande_tableveiw.reloadData()
        grandeField.text = ""// pour effacher automatiquement le champ apres validation
        couseField.text = ""// pour effacher automatiquement le champ apres validation
    }
//************************************ pour effecer le champs automatiquemnt apres remplissage
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let name = student_name_label.text!
            var curses_and_grades = studentGredes[name]!
            let theCourseToDelete = [couseName](curses_and_grades.keys)[indexPath.row]
            curses_and_grades[theCourseToDelete] = nil
            studentGredes[name] = curses_and_grades
            userDefaultsObj.setKey(theValue: studentGredes as AnyObject, theKey: "gradeCouse")
            fillUpArray()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
//************************************
}


























