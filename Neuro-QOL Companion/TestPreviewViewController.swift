//
//  TestPreviewViewController.swift
//  Neuro-QOL Companion
//
//  Created by Work on 1/19/17.
//  Copyright © 2017 MJDoiron. All rights reserved.
//

import UIKit
import MessageUI

class TestPreviewViewController: UIViewController {

    @IBOutlet weak var webPreview:UIWebView!
    
    var testSummaryComposer: TestSummaryComposer!
    
    var HTMLContent: String!
    
    var patientID = "99999"
    var testBattery: [Test]!
    
    func createTestSummaryAsHTML() {
        testSummaryComposer = TestSummaryComposer()
        if let testSummaryHTML = testSummaryComposer.renderTestSummary(patientID: patientID, tests: testBattery) {
            
            webPreview.loadHTMLString(testSummaryHTML, baseURL: nil)
            HTMLContent = testSummaryHTML
        }
    }
    
    

    
    func showOptionsAlert() {
        let alertController = UIAlertController(title: "Export Successful", message: "Your test sumamry has been successfully printed to a PDF file.\n\nWhat do you want to do now?", preferredStyle: UIAlertControllerStyle.alert)
        
        let actionEmail = UIAlertAction(title: "Send by Email", style: UIAlertActionStyle.default) { (action) in
            self.sendEmail()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
        }
        
        alertController.addAction(actionEmail)
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.setSubject("Invoice")
            let data = try! Data(contentsOf: URL(string:testSummaryComposer.pdfFilename)!)
            mailComposeViewController.addAttachmentData(data, mimeType: "application/pdf", fileName: "Invoice")
            present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func exportButtonPressed(_ sender: Any) {
        testSummaryComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
        showOptionsAlert()
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTestSummaryAsHTML()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



}
