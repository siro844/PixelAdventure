import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/player.dart';

class Level extends World{
  final String levelName;
  final Player player;
  Level( {required this.player, required this.levelName});
late TiledComponent level;
  @override
  FutureOr<void> onLoad() async {
    level=await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level);
    final spawnPointlayer=level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    for(final spawnPoint in spawnPointlayer!.objects){
        switch (spawnPoint.class_) {
          case 'Player':
              player.position=Vector2(spawnPoint.x,spawnPoint.y);
              add(player);
            break;
          default:
        }
    }
    return super.onLoad();
  }
}