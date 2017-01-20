//
//  ChooseTestTableTableViewController.swift
//  Neuro-QOL Companion
//
//  Created by Work on 1/18/17.
//  Copyright © 2017 MJDoiron. All rights reserved.
//

import UIKit

class ChooseTestTableTableViewController: UITableViewController {

    var testBattery:[Test] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testBattery = []
        testBattery.append(Test(shortForm: .Anxiety))
        testBattery.append(Test(shortForm: .CognitiveFunction))
        testBattery.append(Test(shortForm: .Depression))
        testBattery.append(Test(shortForm: .EmotionBehavioralDyscontrol))
        testBattery.append(Test(shortForm: .Fatigue))
        testBattery.append(Test(shortForm: .LowerExtremityFunction))
        testBattery.append(Test(shortForm: .PositiveAffectAndWellBeing))
        testBattery.append(Test(shortForm: .SatisfactionWithSocialRolesAndActivities))
        testBattery.append(Test(shortForm: .SleepDisturbance))
        testBattery.append(Test(shortForm: .SocialParticipation))
        testBattery.append(Test(shortForm: .Stigma))
        testBattery.append(Test(shortForm: .UpperExtremityFunction))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.selectionStyle = .none

        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            testBattery[indexPath.row].isChosenForAdmin = false
        } else {
            cell.accessoryType = .checkmark
            testBattery[indexPath.row].isChosenForAdmin = true

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "ShowQuestions" {
            let navigationController = segue.destination as! UINavigationController
            let questionsTableViewController = navigationController.viewControllers.first as! QuestionsTableViewController
            questionsTableViewController.testBattery = testBattery
        }
    }
}
