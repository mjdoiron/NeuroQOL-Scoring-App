//
//  QuestionsTableViewController.swift
//  Neuro-QOL Companion
//
//  Created by Work on 1/18/17.
//  Copyright © 2017 MJDoiron. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        //performSegue(withIdentifier: "ShowScores", sender: nil)
    }
    var testBattery:[Test]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return testBattery.count
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        let sectionTest = testBattery[section]
        if sectionTest.isChosenForAdmin {
            let numberOfQuestions = sectionTest.questions.count
            return numberOfQuestions
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        let test = testBattery[section]
        if test.isChosenForAdmin {
            return test.instructions
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        let test = testBattery[section]
        if test.isChosenForAdmin {
            return 33
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkTestsForCompletion()

        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        let test = testBattery[indexPath.section]
        let question = test.questions[indexPath.row]
        if let questionLabel = cell.viewWithTag(101) as? UILabel {
            questionLabel.text = question.text
        }
        if let answerLabel = cell.viewWithTag(102) as? UILabel {
            answerLabel.text = question.chosenAnswer
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let test = testBattery[indexPath.section]
        let question = test.questions[indexPath.row]
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        for answer in question.questionOptionsArray {
            let actionHandeler = { (action:UIAlertAction!) -> Void in
                question.chosenAnswer = answer.key
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            let alertAction = UIAlertAction(title: answer.key, style: UIAlertActionStyle.default, handler: actionHandeler)
            alert.addAction(alertAction)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkTestsForCompletion(){
        var testsAttempted = 0
        var testsCompleted = 0
        for test in testBattery {
            if test.isChosenForAdmin {
                testsAttempted += 1
                test.checkForCompletion()
                if test.hasAllQuestionsAnswered {
                    testsCompleted += 1
                }
            }
        }
        if testsCompleted == testsAttempted {
            doneButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "ShowScores" {
            let navigationController = segue.destination as! UINavigationController
            let scoresViewController = navigationController.viewControllers.first as! ScoresViewController
            var testsToPass:[Test] = []
            for test in testBattery {
                if test.hasAllQuestionsAnswered {
                    testsToPass.append(test)
                }
            }
            scoresViewController.testBattery = testsToPass
        }
    }

}
