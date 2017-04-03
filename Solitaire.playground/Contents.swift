//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import Darwin
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true
containerView.backgroundColor = ColorField["lightGray"]
PlaygroundPage.current.liveView = containerView;


var gen = 1
let temp = 0.001
class RunTimer {
    var timer: Timer?
    func startTimer () {
            timer = Timer.scheduledTimer(withTimeInterval: temp, repeats: true){timer in
                // Selection
                
                evaluate();
                createMatingPool();
                // Reproduction
                reproduction();
            
                generationLabel.text = "Generation : "+String(gen)
                gen += 1;
                
                if(bestFit["value"]! >= TheorethicalBestFit){
                    self.stopTimer()
                    print("Solitaire is solved.")
                }
            }
    }
    func stopTimer (){
        timer?.invalidate()
    }
}

func algo(){
        // Setup
        createPopulation();
        let instanceTime = RunTimer()
        instanceTime.startTimer()
}



func initialize() {
    createField()
    algo()
}
initialize()
