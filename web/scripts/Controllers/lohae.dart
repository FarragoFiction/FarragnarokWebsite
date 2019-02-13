import 'dart:async';
import 'dart:html';
import "../Consort.dart";
import 'package:CommonLib/NavBar.dart';

Element output = querySelector('#strip');


Future<Null> main() async {
    Consort.spawnConsorts(output, true, false);
    loadNavbar();
    AudioElement bgAudio = querySelector('#bgAudio');

    window.onClick.listen((Event e) {
        bgAudio.play();
    });
}



