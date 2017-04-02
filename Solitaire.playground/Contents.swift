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
            Timer.scheduledTimer(withTimeInterval: temp, repeats: true){timer in
                // Selection
                evaluate();
                createMatingPool();
                // Reproduction
                reproduction();
                //$("#Gen").text(gen);
                gen += 1;
            }
    }
}

func algo(){
        // Setup
        createPopulation();
        let instanceTime = RunTimer()
        instanceTime.startTimer()
    

    //$("#Gen").text(gen);
    gen += 1;
}



func initialize() {
    createField()
    algo()
}
initialize()
