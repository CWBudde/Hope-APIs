unit ECMA.RegEx;

interface

type
  JRegExFlags = class external
    global: Boolean;
    ignoreCase: Boolean;
    multiline: Boolean;
    unicode: Boolean;
    sticky: Boolean;
  end; 

  JRegExp = class external 'RegExp'
  public
    flags: JRegexFlags; 
    global: Boolean;
    ignoreCase: Boolean;
    multiline: Boolean;
    source: String;
    sticky: Boolean;
    unicode: Boolean;
    
    constructor Create(pattern: String); overload;
    constructor Create(pattern: String; flags: String); overload;
    function exec(value: String): Variant;
    function execAsStrings(value: String): array of string; external 'exec';
    function test(value: Variant): Boolean;
    function toSource: String; // non-standard
    function toString: String;
    procedure compile(pattern: String; flags: String);
    class function input: String;
    class function lastMatch: String;
    class function lastParen: String;
    class function leftContext: String;
    class function rightContext: String;
  end;