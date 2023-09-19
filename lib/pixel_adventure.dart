import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents,DragCallbacks{
  @override
  Color backgroundColor()=> const Color(0xFF211F30);

  late final CameraComponent cam;
  Player player=Player(character:'Ninja Frog');
  late JoystickComponent joystick;
  bool showJoystick=false;

  @override
  FutureOr<void> onLoad() async{
    // load images into cache
    await images.loadAllImages();
    final world=Level(

    levelName: 'level_01',
    player: player,
  );

    cam=CameraComponent.withFixedResolution(world: world,width: 640, height: 360);
  cam.viewfinder.anchor=Anchor.topLeft;
   addAll([ cam,world]);
   if (showJoystick) {
      addJoyStick();
   }
  
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(showJoystick){
       updateJoystick();
    }
   
    super.update(dt);
  }
  
  void addJoyStick() {
    joystick=JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Ellipse 2.png')),
      ),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Joystick.png')),
      ),
      margin: const EdgeInsets.only(left: 32,bottom: 32),
    );
      add(joystick);
  }
  
  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
        break;
        case JoystickDirection.upLeft:
       
        
        break;
        case JoystickDirection.downLeft:
        player.horizontalMovement=-1;
        
        break;
        
          case JoystickDirection.right:
        case JoystickDirection.upRight:
        case JoystickDirection.downRight:
        player.horizontalMovement=1;


        
        break;
        
      default:player.horizontalMovement=0;
      break;
    }
  }
}