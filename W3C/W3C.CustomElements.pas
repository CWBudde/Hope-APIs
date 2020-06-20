unit W3C.CustomElements;

interface

uses
  ECMA.Promise, W3C.DOM4, W3C.HTML5;

type
  JElementDefinitionOptions = class external 'ElementDefinitionOptions'
  public
    extends: String;
  end;

  JCustomElementRegistry = class external 'CustomElementRegistry'
  public
    procedure define(&name: String; &constructor: Variant); overload; { CEReactions }
    procedure define(&name: String; &constructor: Variant; options: JElementDefinitionOptions); overload; { CEReactions }
    function get(&name: String): Variant;
    function whenDefined(&name: String): JPromise;
  end;

  JWindow = partial class external 'Window'
  public
    customElements: JCustomElementRegistry;
  end;

  JDocument = partial class external 'Document'
  public
    procedure registerElement(&name: String; &constructor: procedure); deprecated 'use window.customElements.define'; { CEReactions }
  end;