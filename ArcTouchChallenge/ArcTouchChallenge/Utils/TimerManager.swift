//
//  TimerManager.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 18/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class TimerManager {
    
    typealias UpdateTimerClousure = ((String) -> Void)
    typealias BooleanClousure = ((Bool) -> Void)
    
    var updatedTimerValue: UpdateTimerClousure?
    var didFinishQuiz: BooleanClousure?
    
    var timer: Timer? = nil
    var secondsLeftTimer: Int = 5 * 60

    private var timerStringFormated: String {
        let minutes = Int(secondsLeftTimer) / 60 % 60
        let seconds = Int(secondsLeftTimer) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func startTimer() {
       timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] (timer) in
            self.secondsLeftTimer -= 1
            self.updatedTimerValue?(self.timerStringFormated)
           
           if self.secondsLeftTimer <= 0 {
                self.timer?.invalidate()
                self.didFinishQuiz?(false)
           }
       }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetCounterAndTimer() {
        secondsLeftTimer = 5 * 60
        updatedTimerValue?(timerStringFormated)
    }
    
}
