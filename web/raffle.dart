import 'dart:async';
import 'dart:html';
import "scripts/Consort.dart";
import 'package:CommonLib/NavBar.dart';

Element output = querySelector('#strip');


Future<Null> main() async {
  Consort.spawnRaffleConsorts(output, true, false);
  AudioElement bgAudio = querySelector('#bgAudio');

  window.onClick.listen((Event e) {
    bgAudio.play();
  });
}