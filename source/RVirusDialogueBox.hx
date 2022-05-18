package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;

using StringTools;

class RVirusDialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';
	var curAnim:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	var swagDialogue:FlxTypeText;
	var skiptext:FlxText;
	var canskip:Bool = false;

	public var finishThing:Void->Void;

	var portraitBF:FlxSprite;
	var portraitGF:FlxSprite;
	var portraitR:FlxSprite;
	var portraitAce:FlxSprite;

	var cg1:FlxSprite;
	var cg2:FlxSprite;
	var cg3:FlxSprite;
	var cg4:FlxSprite;

	var blackbg:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			canskip = true;
		});

		box = new FlxSprite(0, 0);
		box.frames = Paths.getSparrowAtlas('dialogue/DialogBox_R');
		box.animation.addByPrefix('normalOpen', 'DialogBox_R', 24, false);
		box.animation.addByIndices('normal', 'DialogBox_R', [4], "", 24);
		
		box.animation.play('normalOpen');

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'malfunction':
				box.visible = false;
				blackbg = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
				add(blackbg);
			case 'invade':
				box.visible = false;
				
		}
	

		this.dialogueList = dialogueList;

		cg1 = new FlxSprite(0, 0).loadGraphic(Paths.image('dialogue/1'));
		cg1.setGraphicSize(Std.int(cg1.width * 0.67));
		cg1.updateHitbox();
		cg1.alpha = 0;
		add(cg1);

		cg2 = new FlxSprite(0, 0).loadGraphic(Paths.image('dialogue/2'));
		cg2.setGraphicSize(Std.int(cg2.width * 0.67));
		cg2.updateHitbox();
		cg2.alpha = 0;
		add(cg2);

		cg3 = new FlxSprite(0, 0).loadGraphic(Paths.image('dialogue/3'));
		cg3.setGraphicSize(Std.int(cg3.width * 0.67));
		cg3.updateHitbox();
		cg3.alpha = 0;
		add(cg3);

		cg4 = new FlxSprite(0, 0).loadGraphic(Paths.image('dialogue/4'));
		cg4.setGraphicSize(Std.int(cg4.width * 0.67));
		cg4.updateHitbox();
		cg4.alpha = 0;
		add(cg4);

		portraitBF = new FlxSprite(180, -270);
		portraitBF.frames = Paths.getSparrowAtlas('dialogue/portrait');
		portraitBF.animation.addByPrefix('awesome', 'BFawesome', 24, false);
		portraitBF.animation.addByPrefix('afraid', 'BFhaipa', 24, false);
		portraitBF.animation.addByPrefix('surprised', 'BFjingdao', 24, false);
		portraitBF.animation.addByPrefix('sad', 'BFsad', 24, false);
		portraitBF.animation.addByPrefix('normal', 'BFzhengchang', 24, false);
		add(portraitBF);
		portraitBF.visible = false;

		portraitGF = new FlxSprite(160, -250);
		portraitGF.frames = Paths.getSparrowAtlas('dialogue/portrait');
		portraitGF.animation.addByPrefix('smile', 'GFsmile0', 24, false);
		portraitGF.animation.addByPrefix('happy', 'GFsmile2', 24, false);
		portraitGF.animation.addByPrefix('worried', 'GFworry', 24, false);
		portraitGF.animation.addByPrefix('awkward', 'GFwuyu', 24, false);
		portraitGF.animation.addByPrefix('normal', 'GFzhengchang', 24, false);
		add(portraitGF);
		portraitGF.visible = false;

		portraitR = new FlxSprite(120, -210);
		portraitR.frames = Paths.getSparrowAtlas('dialogue/portrait');
		portraitR.animation.addByPrefix('angry', 'Rangry', 24, false);
		portraitR.animation.addByPrefix('sweat', 'Rliuhan', 24, false);
		portraitR.animation.addByPrefix('sad', 'Rsad', 24, false);
		portraitR.animation.addByPrefix('smile', 'Rsmile', 24, false);
		portraitR.animation.addByPrefix('normal', 'Rzhengchang', 24, false);
		add(portraitR);
		portraitR.visible = false;

		portraitAce = new FlxSprite(120, -210);
		portraitAce.frames = Paths.getSparrowAtlas('dialogue/portrait');
		portraitAce.animation.addByPrefix('angry', 'Aceangry', 24, false);
		portraitAce.animation.addByPrefix('impatient', 'Acebunaifan', 24, false);
		portraitAce.animation.addByPrefix('sigh', 'Acewuyu', 24, false);
		portraitAce.animation.addByPrefix('smile', 'Aceyouhe', 24, false);
		portraitAce.animation.addByPrefix('normal', 'Acezhengchang', 24, false);
		add(portraitAce);
		portraitAce.visible = false;

		add(box);

		box.screenCenter(X);

		swagDialogue = new FlxTypeText(210, 450, Std.int(FlxG.width * 0.68), "", 36);
		swagDialogue.setFormat("assets/fonts/CooperBlack.otf", swagDialogue.size);
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		skiptext = new FlxText(0, 0, 0, "", 20);
		skiptext.color = 0xFFFFFFFF;
		skiptext.text = 'Press SPACE / BACK to skip';
		skiptext.setFormat("assets/fonts/CooperBlack.otf", skiptext.size);
			
		skiptext.alpha = 0;
		skiptext.x = FlxG.width - (skiptext.width + 20);
		add(skiptext);	
		FlxTween.tween(skiptext, {alpha: 1}, 1);

		dialogue = new Alphabet(0, 80, "", false, true);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.SPACE #if android || FlxG.android.justReleased.BACK #end && canskip)
		{
			finishThing();
			kill();
		}

		#if android
        var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				justTouched = true;
			}
		}
		#end

		if(PlayerSettings.player1.controls.ACCEPT #if android || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						portraitBF.visible = false;
						portraitGF.visible = false;
						portraitR.visible = false;
						portraitAce.visible = false;
						FlxTween.tween(cg2, {alpha: 0}, 0.5);
						FlxTween.tween(cg3, {alpha: 0}, 0.5);
						swagDialogue.alpha -= 1 / 5;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		portraitBF.visible = false;
		portraitGF.visible = false;
		portraitR.visible = false;
		portraitAce.visible = false;

		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'bf':
				if (!portraitBF.visible)
					portraitBF.visible = true;
				switch(curAnim)
				{
					case 'afraid&box':
						box.visible = true;
						portraitBF.animation.play('afraid');
						blackbg.visible = false;
					default:
						portraitBF.animation.play(curAnim);
				}
			case 'gf':
				if (!portraitGF.visible)
					portraitGF.visible = true;
				switch(curAnim)
				{
					case 'awkward&box':
						box.visible = true;
						portraitGF.animation.play('awkward');
					default:
						portraitGF.animation.play(curAnim);
				}

			case 'r':
				if (!portraitR.visible)
					portraitR.visible = true;
				switch(curAnim)
				{
					case 'angry&box':
						box.visible = true;
						portraitR.animation.play('angry');
					case 'smile&box':
						box.visible = true;
						portraitR.animation.play('smile');
					default:
						portraitR.animation.play(curAnim);
				}
			case 'acesora':
				if (!portraitAce.visible)
					portraitAce.visible = true;
				switch(curAnim)
				{
					default:
						portraitAce.animation.play(curAnim);
				}
			case 'cg':
				switch(curAnim)
				{
					case '1':
						FlxTween.tween(cg1, {alpha: 1}, 0.8);
					case '2':
						box.visible = false;
						FlxTween.tween(cg1, {alpha: 0}, 0.3, {
							onComplete: function(twn:FlxTween)
							{
								FlxTween.tween(cg2, {alpha: 1}, 0.8);
							}
						});
					case '3':
						FlxTween.tween(cg3, {alpha: 1}, 0.8);
					case '4':
						box.visible = false;
						FlxTween.tween(cg4, {alpha: 1}, 0.8);
				}
				
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[0];
		curAnim = splitName[1];
		dialogueList[0] = splitName[2];
	}
}
