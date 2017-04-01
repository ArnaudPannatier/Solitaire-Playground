//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import Darwin



var ColorField = [
    "darkBlue": UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0),
    "lightBlue": UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0),
    "lightGray": UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0),
    "green" : UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0),
    "red" : UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0),
    "yellow" : UIColor(red:0.95, green:0.77, blue:0.06, alpha:1.0)
]


var containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 400, height: 400))
containerView.backgroundColor = ColorField["lightGray"]

PlaygroundPage.current.liveView = containerView;


class Direction {
    var up: Int?
    var left: Int?
    var right: Int?
    var down: Int?
    
    init(u: Int?, l: Int?, r: Int?, d: Int?){
        self.up = u
        self.down = d
        self.left = l
        self.right = r
    }
    subscript(name: String) -> Dot? {
        switch name {
        case "up":
            return (self.up == nil) ? nil : mapDot[self.up!]
        case "left":
            return (self.left == nil) ? nil : mapDot[self.left!]
        case "right":
            return (self.right == nil) ? nil :mapDot[self.right!]
        case "down":
            return (self.down == nil) ? nil : mapDot[self.down!]
        default:
            return Dot()
        }
    }
}



class Circle : UIView {
    init(pos: CGPoint, dia: CGFloat){
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: dia, height: dia))
        self.layer.cornerRadius = dia/2+1
        self.backgroundColor = ColorField["lightBlue"]
        containerView.addSubview(self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Dot {
    var stat: Bool
    var dotAjd: Direction
    var id : Int
    var action : [String]
    var view : Circle
    
    init(){
        self.stat = true
        self.dotAjd = Direction(u: nil,l: nil,r: nil,d: nil)
        self.id = 0
        self.action = []
        self.view = Circle(pos: CGPoint(),dia: 0.0)
        
    
    }

}


var mapDot : [Dot] = []
var dotPlay: [Dot] = []
var compt = 0
var completementBloque = false
var numberOfCase = 33


func createField(){
    let w: CGFloat = containerView.frame.size.width;
    let rdot: CGFloat =  w/15.0;
    let milieuDot: CGFloat = w/2.0;
    let centralDots = 21
    let coteGauche = 27
    let coteDots = 6
    let cotes = 2
    let centerNumber = 10

    
    for _ in 0..<numberOfCase {
        mapDot.append(Dot())
    }
        
        
    for i in 0..<centralDots {
        let posX: CGFloat = milieuDot-rdot*(2.5-CGFloat((i%3)*2))
        let posY: CGFloat = rdot*(1+floor(CGFloat(i)/3.0)*2)
        
    
        let pos = CGPoint(x: posX, y : posY )
        mapDot[i].id = i;
        mapDot[i].view = Circle(pos: pos,dia: rdot)
            //Centre
        if(i==centerNumber){
            mapDot[i].stat = false;
            mapDot[i].view.backgroundColor = ColorField["darkBlue"];
        }
            
        
        
        
        }
        
        
    for i in 0..<coteDots {
        for j in 0..<cotes {
            let k=centralDots+i*2+j;
            
            
           
            let posY = milieuDot-rdot*(2.5-CGFloat(i%3)*2);
            var posX: CGFloat
            if(i>2){
                posX = milieuDot+rdot*3.5+CGFloat(j)*2.0*rdot;
            }else{
                posX = rdot+CGFloat(j)*rdot*2;
            }
            let pos = CGPoint(x: posX, y : posY )

            
            mapDot[k].id = k;
            mapDot[k].view = Circle(pos: pos,dia: rdot)
        }
    }
        
    for i in 0..<numberOfCase{
            
            if(i<centralDots){
                if(i%3==0){
                    
                    mapDot[i].dotAjd = Direction(
                        u : (i==0) ? nil: i-3,
                        l : (i<6 || i>12) ? nil : (((i/3)-1)*2)+20,
                        r : i+1,
                        d : (i==18) ? nil : i+3)
                    
                    
                }else if(i%3==1){
                    
                    mapDot[i].dotAjd = Direction(
                        u :  (i==1) ? nil : i-3,
                        l : i-1,
                        r : i+1,
                        d : (i==19) ? nil : i+3
                    )
                    
                    
                }else{
                    mapDot[i].dotAjd = Direction(
                        u : (i==2) ? nil : i-3,
                        l : i-1,
                        r : (i<6 || i>14) ? nil : ((((i-2)/3)-1)*2)+25,
                        d : (i==20) ? nil : i+3
                        
                    )
                    
                }
                
                
            }else if(i<coteGauche){
                if(i%2==1){
                    mapDot[i].dotAjd = Direction(
                        u : (i==21) ? nil : i-2,
                        l : nil,
                        r : i+1,
                        d : (i==25) ? nil : i+2
                        
                        
                    )
                    
                }else{
                    mapDot[i].dotAjd = Direction(
                        u : (i==22) ? nil : i-2,
                        l : i-1,
                        r : ((((i-20)/2)+1)*3),
                        d : (i==26) ? nil : i+2
                        )
                }
            }else{
                if(i%2==1){
                    mapDot[i].dotAjd = Direction(
                        u : (i==27) ? nil : i-2,
                        l : (((((i-25)/2)+1)*3)+2),
                        r : i+1,
                        d : (i==31) ? nil : i+2
                    )
                    
                }else{
                    mapDot[i].dotAjd = Direction(
                        u : (i==28) ? nil : i-2,
                        l : i-1,
                        r : nil,
                        d : (i==32) ? nil : i+2
                    )
                    
                    
                }
                
            }
        }
}

func joue_coup(d1: Dot, dir: String){
        let couleur1 = d1.view;
        let couleur2 = d1.dotAjd[dir]!.dotAjd[dir]!.view;
        d1.stat = false;
        d1.dotAjd[dir]!.stat = false;
        d1.dotAjd[dir]!.dotAjd[dir]!.stat = true;
    
        dotPlay = [];
        colorise();
        
        couleur1.backgroundColor = ColorField["red"];
        couleur2.backgroundColor = ColorField["green"];
        
}
 
func colorise(){
        actionZero();
        var compt = 0;
        
    for i in 0..<numberOfCase {
            if(!mapDot[i].stat){
                mapDot[i].view.backgroundColor = ColorField["darkBlue"];
            }else if(to_play(dot: mapDot[i])){
                compt += 1;
                mapDot[i].view.backgroundColor = ColorField["yellow"];
            }else {
                compt += 1;
                mapDot[i].view.backgroundColor = ColorField["lightBlue"];
                
            }
            
        }
    }


func playArray(arr: [Double]) -> Int{
        var k = 0;
        remiseAZero();
        actionZero();
        colorise();
        
        while(!is_blocked()){
            let i = Int(floor(arr[2*k]))*dotPlay.count;
            let j = Int(floor(arr[2*k+1]))*dotPlay[i].action.count;
            
            joue_coup(d1: dotPlay[i], dir: dotPlay[i].action[j]);
            k += 1;
            
        }
        
        return k;
}
/*
    playSlowArray : function(arr){
        k=0, temp=0;
        Solitaire.remiseAZero();
        Solitaire.actionZero();
        Solitaire.colorise();
        
        (function delay(){
        
        
        setTimeout(function(){
        
        if(Solitaire.is_blocked()){
        return;
        }
        
        var i = Math.floor(arr[2*k]*dotPlay.length);
        var j = Math.floor(arr[2*k+1]*dotPlay[i].action.length);
        
        Solitaire.joue_coup(dotPlay[i], dotPlay[i].action[j]);
        k++;
        delay();
        
        
        }, temp);
        
        
        })();
        
    },	
     */
func is_blocked()->Bool{
        if(dotPlay.isEmpty || completementBloque){
            return true;
        }
        else {
            return false;
        }
}
 func remiseAZero(){
        completementBloque = false;
        for i in 0..<numberOfCase {
            if(i != 10){
                mapDot[i].stat = true;
                
            }else{
                mapDot[i].stat = false;
            }
        }
}
func actionZero() {
        dotPlay = [];
        for i in 0..<numberOfCase {
            mapDot[i].action = [];
        
        }
}
func to_play(dot: Dot) -> Bool {
    var play = false;
    let dir = ["up", "left", "right", "down"];
        
    var localementBloque = true;
    for d in dir {
            // Playable
            if(test_exist(t: dot, dir: d) && dot.dotAjd[d]!.stat && !dot.dotAjd[d]!.dotAjd[d]!.stat){
                play = true;
                dot.action.append(d);
                dotPlay.append(dot);
            }
            
            // Completely isolated		
            if(dot.dotAjd[d] != nil){
                let cur = dot.dotAjd[d]!;
                if(!cur.stat){
                    for secondDir in dir {
                        let secondNeighbourg = cur.dotAjd[secondDir];
                        if(secondNeighbourg != nil && secondNeighbourg!.id != dot.id){
                            if(secondNeighbourg!.stat){
                                localementBloque = false;
                            }
                        }
                    }
                }else{
                    localementBloque = false;
                }
            }
        }
        
        if(localementBloque){
            completementBloque = true;
        }
        return play;
}
func test_exist(t : Dot, dir: String) -> Bool {
    if(t.dotAjd[dir] != nil){
        if t.dotAjd[dir]!.dotAjd[dir] != nil {
            return true;
        }
    }

    return false;
}



func initialize() {
    createField()
    colorise()

    
    
}
initialize()
