package hls;

#if macro
import haxe.macro.Context;
import haxe.macro.Compiler;

using StringTools;
#end

class Lib {

	#if macro

	static inline var INCLUDE_FLAG = "hls_include";
	static inline var INCLUDE_PATH = "lib";

	static function build() {
		if( Context.defined( INCLUDE_FLAG ) ) {
			var path : String = null;
			var defValue = Context.definedValue( INCLUDE_FLAG );
			path = (defValue != "1") ? defValue : findThreejsFile();
			includeThreejs( path );
		}
	}

	static function includeThreejs( ?path : String ) {
		if( path == null )
			path = findThreejsFile();
		if( path == null )
			throw 'hls.js file not found';
		Compiler.includeFile( path );
	}

	private static function findThreejsFile() : String {
		for( cp in Context.getClassPath() ) {
			if( cp.endsWith( '/hls.js-extern/src/' ) ) {
				cp = cp.substr( 0, cp.length - 5 );
				return '$cp/$INCLUDE_PATH/hls.'+(Context.defined( 'debug' ) ? 'js' : 'js');
			}
		}
		return null;
	}

	#end

	macro public static function include( ?path : String ) {
		includeThreejs( path );
		return macro null;
	}
}
