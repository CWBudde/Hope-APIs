unit WHATWG.Fetch;

interface

uses
  ECMA.Promise, ECMA.TypedArray, WHATWG.DOM, WHATWG.HTML, W3C.FileAPI;

type
  JHeadersInit = array of array of String;

  // Exposed=( Window , Worker)
  JHeaders = class external 'Headers'
  public
    constructor Create; overload;
    constructor Create(init: JHeadersInit); overload;

    procedure append(&name, value: String);
    procedure delete(&name: String);
    function get(&name: String): String;
    function has(&name: String): Boolean;
    procedure set(&name: String; value: String);

    // property iterable[key: String]: String read get write set; default;
  end;

  JBodyInit = Variant;
  JResponseBodyInit = Variant;

  // NoInterfaceObject,Exposed=( Window , Worker)
  JBody = class external 'Body'
  public
    function arrayBuffer: JPromiseArrayBuffer; { NewObject }
    function blob: JBlob; { NewObject }
// TODO    function formData: FormData; { NewObject }
    function json: JPromise; { NewObject }
    function text: JPromiseString; { NewObject }

    property bodyUsed: Boolean; // read only
  end;

  TRequestInfo = Variant; // TODO

  JRequestType = String;
  JRequestTypeHelper = strict helper for JRequestType
    const Audio = 'audio';
    const Font = 'font';
    const Image = 'image';
    const Script = 'script';
    const Style = 'style';
    const Track = 'track';
    const Video = 'video';
  end;

  JRequestDestination = String;
  JRequestDestinationHelper = strict helper for JRequestDestination
    const Document = 'document';
    const Embed = 'embed';
    const Font = 'font';
    const Image = 'image';
    const Manifest = 'manifest';
    const Media = 'media';
    const &Object = 'object';
    const Report = 'report';
    const Script = 'script';
    const Serviceworker = 'service-worker';
    const Sharedworker = 'shared-worker';
    const Style = 'style';
    const Worker = 'worker';
    const Xslt = 'xslt';
  end;

  JRequestMode = String;
  JRequestModeHelper = strict helper for JRequestMode
    const Navigate = 'navigate';
    const SameOrigin = 'same-origin';
    const NoOrigin = 'no-origin';
    const Cors = 'cors';
  end;

  JRequestCredentials = String;
  JRequestCredentialsHelper = strict helper for JRequestCredentials
    const Omit = 'omit';
    const SameOrigin = 'same-origin';
    const Incl = 'include';
  end;

  JRequestCache = String;
  JRequestCacheHelper = strict helper for JRequestCache
    const Default = 'default';
    const NoStore = 'no-store';
    const Reload = 'reload';
    const NoCache = 'no-cache';
    const ForceCache = 'force-cache';
    const OnlyIfCached = 'only-if-cached';
  end;

  JRequestRedirect = String;
  JRequestRedirectHelper = strict helper for JRequestRedirect
    const Follow = 'follow';
    const Error = 'error';
    const Manual = 'manual';
  end;

  JReferrerPolicy = String;
  JReferrerPolicyHelper = strict helper for JReferrerPolicy
    const None = '';
    const NoReferrer = 'no-referrer';
    const NoReferrerWhenDowngrade = 'no-referrer-when-downgrade';
    const SameOrigin = 'same-origin';
    const Origin = 'origin';
    const StrictOrigin = 'strict-origin';
    const OriginWhenCrossOrigin = 'origin-when-cross-origin';
    const StrictOriginWhenCrossOrigin = 'strict-origin-when-cross-origin';
    const UnsafeUrl = 'unsafe-url';
  end;

  JRequestInit = class external 'RequestInit'
  public
    &method: String;
    headers: JHeadersInit;
    body: JBodyInit;
    referrer: String;
    referrerPolicy: JReferrerPolicy;
    mode: JRequestMode;
    credentials: JRequestCredentials;
    cache: JRequestCache;
    redirect: JRequestRedirect;
    integrity: String;
    keepalive: Boolean;
    window: Variant;
  end;

  // Exposed=( Window , Worker)
  JRequest = class external 'Request'
  public
    &method: String;
    url: String;
    headers: JHeaders; { SameObject }
    &type: JRequestType;

    destination: JRequestDestination;
    referrer: String;
    referrerPolicy: JReferrerPolicy;
    mode: JRequestMode;
    credentials: JRequestCredentials;
    cache: JRequestCache;
    redirect: JRequestRedirect;
    integrity: String;
    keepalive: Boolean;
    constructor Create(input: JRequest); overload;
    constructor Create(input: String); overload;
    constructor Create(input: JRequest; init: JRequestInit); overload;
    constructor Create(input: String; init: JRequestInit); overload;
    function clone: JRequest; { NewObject }
  end;

  JResponseType = String;
  JResponseTypeHelper = strict helper for JResponseType
    const Basic = 'basic';
    const Cors = 'cors';
    const Default = 'default';
    const Error = 'error';
    const Opaque = 'opaque';
    const OpaqueRedirect = 'opaque-redirect';
  end;

  JResponseInit = class external 'ResponseInit'
  public
    status: Integer;
    statusText: String;
    headers: JHeadersInit;
  end;

  TOnFulFilledHeaders = procedure(response: JHeaders);

  JPromiseHeaders = class external 'Promise' (JPromise)
  public
    constructor Create(Executor: procedure(resolve: TOnFulFilledHeaders; reject: TOnRejected));
    class function resolve(value: JHeaders): JPromiseHeaders;

    function &then(onFulfilled: TOnFulFilledHeaders): JPromiseHeaders; overload;
    function &then(onFulfilled: TOnFulFilledHeaders; onRejected: TOnRejected): JPromiseHeaders; overload;
  end;

  // Exposed=( Window , Worker)
  JResponse = class external 'Response' (JBody)
  public
    &type: JResponseType;
    url: String;
    redirected: Boolean;
    status: Integer;
    ok: Boolean;
    statusText: String;
    headers: JHeaders; { SameObject }
    trailer: JPromiseHeaders;
    constructor Create; overload;
    constructor Create(body: JResponseBodyInit); overload;
    constructor Create(init: JResponseInit); overload;
    constructor Create(body: JResponseBodyInit; init: JResponseInit); overload;
    function error: JResponse; { NewObject }
    function redirect(url: String; status: Integer = 302): JResponse; { NewObject }
    function clone: JResponse; { NewObject }
  end;

  TOnFulFillResponse = procedure(response: JResponse);

  JPromiseResponse = class external 'Promise' (JPromise)
  public
    constructor Create(Executor: procedure(resolve: TOnFulFillResponse; reject: TOnRejected));
    class function resolve(value: JResponse): JPromiseResponse;

    function &then(onFulfilled: TOnFulFillResponse): JPromiseResponse; overload;
    function &then(onFulfilled: TOnFulFillResponse; onRejected: TOnRejected): JPromiseResponse; overload;
  end;

  JWindowOrWorkerGlobalScope = partial class external 'WindowOrWorkerGlobalScope'
  public
    function fetch(input: TRequestInfo): JResponse; overload; { NewObject }
    function fetch(input: TRequestInfo; init: JRequestInit): JResponse; overload; { NewObject }
  end;