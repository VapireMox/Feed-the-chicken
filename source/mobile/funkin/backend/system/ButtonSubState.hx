package mobile.funkin.backend.system;

import flixel.FlxSubState;
import funkin.backend.scripting.Script;
import flixel.util.FlxDestroyUtil;

class ButtonSubState extends FlxSubState {
	public var script:Script = Script.create(Paths.script("data/scripts/editButton"));
	
	override function create() {
		initScript();
	
		call("create");
		super.create();
	}
	
	override function createPost() {
		call("postCreate");
		super.createPost();
	}
	
	override function update(elapsed:Float) {
		call("update", [elapsed]);
		super.update(elapsed);
	}
	
	override function close() {
		call("close");
		super.close();
	}
	
	override function destroy() {
		call("destroy");
		FlxDestroyUtil.destroy(script);
	}
	
	public function call(name:String, ?args:Array<Dynamic>):Dynamic {
		if(script != null) {
			return script.call(name, args);
		}
		return null;
	}
	
	private function initScript() {
		if(script == null) return;
		
		script.set("VirtualPad", mobile.extra.VirtualPad);
		script.set("Hitbox", mobile.extra.Hitbox);
		
		script.setParent(this);
		script.load();
	}
}