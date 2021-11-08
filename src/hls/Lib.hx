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
			path = (defValue != "1") ? defValue : findHlsjsFile();
			includeHlsjsFile( path );
		}
	}

	static function includeHlsjsFile( ?path : String ) {
		if( path == null )
			path = findHlsjsFile();
		if( path == null )
			throw 'hls.js file not found';
		Compiler.includeFile( path );
	}

	private static function findHlsjsFile() : String {
		for( cp in Context.getClassPath() ) {
			if( cp.indexOf( '/hls-haxe' )>1) {
				cp = cp.substr( 0, cp.length - 5 );
				return '$cp/$INCLUDE_PATH/hls.'+(Context.defined( 'debug' ) ? 'js' : 'js');
			}
		}
		return null;
	}

	#end

	macro public static function include( ?path : String ) {
		includeHlsjsFile( path );
		return macro null;
	}
}
