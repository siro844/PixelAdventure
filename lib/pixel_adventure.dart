import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents{
  @override
  Color backgroundColor()=> const Color(0xFF211F30);
  final world=Level(
    levelName: 'level_02',
  );

  late final CameraComponent cam;
  @override
  FutureOr<void> onLoad() async{
    // load images into cache
    await images.loadAllImages();

    cam=CameraComponent.withFixedResolution(world: world,width: 640, height: 360);
  cam.viewfinder.anchor=Anchor.topLeft;
   addAll([ cam,world]);
   
    return super.onLoad();
  }
}