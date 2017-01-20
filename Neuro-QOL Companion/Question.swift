//
//  Question.swift
//  Neuro-QOL Companion
//
//  Created by Work on 1/17/17.
//  Copyright © 2017 MJDoiron. All rights reserved.
//

import Foundation

class Question {
    var text:String!
    var questionOptions:QuestionOptions!
    var questionOptionsArray:[String: Int] = [:]
    var chosenAnswer = ""
    var rawScore:Int? {
        get {
            if let score = questionOptionsArray[chosenAnswer] {
                return score
            } else {
            return nil
            }
        }
    }
    
    init(text: String, questionOptions: QuestionOptions){
        self.text = text
        self.questionOptions = questionOptions
        self.setQuestionOptions(for: questionOptions)
    }
    
    func setQuestionOptions(for questionOptions: QuestionOptions) {
        switch questionOptions {
        case .NeverAlways:
            questionOptionsArray["Never"] = 1
            questionOptionsArray["Rarely"] = 2
            questionOptionsArray["Sometimes"] = 3
            questionOptionsArray["Often"] = 4
            questionOptionsArray["Always"] = 5
        case .NotAtAllVeryMuch:
            questionOptionsArray["Not at all"] = 5
            questionOptionsArray["A little bit"] = 4
            questionOptionsArray["Somewhat"] = 3
            questionOptionsArray["Quite a bit"] = 2
            questionOptionsArray["Very much"] = 1
        case .NotAtAllVeryMuchReversed:
            questionOptionsArray["Not at all"] = 1
            questionOptionsArray["A little bit"] = 2
            questionOptionsArray["Somewhat"] = 3
            questionOptionsArray["Quite a bit"] = 4
            questionOptionsArray["Very much"] = 5
        case .NeverVeryOften:
            questionOptionsArray["Never"] = 5
            questionOptionsArray["Rarely (Once)"] = 4
            questionOptionsArray["Sometimes (2-3 times)"] = 3
            questionOptionsArray["Often (once per day)"] = 2
            questionOptionsArray["Very Often (several times per day)"] = 1
        case .NoneCannotDo:
            questionOptionsArray["None"] = 5
            questionOptionsArray["A little"] = 4
            questionOptionsArray["Somewhat"] = 3
            questionOptionsArray["A lot"] = 2
            questionOptionsArray["Cannot Do"] = 1
        case .WithoutAnyDiffUnableToDo:
            questionOptionsArray["Without any difficulty"] = 5
            questionOptionsArray["With a little difficulty"] = 4
            questionOptionsArray["With some difficulty"] = 3
            questionOptionsArray["With much difficulty"] = 2
            questionOptionsArray["Unable to do"] = 1
        }
    }
    
}
