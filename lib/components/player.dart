import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState{
idle,running
}
enum PlayerDirection{
  left,right,none
}
class Player extends SpriteAnimationGroupComponent with HasGameRef<PixelAdventure>,KeyboardHandler{
  String character;
  Player({position,required this.character}) :super(position: position);
  
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime=0.05;


  PlayerDirection playerDirection =PlayerDirection.none;

  double moveSpeed=100;
  Vector2 velocity =Vector2.zero();
  bool isFacingRight=true;
   

  @override
  FutureOr<void> onLoad() {
   _loadAllAnimations();
    return super.onLoad();
  }

  @override  //happens every frame dt:delta time
  // this function will update as many frames it can upgrade
  // dt allows us to check how many we have updated in a second
  // we divide it by correct amount so that we get same amount of frames we wil be updateing for
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRighttKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight);
    
    if(isLeftKeyPressed && isRighttKeyPressed){
      playerDirection=PlayerDirection.none;
    }
    else if(isLeftKeyPressed){
    playerDirection=PlayerDirection.left;
    }
    else if(isRighttKeyPressed){
      playerDirection=PlayerDirection.right;
    }
    else{
      playerDirection=PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }
  
  void _loadAllAnimations() {
//game is object of pixel adventure class
    idleAnimation=_spriteAnimation('Idle',11);

       runningAnimation=_spriteAnimation('Run',12);
      // list of all animations
    animations={
      PlayerState.idle:idleAnimation,
      PlayerState.running:runningAnimation,
    };
    // set current animation
    current=PlayerState.running;
  }


 SpriteAnimation _spriteAnimation(String state,int amount){
 return SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/$character/$state (32x32).png') ,
    SpriteAnimationData.sequenced(
      amount: amount,
     stepTime: stepTime,
      textureSize: Vector2.all(32),
      )
      );
}

  void _updatePlayerMovement(double dt) {
      double dirX= 0.0;
      switch (playerDirection) {
        case PlayerDirection.left:
        if(isFacingRight){
          flipHorizontallyAroundCenter();
          isFacingRight=false;
        }
        current=PlayerState.running;
            dirX-=moveSpeed;
          break;

          case PlayerDirection.right:
          if(!isFacingRight){
            flipHorizontallyAroundCenter();
            isFacingRight=true;
          }
          current=PlayerState.running;
            dirX+=moveSpeed;

          break;
          
          case PlayerDirection.none:
          current=PlayerState.idle;

          break;

        default:
      }
      velocity=Vector2(dirX, 0.0);
      position+=velocity *dt;
  }
}