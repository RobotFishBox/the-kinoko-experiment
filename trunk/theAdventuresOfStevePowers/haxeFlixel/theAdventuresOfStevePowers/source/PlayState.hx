package;

import flash.Lib;
import openfl.Assets;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxMath;
import flixel.util.FlxRect;
import flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var bg:FlxSprite;
	private var map:FlxTilemap;

	private var player:Player;
	private var enemyGroup:FlxGroup;

	private var collectables_layer:FlxGroup;
	private var bullets_layer:FlxGroup;
	private var bullet_delay:Int;

	private var healthBar:FlxSprite;
	private var txtScore:FlxText;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		bg = new FlxSprite(0, 0, 'assets/images/mountain.jpg');
		bg.scrollFactor.x = .6;
		bg.scrollFactor.y = .6;
		add(bg);

		map = new FlxTilemap();
		map.loadMap(Assets.getText('assets/data/map2.txt'), 
			'assets/images/tiles.png');
		add(map);

		player = new Player();
		add(player);

		player.setStageSize(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);

		//makeEnemies();

		collectables_layer = new FlxGroup();
		add(collectables_layer);

		bullets_layer = new FlxGroup();
		add(bullets_layer);

		bullet_delay = 20;

		for (i in 0 ... 10) {
			var collectible:FlxSprite = new FlxSprite(
				Math.random() * map.width,
				Math.random() * map.height);
			collectible.loadGraphic('assets/images/collectible.png');
			collectables_layer.add(collectible);
		}

		healthBar = new FlxSprite(5, 5);
		healthBar.makeGraphic(1, 12, 0xffff0000);
		healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
		healthBar.origin.x = healthBar.origin.y = 0;
		healthBar.scale.x = 48;	// fill health bar to max
		healthBar.x = 30;
		add (healthBar);

		txtScore = new FlxText(0, 0, 50);
		txtScore.text = Std.string(Reg.score);
		txtScore.scrollFactor.x = 0;
		txtScore.scrollFactor.y = 0;
		add(txtScore);

		//FlxG.sound.playMusic('assets/music/sycamore_drive_kicks.ogg');

		FlxG.camera.follow(player);
		// for some reason the background is already initiated
		FlxG.worldBounds.x = 0;
		FlxG.worldBounds.y = 0;
		FlxG.worldBounds.width = map.width;
		FlxG.worldBounds.height = map.height;

		FlxG.debugger.drawDebug = true;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	private function makeEnemies():Void {
		enemyGroup = new FlxGroup();
		add(enemyGroup);

		var enemy:Enemy = new Enemy();
		enemy.setTarget(player);
		enemy.x = 500;
		enemy.y = 100;
		enemyGroup.add(enemy);

		enemy = new Enemy();
		enemy.setTarget(player);
		enemy.x = 200;
		enemy.y = 500;
		enemyGroup.add(enemy);

		enemy = new Enemy();
		enemy.setTarget(player);
		enemy.x = 900;
		enemy.y = 300;
		enemyGroup.add(enemy);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.collide(map, player);
		FlxG.overlap(player, collectables_layer, playerHitCollectible);

		FlxG.collide(map, enemyGroup);
		FlxG.overlap(player, enemyGroup, playerHitEnemy, null);

		healthBar.scale.x = (player.health / 100) * 48;

		bullet_delay--;
		if (player.attack() && bullet_delay < 0) {
			bullet_delay = 20;

			var bullet:FlxSprite = new FlxSprite();
			bullet.loadGraphic('assets/images/bullet.png', false, true);
			bullet.x = player.x;
			bullet.y = player.y;
			bullet.facing = player.facing;
			bullet.velocity.x = (player.facing == FlxObject.LEFT ? -1 : 1) * 150;
			bullets_layer.add(bullet);
		}

		FlxG.overlap(bullets_layer, enemyGroup, bulletHitEnemy);
		FlxG.collide(bullets_layer, map, bulletHitMap);
	}

	function playerHitCollectible(playerRef:FlxObject, collectibleRef:FlxObject):Void {
		collectables_layer.remove(collectibleRef);
		Reg.score++;
		txtScore.text = Std.string(Reg.score);

		FlxG.sound.play('Get');
	}

	function playerHitEnemy(playerRef:FlxObject, enemyRef:FlxObject):Void {
		FlxSpriteUtil.flicker(playerRef);
		enemyGroup.remove(enemyRef);
		playerRef.health -= 10;
	}

	function bulletHitEnemy(bulletRef:FlxObject, enemyRef:FlxObject):Void {
		bullets_layer.remove(bulletRef);
		enemyGroup.remove(enemyRef);
	}

	function bulletHitMap(bulletRef:FlxObject, mapRef:FlxObject):Void {
		bullets_layer.remove(bulletRef);
	}
}