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

import funkin.backend.MusicBeatState;
import funkin.backend.scripting.LuaScript;
import funkin.backend.scripting.lua.utils.ILuaScriptable;
import funkin.backend.system.Controls;
import funkin.backend.system.Logs;
import lime.ui.Haptic;

#if ENABLE_LUA
final class MobileFunctions
{
	public static function getMobileFunctions(instance:ILuaScriptable, ?script:LuaScript):Map<String, Dynamic>
	{
		return [
			#if TOUCH_CONTROLS
			"touchC" => function()
			{
				return Controls.instance.touchC;
			},
			"mobileControlsMode" => function()
			{
				return "hitbox";
			},
			"extraHintPressed" => function(hint:String)
			{
				hint = hint.toLowerCase();

				if (MusicBeatState.getState().hitbox != null)
					switch (hint)
					{
						case 'second':
							return MusicBeatState.getState().hitbox.buttonExtra2.pressed;
						default:
							return MusicBeatState.getState().hitbox.buttonExtra.pressed;
					}

				return false;
			},
			"extraHintJustPressed" => function(hint:String)
			{
				hint = hint.toLowerCase();

				if (MusicBeatState.getState().hitbox != null)
					switch (hint)
					{
						case 'second':
							return MusicBeatState.getState().hitbox.buttonExtra2.justPressed;
						default:
							return MusicBeatState.getState().hitbox.buttonExtra.justPressed;
					}

				return false;
			},
			"extraHintJustReleased" => function(hint:String)
			{
				hint = hint.toLowerCase();

				if (MusicBeatState.getState().hitbox != null)
					switch (hint)
					{
						case 'second':
							return MusicBeatState.getState().hitbox.buttonExtra2.justReleased;
						default:
							return MusicBeatState.getState().hitbox.buttonExtra.justReleased;
					}

				return false;
			},
			"extraHintReleased" => function(hint:String)
			{
				hint = hint.toLowerCase();

				if (MusicBeatState.getState().hitbox != null)
					switch (hint)
					{
						case 'second':
							return MusicBeatState.getState().hitbox.buttonExtra2.released;
						default:
							return MusicBeatState.getState().hitbox.buttonExtra.released;
					}

				return false;
			},
			#end
			"vibrate" => function(duration, period)
			{
				if (duration == null)
				{
					return Logs.trace('vibrate: No duration specified.', ERROR);
				}
				return Haptic.vibrate(period ?? 0, duration);
			}
		];
	}
}
#end