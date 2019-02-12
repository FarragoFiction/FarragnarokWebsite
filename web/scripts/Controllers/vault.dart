import 'dart:async';
import 'dart:html';
import "../Consort.dart";
Element output = querySelector('#strip');


Future<Null> main() async {
    Consort.spawnConsorts(output);
    AudioElement bgAudio = querySelector('#bgAudio');

    window.onClick.listen((Event e) {
        bgAudio.play();
    });
}



