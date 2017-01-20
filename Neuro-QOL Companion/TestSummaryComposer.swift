//
//  TestSummaryComposer.swift
//  Neuro-QOL Companion
//
//  Created by Work on 1/19/17.
//  Copyright © 2017 MJDoiron. All rights reserved.
//

import UIKit

class TestSummaryComposer: NSObject {
        
    let pathToTestSummaryHTMLTemplate = Bundle.main.path(forResource: "testSummary", ofType: "html")
    
    let pathToSingleTestHTMLTemplate = Bundle.main.path(forResource: "singleTest", ofType: "html")
    
    let todaysDate = String(describing: DateFormatter.Style.short)
    
    let logoImageURL = "http://www.healthmeasures.net/images/headers/Neuro_Qol_logo.jpg"
    
    var patientID: String!
    
    var pdfFilename: String!
    
    override init(){
        super.init()
    }
    
    func renderTestSummary(patientID: String, tests: [Test]) -> String! {

        self.patientID = patientID
        
        do {
            var HTMLContent = try String(contentsOfFile: pathToTestSummaryHTMLTemplate!)
            
            HTMLContent = HTMLContent.replacingOccurrences(of:"#LOGO_IMAGE#", with: logoImageURL)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#PATIENT_ID#", with: self.patientID)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TODAYS_DATE#", with: todaysDate)

            var allTests = ""
            
            for test in tests {
                var testHTMLContent: String!
                
                testHTMLContent = try String(contentsOfFile: pathToSingleTestHTMLTemplate!)

                testHTMLContent = testHTMLContent.replacingOccurrences(of:"#TEST_NAME#", with: test.title)
                
                let formattedTScore = String(format: "%.2f", test.tScore!)
                testHTMLContent = testHTMLContent.replacingOccurrences(of:"#TEST_T_SCORE#", with: formattedTScore)
                
                let formattedStandardError = String(format: "%.1f", test.standardError!)
                testHTMLContent = testHTMLContent.replacingOccurrences(of:"#TEST_SE#", with: formattedStandardError)

                allTests += testHTMLContent
            }
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TESTS#", with: allTests)
            
            return HTMLContent
        }
            
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        
        return nil
    }
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        pdfFilename = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("TestSummary.pdf")
        
        pdfFilename = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/TestSummary.pdf"
        
        pdfData?.write(toFile: pdfFilename, atomically: true)
        
        print(pdfFilename)
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        
        UIGraphicsBeginPDFPage()
        
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        
        UIGraphicsEndPDFContext()
        
        return data
    }
}
