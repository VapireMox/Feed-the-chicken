/*
 * Copyright (C) 2025 Mobile Porting Team
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package mobile.extra;

#if TOUCH_CONTROLS
import openfl.display.BitmapData;
import openfl.display.Shape;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxSignal.FlxTypedSignal;
import openfl.geom.Matrix;

/**
 * A zone with 4 hint's (A hitbox).
 * It's really easy to customize the layout.
 *
 * @author: Karim Akra and Homura Akemi (HomuHomu833)
 */
class Hitbox extends MobileInputManager
{
	static var hitboxPos(get, never):Bool;
	@:noCompletion static function get_hitboxPos():Bool {return (Options.hitboxPos.toLowerCase() == "bottom");}

	public var buttonLeft:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_LEFT]);
	public var buttonDown:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_DOWN]);
	public var buttonUp:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_UP]);
	public var buttonRight:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_RIGHT]);
	public var buttonExtra:TouchButton = new TouchButton(0, 0, [MobileInputID.EXTRA_1]);
	public var buttonExtra2:TouchButton = new TouchButton(0, 0, [MobileInputID.EXTRA_2]);

	public var instance:MobileInputManager;
	public var onButtonDown:FlxTypedSignal<TouchButton->Void> = new FlxTypedSignal<TouchButton->Void>();
	public var onButtonUp:FlxTypedSignal<TouchButton->Void> = new FlxTypedSignal<TouchButton->Void>();

	var storedButtonsIDs:Map<String, Array<MobileInputID>> = new Map<String, Array<MobileInputID>>();

	/**
	 * Create the zone.
	 */
	public function new(extraMode:Bool = false)
	{
		super();

		for (button in Reflect.fields(this))
		{
			var field = Reflect.field(this, button);
			if (Std.isOfType(field, TouchButton))
				storedButtonsIDs.set(button, Reflect.getProperty(field, 'IDs'));
		}

		if(extraMode) {
			add(buttonLeft = createHint(0, 0, Std.int(FlxG.width / 4), FlxG.height, 0xFFC24B99));
			add(buttonDown = createHint(FlxG.width / 4, 0, Std.int(FlxG.width / 4), FlxG.height, 0xFF00FFFF));
			add(buttonUp = createHint(FlxG.width / 2, 0, Std.int(FlxG.width / 4), FlxG.height, 0xFF12FA05));
			add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, Std.int(FlxG.width / 4), FlxG.height, 0xFFF9393F));
		}else {
			final fir:Int = (hitboxPos ? 0 : Std.int(FlxG.width / 4));
			final oes:Int = (hitboxPos ? Std.int(FlxG.height - FlxG.width / 4) : 0);
			add(buttonLeft = createHint(0, fir, Std.int(FlxG.width / 4), Std.int(FlxG.height - FlxG.width / 4), 0xFFC24B99, !hitboxPos));
			add(buttonDown = createHint(FlxG.width / 4, fir, Std.int(FlxG.width / 4), Std.int(FlxG.height - FlxG.width / 4), 0xFF00FFFF, !hitboxPos));
			add(buttonUp = createHint(FlxG.width / 2, fir, Std.int(FlxG.width / 4), Std.int(FlxG.height - FlxG.width / 4), 0xFF12FA05, !hitboxPos));
			add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), fir, Std.int(FlxG.width / 4), Std.int(FlxG.height - FlxG.width / 4), 0xFFF9393F, !hitboxPos));
			add(buttonExtra = createHint(0, oes, Std.int(FlxG.width), Std.int(FlxG.width / 4), 0xA6FF00, hitboxPos));
		}

		for (button in Reflect.fields(this))
		{
			if (Std.isOfType(Reflect.field(this, button), TouchButton))
				Reflect.setProperty(Reflect.getProperty(this, button), 'IDs', storedButtonsIDs.get(button));
		}

		storedButtonsIDs.clear();
		scrollFactor.set();
		updateTrackedButtons();

		instance = this;
	}

	/**
	 * Clean up memory.
	 */
	override function destroy()
	{
		super.destroy();
		onButtonUp.destroy();
		onButtonDown.destroy();

		for (fieldName in Reflect.fields(this))
		{
			var field = Reflect.field(this, fieldName);
			if (Std.isOfType(field, TouchButton))
				Reflect.setField(this, fieldName, FlxDestroyUtil.destroy(field));
		}
	}

	function createHint(X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFFFF, downscroll:Bool = false):TouchButton {
		var hintTween:FlxTween = null;
		var hintLaneTween:FlxTween = null;
		var hint = new TouchButton(X, Y);
		hint.loadGraphic(createHintGraphic(Width, Height));
		hint.color = Color;
		hint.solid = false;
		hint.immovable = true;
		hint.multiTouch = true;
		hint.moves = false;
		hint.scrollFactor.set();
		hint.alpha = 0.00001;
		hint.antialiasing = Options.antialiasing;
		hint.label = new FlxSprite();
		hint.labelStatusDiff = (Options.hitboxType != "hidden") ? Options.controlsAlpha : 0.00001;
		hint.label.loadGraphic(createHintGraphic(Width, Math.floor(Height * 0.035), true));
		hint.label.color = Color;
		hint.label.offset.y -= (downscroll ? hint.height - hint.label.height : 0);
		if (Options.hitboxType != 'hidden')
		{
			hint.onDown.callback = function()
			{
				if (hintTween != null)
					hintTween.cancel();

				if (hintLaneTween != null)
					hintLaneTween.cancel();

				hintTween = FlxTween.tween(hint, {alpha: Options.controlsAlpha}, Options.controlsAlpha / 100, {
					ease: FlxEase.circInOut,
					onComplete: (twn:FlxTween) -> hintTween = null
				});

				hintLaneTween = FlxTween.tween(hint.label, {alpha: 0.00001}, Options.controlsAlpha / 10, {
					ease: FlxEase.circInOut,
					onComplete: (twn:FlxTween) -> hintLaneTween = null
				});
			}

			hint.onOut.callback = hint.onUp.callback = function()
			{
				if (hintTween != null)
					hintTween.cancel();

				if (hintLaneTween != null)
					hintLaneTween.cancel();

				hintTween = FlxTween.tween(hint, {alpha: 0.00001}, Options.controlsAlpha / 10, {
					ease: FlxEase.circInOut,
					onComplete: (twn:FlxTween) -> hintTween = null
				});

				hintLaneTween = FlxTween.tween(hint.label, {alpha: Options.controlsAlpha}, Options.controlsAlpha / 100, {
					ease: FlxEase.circInOut,
					onComplete: (twn:FlxTween) -> hintLaneTween = null
				});
			}
		}

		return hint;
	}

	function createHintGraphic(Width:Int, Height:Int, ?isLane:Bool = false):BitmapData {
		var guh = Options.controlsAlpha;
		if (guh >= 0.9)
			guh = Options.controlsAlpha - 0.07;
		var shape:Shape = new Shape();
		shape.graphics.beginFill(0xFFFFFFFF);
		if (Options.hitboxType == "noGradient")
		{
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(Width, Height, 0, 0, 0);

			if (isLane)
				shape.graphics.beginFill(0xFFFFFFFF);
			else
				shape.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFFFF, 0xFFFFFFFF], [0, 1], [60, 255], matrix, PAD, RGB, 0);
			shape.graphics.drawRect(0, 0, Width, Height);
			shape.graphics.endFill();
		}
		else if (Options.hitboxType == 'gradient')
		{
			shape.graphics.lineStyle(3, 0xFFFFFFFF, 1);
			shape.graphics.drawRect(0, 0, Width, Height);
			shape.graphics.lineStyle(0, 0, 0);
			shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
			shape.graphics.endFill();
			if (isLane)
				shape.graphics.beginFill(0xFFFFFFFF);
			else
				shape.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFFFF, FlxColor.TRANSPARENT], [1, 0], [0, 255], null, null, null, 0.5);
			shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
			shape.graphics.endFill();
		}
		else //if (Options.hitboxType == "noGradientOld")
		{
			shape.graphics.lineStyle(10, 0xFFFFFFFF, 1);
			shape.graphics.drawRect(0, 0, Width, Height);
			shape.graphics.endFill();
		}
		var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
		bitmap.draw(shape);
		return bitmap;
	}
}
#end