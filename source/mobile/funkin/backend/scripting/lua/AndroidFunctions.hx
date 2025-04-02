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

package mobile.funkin.backend.scripting.lua;

import funkin.backend.scripting.LuaScript;
import funkin.backend.scripting.lua.utils.ILuaScriptable;
import funkin.backend.system.Logs;
#if android
import mobile.funkin.backend.utils.CodenameJNI;
#end

#if ENABLE_LUA
final class AndroidFunctions
{
	public static function getAndroidFunctions(instance:ILuaScriptable, ?script:LuaScript):Map<String, Dynamic>
	{
		#if android
		return [
			/*"isRooted" => function()
				{
					return AndroidTools.isRooted();
			},*/
			"isDolbyAtmos" => function()
			{
				return AndroidTools.isDolbyAtmos();
			},
			"isAndroidTV" => function()
			{
				return AndroidTools.isAndroidTV();
			},
			"isTablet" => function()
			{
				return AndroidTools.isTablet();
			},
			"isChromebook" => function()
			{
				return AndroidTools.isChromebook();
			},
			"isDeXMode" => function()
			{
				return AndroidTools.isDeXMode();
			},
			"backJustPressed" => function()
			{
				return FlxG.android.justPressed.BACK;
			},
			"backPressed" => function()
			{
				return FlxG.android.pressed.BACK;
			},
			"backJustReleased" => function()
			{
				return FlxG.android.justReleased.BACK;
			},
			"menuJustPressed" => function()
			{
				return FlxG.android.justPressed.MENU;
			},
			"menuPressed" => function()
			{
				return FlxG.android.pressed.MENU;
			},
			"menuJustReleased" => function()
			{
				return FlxG.android.justReleased.MENU;
			},
			"getCurrentOrientation" => function()
			{
				return CodenameJNI.getCurrentOrientationAsString();
			},
			"setOrientation" => function(hint:String)
			{
				switch (hint.toLowerCase())
				{
					case 'portrait':
						hint = 'Portrait';
					case 'portraitupsidedown' | 'upsidedownportrait' | 'upsidedown':
						hint = 'PortraitUpsideDown';
					case 'landscapeleft' | 'leftlandscape':
						hint = 'LandscapeLeft';
					case 'landscaperight' | 'rightlandscape' | 'landscape':
						hint = 'LandscapeRight';
					default:
						hint = null;
				}

				if (hint == null)
					return Logs.trace('setOrientation: No orientation specified.', ERROR);

				CodenameJNI.setOrientation(FlxG.stage.stageWidth, FlxG.stage.stageHeight, false, hint);
			},
			"minimizeWindow" => function()
			{
				return AndroidTools.minimizeWindow();
			},
			"showToast" => function(text:String, duration, xOffset = 0, yOffset = 0)
			{
				if (text == null)
					return Logs.trace('showToast: No text specified.', ERROR);

				if (duration == null)
					return Logs.trace('showToast: No duration specified.', ERROR);

				return AndroidToast.makeText(text, duration, -1, xOffset, yOffset);
			},
			"isScreenKeyboardShown" => function()
			{
				return CodenameJNI.isScreenKeyboardShown();
			},
			"clipboardHasText" => function()
			{
				return CodenameJNI.clipboardHasText();
			},
			"clipboardGetText" => function()
			{
				return CodenameJNI.clipboardGetText();
			},
			"clipboardSetText" => function(text:String)
			{
				if (text == null)
					return Logs.trace('clipboardSetText: No text specified.', ERROR);

				CodenameJNI.clipboardSetText(text);
			},
			"manualBackButton" => function()
			{
				return CodenameJNI.manualBackButton();
			},
			"setActivityTitle" => function(text:String)
			{
				if (text == null)
					return Logs.trace('setActivityTitle: No text specified.', ERROR);

				CodenameJNI.setActivityTitle(text);
			},
		];
		#else
		return [];
		#end
	}
}
#end