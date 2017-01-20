//
//  ScoresViewController.swift
//  Neuro-QOL Companion
//
//  Created by Work on 1/18/17.
//  Copyright © 2017 MJDoiron. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var testBattery:[Test]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return testBattery.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        let test = testBattery[indexPath.row]
        if let testLabel = cell.viewWithTag(1) as? UILabel {
            testLabel.text = test.title
        }
        if let tScoreLabel = cell.viewWithTag(2) as? UILabel {
            let formatedTScore = String(format: "%.2f", test.tScore!)
            tScoreLabel.text = formatedTScore
        }
        if let standardErrorLabel = cell.viewWithTag(3) as? UILabel {
            let formatedStandardError = String(format: "%.1f", test.standardError!)
            standardErrorLabel.text = formatedStandardError
        }
        return cell
    }
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "ShowPreview" {
            let navigationController = segue.destination as! UINavigationController
            let testPreviewViewController = navigationController.viewControllers.first as! TestPreviewViewController
            testPreviewViewController.testBattery = testBattery
        }
    }

}
