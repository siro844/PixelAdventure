import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState{
idle,running
}
enum PlayerDirection{
  left,right,none
}
class Player extends SpriteAnimationGroupComponent with HasGameRef<PixelAdventure>{
  String character;
  Player({position,required this.character}) :super(position: position);
  
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime=0.05;


  PlayerDirection playerDirection =PlayerDirection.none;

  double moveSpeed=100;
  Vector2 velocity =Vector2.zero();


  @override
  FutureOr<void> onLoad() {
   _loadAllAnimations();
    return super.onLoad();
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
}