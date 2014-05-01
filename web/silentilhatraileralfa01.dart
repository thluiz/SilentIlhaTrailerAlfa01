import 'dart:html';
import 'dart:async';
import 'package:animation/animation.dart';

class SubTitle {  
  int duration;
  int delayAfter;
  String text;
  
  SubTitle(this.text, this.duration, [this.delayAfter=500]);
}

main() {
  var audio = querySelector("#audio01") as MediaElement;  
  
  new Timer(new Duration(seconds: 3), () {
      audio.play();  
      new Timer(new Duration(seconds: 1), subTitleAnimations);
      new Timer(new Duration(seconds: 16), backgroundAnimations);
      new Timer(new Duration(milliseconds: 22200), zombieAnimations);
      new Timer(new Duration(milliseconds: 24200), call4Players);
      new Timer(new Duration(milliseconds: 32500), showCredits);  
  });  
       
}

void showCredits() {
  var stage = querySelector('#stage') as DivElement;
  var cred = querySelector('#credits') as DivElement;
  var credits = cred.children;
  
  var queue = new AnimationQueue();
  queue.add(new ElementAnimation(stage)
                  ..properties = { 'opacity': 0 }
                  ..duration = 3000);
  
  queue.add(new ElementAnimation(cred)
                    ..properties = { 'opacity': 1 }
                    ..duration = 500);
  
  credits.forEach((c) {
    queue.add(new ElementAnimation(c)
                        ..properties = { 'opacity': 1 }
                        ..duration = 800);    
       
  }); 
  
  queue.add(new ElementAnimation(cred)
                      ..properties = { 'opacity': 0 }
                      ..duration = 800);
  
  
  queue.add(new ElementAnimation(querySelector('#logo'))
                          ..properties = { 'opacity': 1 }
                          ..duration = 1200);
  
  queue.add(new ElementAnimation(querySelector('#logo'))
                            ..properties = { 'opacity': 1 }
                            ..duration = 1000);   
  
  queue.run();
}

void call4Players() {
  var callDiv = querySelector("#divCall4players") as DivElement;
  var msgs = callDiv.children;
  var queue = new AnimationQueue();
  msgs.forEach((m) {
    queue.add(new ElementAnimation(m)
                ..properties = { 'opacity': 1 }
                ..duration = 1000);
    
    queue.add(new ElementAnimation(m)
                    ..properties = { 'opacity': 1 }
                    ..duration = 1000);
  });
  
  
  queue.run();
}

void zombieAnimations() {
  var zombie = querySelector('#divZombie') as DivElement;
  var queue = new AnimationQueue();
  
  queue.add(new ElementAnimation(zombie)
          ..properties = { 'opacity': 1 }
          ..duration = 2000);
  
  zombieWalk(zombie, 2000, 80);
  
  queue.add(new ElementAnimation(zombie)
            ..properties = { 'top': 300, 'width' : 150 }
            ..duration = 1500);
  
  queue.add(new ElementAnimation(zombie)
                ..properties = { 'top': 250, 'width' : 90, 'left' : 450 }
                ..duration = 3000);
  
  queue.add(new ElementAnimation(zombie)
                  ..properties = { 'top': 300, 'width' : 170, 'left' : 350 }
                  ..duration = 2000);
  
  queue.add(new ElementAnimation(zombie)
                    ..properties = { 'top': 250, 'width' : 300, 'left' : 150 }
                    ..duration = 2500);
  
  queue.add(new ElementAnimation(zombie)
                      ..properties = { 'top': 220, 'width' : 320, 'left' : 190 }
                      ..duration = 1000);
  
  queue.add(new ElementAnimation(zombie)
                        ..properties = { 'top': 190, 'width' : 360, 'left' : 195 }
                        ..duration = 1000);
  
  queue.run();
}

void zombieWalk(DivElement zombie, [int startTime = 0, int steps = 10]) {
  for(var i = 0; i < steps; i++) {
    new Timer(new Duration(milliseconds: startTime + (i * 150)), () => zombie.style.transform = "rotateZ(" + (i % 2 == 0 ? "-" : "") + "1deg)");       
  }  
}


void backgroundAnimations() {
  var divImg0 = querySelector('#divImg0');
  var divImg1 = querySelector('#divImg1');
  var divImg2 = querySelector('#divImg2');
    
  var anim0 = new ElementAnimation(divImg0)
        ..properties = { 'opacity': 0 }
        ..duration = 7000;
  
  var anim1 = new ElementAnimation(divImg1)
      ..properties = { 'opacity': 1 }
      ..duration = 7000;
  
  var anim2 = new ElementAnimation(divImg2)
        ..properties = { 'opacity': 1 }
        ..duration = 2000;
       
  anim0.run();
  anim1.run();     
  
  new Timer(new Duration(milliseconds: 6700), anim2.run);
}

void subTitleAnimations() {
  var divSub = querySelector('#subtitles');
  var texts = getTexts();    
  var queue = new AnimationQueue();
  var subTitlesTime = 0;
  
  texts.forEach((subtitle) {
    
    var time = subtitle.duration;        
    new Timer( new Duration(milliseconds: subTitlesTime), () => divSub.text = subtitle.text);    
    subTitlesTime += time + subtitle.delayAfter;                
    
    queue.add(new ElementAnimation(divSub)
              ..properties = { 'opacity': 1 }
              ..duration = (time*0.25).toInt() );
    
    queue.add(new ElementAnimation(divSub)
                      ..properties = { 'opacity': 1 }
                      ..duration = (time*0.55).toInt());
    
    queue.add(new ElementAnimation(divSub)
                  ..properties = { 'opacity': 0 }
                  ..duration = (time*0.25).toInt());
  });
  
  var last = new ElementAnimation(divSub)
  ..properties = { 'opacity': 0 }
  ..duration = 500;  
  
  queue.add(last);
     
  queue.run();
}

List<SubTitle> getTexts() {
  var texts = new List<SubTitle>();
  texts.add(new SubTitle("Eles achavam que estavam seguros", 3000, 0));
  texts.add(new SubTitle("Vivendo suas vidas medíocres na Ilha do Governador", 3300));
  texts.add(new SubTitle("Mas não sabiam que logo ali", 3500, 0));
  texts.add(new SubTitle("Naquela universidade sem recursos do governo", 3500));  
  texts.add(new SubTitle("Naquela universidade na ilha ao lado", 3500, 0));
  texts.add(new SubTitle("Uma ameaça MORTAL seria liberada", 3500));
  
  return texts;
}


