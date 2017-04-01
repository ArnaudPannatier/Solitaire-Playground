//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import Darwin

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
PlaygroundPage.current.liveView = containerView;

class Dot {
    var stat: Bool = true
    var dotAjd: Direction?
    var id : Int?
    var action : [Dot]?
    var view : Circle = Circle(pos: CGPoint(),dia: 0.0)
    
    init(){
        
    
    }
}

class Circle : UIView {
    init(pos: CGPoint, dia: CGFloat){
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: dia, height: dia))
        self.layer.cornerRadius = 25.0
        let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)
        self.backgroundColor = startingColor
        containerView.addSubview(self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
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
}


var ColorField = [
    "bleuFonce": UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0)
]



var mapDot : [Dot] = []
var dotPlay: [Dot] = []
var compt = 0
var completementBloque = false
var numberOfCase = 33



func initialize() {
    createField();
    //play(container);
}
func createField(){
    let w: CGFloat = containerView.frame.size.width;
    let rdot: CGFloat =  w/15.0;
    let milieuDot: CGFloat = w/2.0;
    //dot.style.width = rdot+"px";
    //dot.style.height = rdot+"px";

    let centralDots = 21
    let coteGauche = 27
    let coteDots = 6
    let cotes = 2
    let centerNumber = 10

    
    for i in 1..<numberOfCase {
            mapDot[i] = Dot()
    }
        
        
    for i in 1..<centralDots {
        let posX: CGFloat = milieuDot-rdot*(2.5-CGFloat((i%3)*2))
        let posY: CGFloat = rdot*(1+floor(CGFloat(i)/3.0)*2)
        
    
        let pos = CGPoint(x: posX, y : posY )
        mapDot[i].id = i;
        mapDot[i].view = Circle(pos: pos,dia: rdot)
            //Centre
        if(i==centerNumber){
            mapDot[i].stat = false;
            mapDot[i].view.backgroundColor = ColorField["bleuFonce"];
        }
            
        
        
        
        }
        
        
    for i in 1..<coteDots {
        for j in 1..<cotes {
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
            mapDot[i].view = Circle(pos: pos,dia: rdot)
        }
    }
        
    for i in 1..<numberOfCase{
            
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

initialize()

 /*
    play : function(container){
        GA.algo();
        
        
    },
    joue_coup : function(d1,dir){
        var couleur1 = d1.elem;
        var couleur2 = d1.dotAjd[dir].dotAjd[dir].elem;
        d1.stat = 0;
        d1.dotAjd[dir].stat = 0;
        d1.dotAjd[dir].dotAjd[dir].stat = 1;
        
        dotPlay = new Array();
        Solitaire.colorise();
        
        couleur1.style.backgroundColor = "#2ecc71";
        couleur2.style.backgroundColor = "#e74c3c";
        
    },
    colorise : function(){
        Solitaire.actionZero();
        compt = 0;
        
        for(i=0; i<33; i++){
            if(mapDot[i].stat == 0){
                mapDot[i].elem.style.backgroundColor = "#2c3e50";
            }else if(outils.to_play(mapDot[i])){
                compt++;
                mapDot[i].elem.style.backgroundColor = "#f1c40f";
            }else {
                compt++;
                mapDot[i].elem.style.backgroundColor = "#3498db";
                
            }
            
        }
    },
    playArray : function(arr){
        var k = 0;
        Solitaire.remiseAZero();
        Solitaire.actionZero();
        Solitaire.colorise();
        
        while(!Solitaire.is_blocked()){
            var i = Math.floor(arr[2*k]*dotPlay.length);
            var j = Math.floor(arr[2*k+1]*dotPlay[i].action.length);
            
            Solitaire.joue_coup(dotPlay[i], dotPlay[i].action[j]);
            k++;
            
        }
        
        return k;
    },
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
    
    is_blocked : function(){
        if(dotPlay.length == 0 || completementBloque){
            return true;
        }
        else {
            return false;
        }
    },
    round_o : function(d){
        if(d.dotAjd.up != nil){
            if(d.dotAjd.up.stat == 1)
            return false;
            
            if(d.dotAjd.up.dotAjd.left != nil && d.dotAjd.up.dotAjd.left.stat == 1)
            return false;
            if(d.dotAjd.up.dotAjd.right != nil && d.dotAjd.up.dotAjd.right.stat == 1)
            return false;
            
        }
        if(d.dotAjd.left != nil){
            if(d.dotAjd.left.stat == 1)
            return false;
            
            if(d.dotAjd.left.dotAjd.down != nil && d.dotAjd.left.dotAjd.down.stat == 1)
            return false;
            
        }
        if(d.dotAjd.right != nil){
            if(d.dotAjd.right.stat == 1)
            return false;
            
            if(d.dotAjd.right.dotAjd.down != nil && d.dotAjd.right.dotAjd.down.stat == 1)
            return false;
            
        }
        if(d.dotAjd.down != nil && d.dotAjd.down.stat ==1){
            return false;
        }
        return true;
    },
    
    is_winning : function(){
        if(Solitaire.is_blocked()){
            stat = 0;
            for(i=0; i<33; i++){
                if(mapDot[i].stat == 1){
                    stat++;
                    
                }
                
            }
            
            return stat;
        }
        return 1000;
        
    },
    remiseAZero : function(){
        completementBloque = false;
        for(i=0; i<33; i++){
            if(i != 10){
                mapDot[i].stat = 1;
                
            }else{
                mapDot[i].stat = 0;
            }
        }
    },
    actionZero : function(){
        dotPlay = [];
        for(i=0; i<33; i++){
            mapDot[i].action = new Array();
            
        }
    },
    
};

var outils = {
    to_play : function(tab){
        var play = false;
        var dir = new Array("up", "left", "right", "down");
        
        localementBloque = true;
        for(j=0; j<dir.length; j++){
            // Playable
            if(outils.test_exist(tab, dir[j]) && tab.dotAjd[dir[j]].stat ==1 && tab.dotAjd[dir[j]].dotAjd[dir[j]].stat == 0){
                play = true;
                tab.action.push(dir[j]);
                dotPlay.push(tab);
            }
            
            // Completely isolated		
            if(tab.dotAjd[dir[j]] != nil){
                var cur = tab.dotAjd[dir[j]];
                if(cur.stat == 0){
                    for (var k = 0; k < dir.length; k++) {
                        var secondNeighbourg = cur.dotAjd[dir[k]];
                        if(secondNeighbourg != nil && secondNeighbourg != tab){
                            if(secondNeighbourg.stat != 0){
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
    },
    test_exist : function(t, dir){
        return (t.dotAjd[dir] != nil && t.dotAjd[dir].dotAjd[dir] != nil) ? true : false;
        
    }
};
 
 */