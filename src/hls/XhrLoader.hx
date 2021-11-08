package hls;

import js.html.XMLHttpRequest;

/**
 * ...
 * @author bai
 */
extern class XhrLoader implements hls.IHlsLoader
{

	function new(config:Dynamic);
	
	
	function load(url:String, responseType:String, onSuccess:Void->Void, onError:Void->Void, timeout:UInt, maxRetry:UInt, retryDelay:UInt):Void;  //TODO: onProgress and frag is missing
	
	function abort():Void;
	
	function destroy():Void;
	
	function loadInternal():Void;
	
}