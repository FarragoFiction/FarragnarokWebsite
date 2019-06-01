import 'dart:async';
import 'dart:html';

import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';


class Consort {
    String chatterClass = "chatter";
    bool raffle;
    ImageElement imageElement;
    int x = 0;
    int textY = 250;
    int talkCount = 0;
    Element container;
    Element chatter;
    static int max = 1;
    Random rand = new Random();
    int speechBubbleAnchor = 240;
    int chatterRelativeLeft = 100;
    int chatterBounce = 10;
    bool up = true;
    WeightedList<String> chats = new WeightedList();
    DateTime lastTalk;

    Consort(Element this.container, int this.x, String src, bool this.raffle) {
        rand.nextInt(); //init
        up = rand.nextBool();
        imageElement = new ImageElement(src: "images/Consorts/$src");
        imageElement.style.left = "${x}px";
        imageElement.classes.add("consort");
        container.append(imageElement);
        chatter = new DivElement()..text = "thwap!";
        container.append(chatter);
        initTopics();
        talk();
        animate();
    }

    static void spawnConsorts(Element output, bool beavers, bool gulls) {
        DivElement strip = new DivElement()..classes.add("consortStrip");
        output.append(strip);
        Random rand = new Random();
        int x = rand.nextInt(10) - 5;
        bool alligator = false;
        int numberConsorts = rand.nextInt(5)+2; //have at least one of  each type
        if(rand.nextDouble()<.1) {
            numberConsorts = rand.nextInt(12)+2; //have at least one of  each type
        }
        for(int i = 0; i<numberConsorts; i++) {
            int image = rand.nextInt(2);
            //first two are always different
            if(beavers &&(i == 0 || (rand.nextBool() && i != 1))) {
                new Consort(strip, x, "$image.gif", false);
            }else if(gulls) {
                new GullConsort(strip, x, false);
            }
            x += rand.nextInt(500)+50;
            if(x > 1000) x = 0;
        }
    }

    static void spawnRaffleConsorts(Element output, bool beavers, bool gulls) {
        DivElement strip = new DivElement()..classes.add("consortStrip");
        output.append(strip);
        Random rand = new Random();
        int x = rand.nextInt(10) - 5;
        bool alligator = false;
        int numberConsorts = rand.nextInt(5)+2; //have at least one of  each type
        if(rand.nextDouble()<.1) {
            numberConsorts = rand.nextInt(12)+2; //have at least one of  each type
        }
        for(int i = 0; i<numberConsorts; i++) {
            int image = rand.nextInt(2);
            //first two are always different
            if(beavers &&(i == 0 || (rand.nextBool() && i != 1))) {
                new Consort(strip, x, "$image.gif", true);
            }else if(gulls) {
                new GullConsort(strip, x,true);
            }
            x += rand.nextInt(500)+50;
            if(x > 1000) x = 0;
        }
    }

    void initTopics() {
        if(raffle) {
            chats.add("Coins!!");
            chats.add("Sweepstakes!!");
            chats.add("thwap thwap!!",0.5);
            return;
        }

        chats.add("",10.0);
        chats.add("thwap!!",10.0);
        chats.add("thwap thwap!!",10.0);
        chats.add("seeds!!",2);
        chats.add("i love trees!!");
        chats.add("trees!!",2);
        chats.add("fruit!!",2);
        chats.add("flowers!!",2);
        chats.add("leaves!!",2);
        chats.add("so many seeds!!");

        chats.add("seed vault best vault!!");
        chats.add("lohae has two names!!",0.3);
    }


    void talk() {
        talkCount ++;
        if(talkCount % 2 == 0) {
            imageElement.style.transform = "scaleX(-1)";
        }else {
            imageElement.style.transform = "scaleX(1)";
        }
        lastTalk = new DateTime.now();
        chatter.text = rand.pickFrom(chats);
        if(chatter.text.isEmpty) {
            chatter.style.display = "none";
        }else {
            chatter.style.display = "block";
        }
        chatter.classes.add(chatterClass);
        chatter.style.left = "${x + chatterRelativeLeft}px";
        chatter.style.bottom = "250px";
    }

    Future<Null> animate() async{
        if(up) {
            chatter.style.bottom = "${speechBubbleAnchor}px";
            up = false;
        }else {
            chatter.style.bottom = "${speechBubbleAnchor+chatterBounce}px";
            up = true;
        }
        Duration diff = new DateTime.now().difference(lastTalk);
        if(diff.inSeconds > rand.nextInt(10)+3) talk();
        await window.animationFrame;
        new Timer(new Duration(milliseconds: 77), () => animate());
    }


}

class FAQConsort extends Consort {
    FAQConsort(Element container, int x, String src, bool raffle) : super(container, x, src, raffle);

    @override
    void initTopics() {
        if(raffle) {
            chats.add("Coins!!");
            chats.add("Raffle!!");
            chats.add("thwap thwap!!",0.5);
            return;
        }
        chats.add("",5.0);
        chats.add("thwap!!",5.0);
        chats.add("thwap thwap!!",5.0);
        chats.add("seeds!!",2);
        chats.add("hi!!",2);
        chats.add("??",5);
        chats.add("i love trees!!");
        chats.add("trees!!",2);
        chats.add("fruit!!",2);
        chats.add("flowers!!",2);
        chats.add("leaves!!",2);
        chats.add("lohae has two names!!",0.3);
    }
}

class StoreConsort extends Consort {

    StoreConsort(Element container, int x, String src, bool raffle) : super(container, x, src, raffle) {
        print("store consort is go");
    }

    @override
    void initTopics() {
        chats.add("hi!!",1);
        chats.add("",5);
    }
}



class SecretConsort extends Consort {
    SecretConsort(Element container, int x,bool raffle) : super(container, x, "4037.gif", raffle) {
        imageElement.onClick.listen((Event e) {
            window.alert("!! you did it !!  you clicked my scales!! thwap thwap!! have a secret!! i don't know what it does!!");
            window.location.href = "index.html?haxMode=on";
        });
    }

    @override
    void initTopics() {
        chats.add("i am a Secret Aligator!!",10.0);
        chats.add("thwap!!",5.0);
        chats.add("click my Scales, y/n??",10.0);
    }
}

class GullConsort extends Consort {
    @override
    String chatterClass = "gullChatter";

    static List<String> choices = <String>["happy_blue.gif","happy_red.gif", "happy_yellow.gif"];
    static Random globalRand = new Random();
    GullConsort(Element container, int x, bool raffle) : super(container, x, globalRand.pickFrom(choices), raffle) {
    }

    @override
    void initTopics() {
        if(raffle) {
            chats.add("Coins!!");
            chats.add("Raffle!!");
            chats.add(seagullQuirk("boo!!!!!"),0.5);
            chats.add(seagullQuirk("sqwawk!!!!!"),0.5);

            return;
        }
        chats.add(seagullQuirk("i am so lost!!!!!"),3.0);
        chats.add(seagullQuirk("i am a spooky ghost!!!!!"),1.0);
        chats.add(seagullQuirk(" "),10.0);
        chats.add(seagullQuirk("boo!!!!!"),10.0);
        chats.add(seagullQuirk("hello!!!!!"),10.0);
        chats.add(seagullQuirk("sqwawk!!!!!"),100);
        chats.add(seagullQuirk("bears!!!!!"),10.0);
        chats.add(seagullQuirk("ducks!!!!!"),10.0);
        chats.add(seagullQuirk("please guide us!!!!!"),2.0);
        //:gigglesnort://
        chats.add(seagullQuirk("ivulz!!!!!"),1.0);
        chats.add(seagullQuirk("fenrir is so confusing!!!!!"),1.0);
        chats.add(seagullQuirk("why do you have horns?????"),1.0);
        //:gigglesnort://
        chats.add(seagullQuirk("what is 'caesar'?????"),1.0);


    }

    static String seagullQuirk(String text) {
        Random rand = new Random();
        rand.nextInt();
        text = text.toUpperCase();

        if(rand.nextDouble() > 0.6) {
            text = "SQWAWK!!!!! $text";
        }else if(rand.nextBool()) {
            text = "$text SQWAWK!!!!!";
        }
        return text;

    }
}

class SecretFAQConsort extends FAQConsort {
    SecretFAQConsort(Element container, int x,bool raffle) : super(container, x, "4037.gif", raffle) {
        imageElement.onClick.listen((Event e) {
            window.alert("!! you did it !!  you clicked my scales!! thwap thwap!! have a secret!! i don't know what it does!!");
            window.location.href = "index.html?haxMode=on";
        });
    }

    @override
    void initTopics() {
        chats.add("i am a Secret Aligator!!",10.0);
        chats.add("thwap!!",5.0);
        chats.add("hey!! hey!! wanna know a secret??",5.0);
        chats.add("click my Scales, y/n??",10.0);
    }
}