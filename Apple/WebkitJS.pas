unit WebkitJS;

interface

uses
  W3C.DOM4, W3C.Html5;

type
  JHTMLVideoElement = partial class external 'HTMLVideoElement' (JHTMLMediaElement)
  public
    webkitDisplayingFullscreen: Boolean;
    webkitSupportsFullscreen: Boolean;
    webkitWirelessVideoPlaybackDisabled: Boolean;
    procedure webkitEnterFullscreen;
    procedure webkitExitFullscreen;
  end;

  JHTMLVideoElement = partial class external 'HTMLVideoElement' (JHTMLMediaElement)
  public
    playsInline: Boolean;
    webkitSupportsPresentationMode: Boolean;
    webkitPresentationMode: Variant;
    procedure webkitSetPresentationMode(Value: Variant);
  end;

