        ��  ��                  _  ,   �� D E F A U L T       0         <html>
<head>
<style>

	@const BUTTON_BACK_HOVER: url(theme:toolbar-button-hover) stretch;
	@const BUTTON_BACK_ACTIVE: url(theme:toolbar-button-pressed) stretch;
	@const BUTTON_BACK_CHECKED: url(theme:toolbar-button-checked) stretch;
	@const BUTTON_BACK_CHECKED_HOVER: url(theme:toolbar-button-checked-hover) stretch;
	@const BUTTON_BACK_DISABLED: url(theme:toolbar-button-disabled) stretch;

	html { background-color: window; color: windowtext; margin:0; padding:0; }
	body { margin:0; padding:0; height:*; width:*; }
	#content { width:*; height:*; border-left: 1px solid threedshadow; border-bottom: 1px solid threedshadow;}
	#cmdbar  
	{ 
		height:*; 
		width:max-intrinsic; 
		background-color: threedface;
		
		/* background-image:url(theme:rebar-band); background-repeat:stretch; */
	}
	#cmdbar > widget[type="button"]  
	{ 
	   width:28px; height:28px; 
	   foreground-repeat:no-repeat;
	   foreground-position:50% 50%;
	   padding:0;
	   margin:2px;
	   text-align:center;
	   vertical-align:middle;
	   font: 12pt "Arial Black", Verdana;
	   color: threeddarkshadow;
	   transition:none;
	   background-image: none;
	}
	#cmdbar > widget[type="button"]:hover
	{
		background: @BUTTON_BACK_HOVER;
	}
	#cmdbar > widget[type="button"]:active
	{
		background: @BUTTON_BACK_ACTIVE;
	}
	#cmdbar > widget[type="button"]:checked
	{
		background: @BUTTON_BACK_CHECKED;
	}
	#cmdbar > widget[type="button"]:checked:hover
	{
		background: @BUTTON_BACK_CHECKED_HOVER;
	}

	/*#cmdbar > widget#open { 
	  font:8.5pt Marlett;
	  text-align:right; vertical-align:bottom; 
	}*/
	
	#cmdbar > widget#open > text
	{
	  font:8.5pt Marlett;
	  margin:* 0 0 *;
	}

	#cmdbar > widget#dom-inspector
	{
	  behavior:check;
	}

	popup[role="tooltip"] 
	{ 
	  font:system;
	}

	div#status
	{
	  background-color: infobackground;
	  display:none;
	  font:system;
    overflow:hidden;
	}
	div#workarea[inspector]
	{
	  behavior:frame-set;
	  border-spacing:3px;
	}

  div#workarea[allow-drop]
  {
    outline:2px orange solid -2px;
  }

	div#workarea[inspector] > frame#content
	{
	  prototype:DOMonitor;
	}

	div#workarea[inspector] > div#status
	{
	  border: 1px solid threedshadow;
	  display:block;
	  prototype:DOMinspector;
    min-height:96px;
	}
	div#elements
	{
	  flow:horizontal;
	}
  div#elements > caption
	{
	  width:max-intrinsic;
	  padding:2px 4px;
    color:threedshadow;
	}
  div#workarea > div#status	caption
	{
    color:threedshadow;
	}
  
	div#elements > ul#current-tags 
	{
	  width:*;
	  height:*;
	  flow:h-flow;
	  padding:0;
	  margin:0;
	  //background-color: scrollbar;
	  //border-left:1px solid threedshadow;
	  //border-bottom:1px solid threedshadow;
	  padding:1px;
	}
	div#elements > ul#current-tags > text 
	{
	  color:threedshadow;
	}
	div#elements > ul#current-tags > li
	{
	  width:max-intrinsic;
	  display:block;
	  behavior:check;
	  padding:2px 4px;
	}
	div#elements > ul#current-tags > li:hover
	{
		background: @BUTTON_BACK_HOVER;
	}
	div#elements > ul#current-tags > li:active
	{
	    padding:3px 3px 1px 5px;
		background: @BUTTON_BACK_ACTIVE;
	}
	div#elements > ul#current-tags > li:checked
	{
		background: @BUTTON_BACK_CHECKED;
	}
	div#elements > ul#current-tags > li:checked:hover
	{
		background: @BUTTON_BACK_CHECKED_HOVER;
	}
  frameset#inspector-info
  {
    background-color: transparent;
    padding:3px;
  }
  frameset#inspector-info > *
  {
    height:*;
  }
  frameset#inspector-info .list
  {
    width:*;
    height:*;
  }
  frameset#inspector-info span.name
  {
    display:inline-block;
    font-weight:bold;
    white-space:nowrap;
    margin-right:10px;
    color:windowtext;
  }
  frameset#inspector-info span.value
  {
    display:inline-block;
    white-space:nowrap;
    margin-left:*;
  }
  frameset#inspector-info table caption
  {
    border-bottom: scrollbar;
  }
  frameset#inspector-info table 
  { 
    padding:2px;
    overflow-y:auto; 
    background:url(theme:edit-normal) stretch; 
  }
  frameset#inspector-info table td 
  {
    white-space:nowrap;
  }
  frameset#inspector-info table td.attr-value 
  {
    font-weight:bold;
    overflow-x: hidden;
    text-overflow:ellipsis;
  }
  frameset#inspector-info table td.attr-name 
  {
    text-align:right;
  }
 
  
</style>
<script type="text/tiscript">

    include "res:inspector.tis";

	var filename = null;
    var file_filter = "files *.htm,*.html,*.zip,*.scapp|*.HTM;*.HTML;*.ZIP;*.SCAPP|"
				 "HTML files only(*.htm,*.html)|*.HTM;*.HTML|"
				 "SCAPP files only (*.zip,*.scapp)|*.ZIP;*.SCAPP|"
				 "All Files (*.*)|*.*";

	function self#open.onClick()
	{
		var fn = view.selectFile(#open);
		if( fn ) 
		{
		  filename = fn;
		  var content = self.select("#content");
		  content.load(fn);
		}
	}
	function self#reopen.onClick()
	{
		if( filename ) 
		{
			var content = self.select("#content");
			content.load(filename);
		}
	}
	function self#open-here.onClick()
	{
		var fn = view.selectFile(#open, file_filter);
		if( fn ) 
		{
			view.load(fn);
		}
	}
	function self#open-new.onClick()
	{
	   var fn = view.selectFile(#open, file_filter);
	   if( fn ) view.open(fn);
	}
	function self#help.onClick()
	{
	   view.open(System.home("doc/main.htm"));
	}

	function self#dom-inspector.onClick()
	{
	    var workarea = self.$("div#workarea");
	    var status = workarea.$("div#status");
	    var content = workarea.$("frame#content");
	    if(this.value)
	    {
		    status.load("res:dom-inspector.htm");
		    workarea.@#inspector = true; // this has to be after load() as it will trigger Behaviors attachments.
	    }
	    else 
	    {
        workarea.@#inspector = undefined;
		    status.style.clear();
		    content.style.clear();
	    }
	}

  function self#workarea.onExchange(evt)
  {
     if( evt.type == Event.X_DRAG_ENTER && evt.draggingDataType == #file)
     {
       this.@#allow-drop = true;
       return true;
     }
     else if( evt.type == Event.X_DRAG_LEAVE )
     {
       this.@#allow-drop = undefined;
       return true;
     }
     else if( evt.type == Event.X_DRAG && evt.draggingDataType == #file)
     {
       return true;
     }
     else if( evt.type == Event.X_DROP && evt.draggingDataType == #file)
     {
       this.@#allow-drop = undefined;
       if(typeof evt.dragging == #array)
         filename = evt.dragging[0];
       else
  		   filename = evt.dragging;
		   var content = self.select("#content");
		   content.load(filename);
       return true;
     }
  }
  /*self.timer(1, function() {
    stdout.println("start event loop...");
    view.doEvent();
    stdout.println("finished.");
    return false;
  }); */
  
  function view.onStateChanged() {
    //stdout.println("start event loop...");
    //view.doEvent();
    stdout.println("finished.");
    //return false;
  }
    
  

</script>
</head>
<body style="flow:horizontal">
<div #cmdbar>
	<widget type="button" id="open" style="foreground-image:url(res:file-open.png)"  title="Open in the frame on the right">8</widget>
	<widget type="button" id="reopen" style="foreground-image:url(res:file-refresh.png)"  accesskey="!F5" title="F5 - reopen in the frame on the right"></widget>
	<widget type="button" id="open-here" style="foreground-image:url(res:file-open.png)" title="Open in the current window" />
	<widget type="button" id="open-new" style="foreground-image:url(res:file-new.png)" title="Open in a new window" />
	<widget type="button" id="help" title="Open Sciter Help browser">?</widget>
	<widget type="button" id="dom-inspector" title="DOM inspector" style="font:16pt Webdings">L</widget>
</div>
<div style="width:*;height:*" #workarea>
 <frame #content src="res:sys-info.htm"  /> <!-- content-style="inspector.css"-->
 <div #status></div>
</div>
</body>

</html>
   0   �� S Y S - I N F O         0         <html>
<head>
<style>
  html { background-color: threedhighlight threedface threedface threedhighlight ;}
  body { height:*; }
  #info { margin:10px 0 0 100%%; }
  #info th { color:threedshadow; }
  #info td:nth-child(1) { text-align:right; }
  #info td:nth-child(2) { text-align:left; background-color:window; margin:1px; border:1px solid threedshadow; }
  #about { font:8.5pt verdana; color:threeddarkshadow; text-align:center; }
  #about a { color:threeddarkshadow; }
  ul#scapplist
  {
    flow:h-flow;
    height:*;
    padding:0;
    overflow:auto;
  }
  ul#scapplist > li
  {
    display:block;
    padding:4px;
    margin:4px;
    width:max-intrinsic;
    height:*;
    text-align:center;
    behavior:button;
    prototype:LaunchButton;
  }
  ul#scapplist > li img
  {
    width:64px;
    height:64px;
  }
  ul#scapplist > li:hover
  {
    background-image:url(theme:toolbar-button-hover);
    background-repeat:expand;
  }
  ul#scapplist > li:active
  {
    background-image:url(theme:toolbar-button-pressed);
  }

  text#contrast-screen
  {
    display:none;
  }
 
  @media contrast-screen
  {
    text#contrast-screen
    {
      display:block;
    }
  }
  
  
</style>
<script type="text/tiscript">
    self.select("#version").text = String.printf("%d.%d.%d.%d", 
		  (Sciter.VERSION >> 16) & 0xffff, Sciter.VERSION & 0xffff,
		  (Sciter.REVISION >> 16) & 0xffff, Sciter.REVISION & 0xffff);
	  self.select("#user").text = Sciter.userName();
	  self.select("#machine").text = Sciter.machineName();
	  self.select("#domain").text = Sciter.machineName(true);
	  self.select("#home").text = System.home();
	  self.select("#language").text = System.language;
	  self.select("#country").text = System.country;
	  self.select("#os-type").text = System.HANDHELD_OS? "handheld":"desktop";
	  self.select("#os-version").text = System.OS;

	self.onControlEvent = function(evt)
    {
      if(evt.type == Event.HYPERLINK_CLICK)
      {
        var href = evt.target.attributes["href"];
	      if( href ) { Sciter.open(href); return true; }
      }
      return false;
    }	
	
  type LaunchButton: Behavior
  {
    function onClick()
    {
      var path = this.@#path;
      if(view.load(path))
        view.caption = this.@#caption;
    }
  }
  
  function initScappList()
  {
    var path = System.home("scapps/");
    var out = Stream.openString();
    
    function getManifestFileName(path)
    {
      var r = null;
      function cb(fn,atts) 
      {
        if(atts == System.IS_DIR) return true;
        r = path + "/" + fn;
        return false; // found, stop
      }
      System.scanFiles(path + "/*.scapp", cb);    
      return r;
    }
    
    function gotFolder(fn,atts)
    {
      if(fn like ".*") 
        return true;
      if(atts != System.IS_DIR) 
        return true;
        
      var manifestFileName = getManifestFileName( path + fn );
      //stdout << manifestFileName << "\n";
      if(!manifestFileName)
        return true;
      var manifestStream = Stream.openFile(manifestFileName,"r");
      if( !manifestStream )
        return true;
      
      var manifest = parseData(manifestStream);
      manifestStream.close();
     
      if(!manifest || !manifest.main) return true;
      out.printf("<li title='%S' path='%s' caption='%s'><img src='%s' /><br/>%S</li>",
         manifest.description,
         "file://" + path + fn + manifest.main,
         manifest.label,
         "file://" + path + fn + manifest.icon, 
         manifest.label);

      //stdout << ("file://" + path + fn + manifest.icon) << "\n";
      return true;
    }
    System.scanFiles(path + "*.*",gotFolder);
    var list = out.toString();
    if( list)
      self.select("ul#scapplist").html = list;
    out.close();
  }
  initScappList();
  
</script>
</head>
<body>
Welcome to the Sciter!
<ul #scapplist></ul>
<text #contrast-screen>Contrast Screen Detected!</text>
<table id="info">
	<tr><th colspan="2">Sciter</th></tr>
	<tr><td>version:</td>	<td id="version"></td></tr>
	<tr><td>home:</td>		<td id="home"></td></tr>
	<tr><th colspan="2">System</th></tr>
	<tr><td>OS type:</td>	<td id="os-type"></td></tr>
	<tr><td>OS version:</td> <td id="os-version"></td></tr>
	<tr><td>user:</td>		<td id="user"></td></tr>
	<tr><td>machine:</td>	<td id="machine"></td></tr>
	<tr><td>domain:</td>	<td id="domain"></td></tr>
	<tr><td>country:</td>	<td id="country"></td></tr>
	<tr><td>language:</td>	<td id="language"></td></tr>
</table>
<text id="about">Sciter includes H-SMILE (HTML/CSS) and TIScript engines of Terra Informatica Software, Inc.<br/>
Sciter also uses excellent 
<a href="http://www.antigrain.com">AGG library</a>,
<a href="http://www.garret.ru/~knizhnik/">DyBase library</a>, 
<a href="http://www.libpng.org">PNG library</a>, 
<a href="http://www.zlib.org">ZLib</a> and
<a href="http://www.ijg.org">JPEG library</a>, special credits to their authors.<br/>
&copy;2004-2008, Terra Informatica Software, Inc. All rights reserved.
</text>
</body>
</html>   8   �� D O M - I N S P E C T O R       0         <div #elements>
  <caption>Elements:</caption> 
  <ul #current-tags><text>(Use CTRL+SHIFT+Click to select element)</text></ul>
</div>
<frameset #inspector-info cols="*,*,*">
  <div>
    <caption>Style rules:</caption>
    <table .list #current-rules />
  </div>
  <div>
    <caption>Current style:</caption>
    <table .list #current-styles />
  </div>
  <div>
    <caption>Attributes:</caption>
    <widget .list #current-atts type="select"></widget>
  </div>
  <div>
    <caption>States:</caption>
    <widget .list #current-states type="select"></widget>
  </div>
  <div>
    <caption titleid="for-current-metrics">Metrics(?):</caption>
    <widget .list #current-metrics type="select"></widget>
    <button name="rel-to" type="radio" checked value="parent">parent</button>
    <button name="rel-to" type="radio" value="root">root</button>
    <button name="rel-to" type="radio" value="view">view</button>
    <button name="rel-to" type="radio" value="screen">screen</button>
    <popup #for-current-metrics style="width:300px">
     <ul>
        <li>#margin - margin box edge,</li>
        <li>#border - border box edge,</li>
        <li>#padding - padding box edge,</li>
        <li>#inner, default value - inner box edge,</li>
        <li>#content - content box edge. Content box here is outline of the content of the element and this is not  an inner box of the element. 
                    E.g. content box can be bigger than inner box if the element has overflow attribute set.</li>
        <li>#client - client area, that is #inner box minus areas taken by [optional] scrollbars.</li>
        <li>#icon - area covered by element's icon. Icon here is element's foreground image with foreground-repeat: no-repeat. 
                If element has no such image the function returns #width and #height equals to zero.</li>
      </ul>
    </popup>
  </div>
</frameset>
 �  <   P N G   F I L E - R E F R E S H         0         �PNG

   IHDR         �Z��   	pHYs  
�  
��*`0  hIDATx�c`�`D��H))��jh(2����޵k/�������k��Z��ܬ_�~��� C��<�-!a����$L�����}j�5~q�(iA��[g�� �_�b�1^?}z���暈%%��ĸ`���_v�̙� ����/�hj~3ws���Ĵ�ճg�`ꘐM�QS���F{���d��}�vq����wq����A*���fnn�LL�k'O����'ç7o>��ǽK�NX����$`�ka&&'�b�ۻ����^��S��s���B7�����YXY����ab�����S��?�zdÆ�{��}�*tC���ח�\���.��-���ޫǏ��f H(*ڃ������0��o��ξ�E/���;�Α�Y�vv`�~���àW�����7���/c1����m�KT�4���Npl���8L<�mذ@��"KRYY�A��������0`ںz���.������������)j&&��D�
�z������_�x�n���w�<��9`��|���ѯ?��m���5��m`�ع�����'����o^���a̰��-�PV6����_��[U}}��o߾����w/^�y�����><�����[�Nc	�A  ���|��s�    IEND�B`�  �  4   P N G   F I L E - N E W         0         �PNG

   IHDR         VΎW   	pHYs  �  ��o�d  =IDATx��ӿO�&&�L.�8'��BB"nn���mM/g�FR�A��1!\�1J�x����6V��Z�)G����QJ������д�:��/��彯��V9�+�8�;Sm�* B�Ѩ{C��%�l��/����1�nr��;��<fg�ɱ���C~���z}���Q��E��%H���+B}Mhh�g��W+��{��"N����A��+��Ƌa�}���\��������6m�ҷ+B��W$����%"�9D��y$��@��H�"����k#�� �D%��:vw!I�B"�A2�E:���/�j��	�A�������jh`�����Ŏ��c���X_w�5�W57_��l��� kH�
� >_4=���z�A�������
?�-� <|�����E���$ۗ���!�,W��x�S�Po�?b��a����V��[0��MM1MU?�h$^˲�,�\����)��M���5#²l���C_.�Y�,,ظ��{��(u'm���Ph���X���ǯ�s�E��� ��`0�zŲlC5�"@�r�.P�#��*ǡ?΍��%R�0    IEND�B`�   4   T I S   I N S P E C T O R       0         
var pinned = null;
var elementPresented = null;
var inspector = null;
var contentFrame = null;

class DOMonitor : Behavior
{
  function attached() { contentFrame = this; }
  function detached() { inspector = null; }
  function onMouse(evt)
  {
    //if( !inspector )
    //  return false;
    if( !pinned && evt.type == (Event.MOUSE_MOVE | Event.SINKING))
    {
      if(elementPresented !== evt.target)
        inspector.show(elementPresented = evt.target);
    }
    if( evt.type == (Event.MOUSE_DOWN | Event.SINKING) && evt.ctrlKey && evt.shiftKey )
    {
      inspector.show(elementPresented = evt.target, true);
      return true;
    }
    else if( evt.type == (Event.MOUSE_UP | Event.SINKING) && evt.ctrlKey && evt.shiftKey )
      return true;
  }
}

class DOMinspector : Behavior
{
  function attached() 
  { 
    inspector = this; 
    this.rules = this.$(table#current-rules); assert this.rules;
    this.styles = this.$(table#current-styles);
    this.states = this.$(widget#current-states);
    this.atts = this.$(widget#current-atts);
    this.metrics = this.$(widget#current-metrics);
    this.metricsRelTo = symbol(this.$(button[name='rel-to']:checked).@#value);
  }
  function detached()
  {
    this.reset();
    inspector = null; 
  }

  function show(element, pinIt = false)
  {
    var list = this.$("ul#current-tags");
    list.clear();
    var el = element;
    while(el && el !== contentFrame)
    {
      var nm = el.tag;
      var pn = el.style#prototype;
      var id = el.@#id;
      var cls = el.@#class;
      if( id )  nm += "#" + id;
      if( cls ) nm += "." + cls;
      if( pn )  nm += "::" + pn;
      var item = new Element("li", String.printf("<%s>", nm));
      item.forElement = el;
      list.insert(item,0);
      el = el.parent;
    }
    if(pinIt)
    {
      pinned = element;
      list.last.value = true;
      pinned.attributes["pinned-by-inspector"] = true;
      this.showInfo(pinned);
      this.timer(1000,this.onTimer);
    }
  }
  function onControlEvent(evt)
  {
    if( evt.type == Event.BUTTON_STATE_CHANGED && evt.target.match("ul#current-tags>li"))
      return this.onPinnedListItemClick(evt.target);
    if( evt.type == Event.BUTTON_STATE_CHANGED && evt.target.match("button[name='rel-to']"))
      return this.onRelToChanged(symbol(evt.target.@#value));
  }
  function onPinnedListItemClick(item)
  {
    if( !item.value ) // was unchecked
      this.reset();
    else // was checked
    {
      var list = this.$("ul#current-tags");
      function clearOther(it) { if(it !== item) it.value = false; }
      list.select(clearOther, "li:checked"); // remove previously checked
      if(pinned)
        pinned.attributes["pinned-by-inspector"] = undefined;
      pinned = item.forElement; // set new pin
      pinned.attributes["pinned-by-inspector"] = true;
      this.showInfo(pinned);
      this.timer(1000,this.onTimer);
    }
    return true;
  }
  
  function reset()
  {
    if( pinned )
    {
      pinned.attributes["pinned-by-inspector"] = undefined;
      pinned = null;
      this.$("ul#current-tags").clear();
      this.timer(0, this.onTimer);
    }
  }
  
  function onTimer()
  {
    this.showInfo(pinned);
    return true; // keep counting
  }
  
  function showInfo(el)
  {
    this.showRules(el);
    this.showCurrentStyles(el)
    this.showAttributes(el);
    this.showStates(el);
    this.showMetrics(el);
  }
  
  function showRules(el)
  {
    var ruleList = el.style.rules();
    var table = this.rules;
    table.clear();
   
    for(var rule in ruleList)
    {
      if(rule.type == #style-rule)
      {
        if(rule.selector == "[pinned-by-inspector]")
          continue; // do not need this one
        table.insert(String.printf("<caption><span.name>%s</span><span.value>%s(%d)</span></caption>", 
           rule.selector, (rule.file %~ "/") || rule.file, rule.lineNo));         
      }
      else if(rule.type == #inline-style)
        table.insert("@style:");
      else if(rule.type == #runtime-style)
        table.insert("runtime style:");
      var attributes = rule.attributes;  
      var attribute_names = [];  
      for(var name in attributes) attribute_names.push(name);
      attribute_names.sort();
      for(var name in attribute_names)
        table.insert(String.printf("<tr><td.attr-name>%s :</td><td.attr-value>%s</td></tr>", name.toString(), attributes[name].toString()));
    }
  }
  function showAttributes(el)
  {
    this.atts.clear();
    for(var att in el.attributes)
      if(att != "pinned-by-inspector")
      {
        var option = new Element(#option);
        this.atts.insert(option);        
        option.html = String.printf("<span.name>%s</span><span.value>%s</span>", 
           att,el.attributes[att]);         
      }
  }
  
  function showCurrentStyles(el)
  {
    var table = this.styles;
    table.clear();
    var attributes = el.style.all();  
    var attribute_names = [];  
    for(var name in attributes) attribute_names.push(name);
    attribute_names.sort();
    for(var name in attribute_names)
      table.insert(String.printf("<tr><td.attr-name>%s :</td><td.attr-value>%s</td></tr>", name.toString(), attributes[name].toString()));
  }

  
  function showStates(el)
  {
    var names =[#link,        #hover,       #active,      #visited,     #focus,     #tab-focus,
                #popup,       #current,     #checked,     #disabled,    #expanded,  #collapsed,
                #incomplete,  #animating,   #focusable,   #read-only,   #empty,     #anchor,  
                #synthetic,   #owns-popup,  #busy,        #rtl,         #ltr,       #has-child,
                #drag-over,   #drop-target, #moving,      #copying,     #drag-source,  
                #drop-marker, #has-children ];
    this.states.clear();
    for(var n in names)
    {
      if(el.state[n]) 
      {
        var option = new Element(#option);
        this.states.insert(option);        
        option.html = String.printf("<span.name>%s</span><span.value>on</span>", n);
      }
    }
  }
  function showMetrics(el)
  {
    var metrics = this.metrics;
    metrics.clear();
    function boxdef(name,l,t,r,b,w,h)
    { 
      var option = new Element(#option); metrics.insert(option);        
      option.html = String.printf("<span.name>%s</span><span.value>%d,%d,%d,%d:%d,%d</span>",name,l,t,r,b,w,h);
    }
    var relTo = this.metricsRelTo;
    
    var boxes = [#margin, #border, #padding, #inner, #content, #client, #icon ];
    for(var boxname in boxes)
      boxdef( boxname,  el.box(#left,boxname,relTo),
                        el.box(#top,boxname,relTo), 
                        el.box(#right,boxname,relTo),
                        el.box(#bottom,boxname,relTo),
                        el.box(#width,boxname,relTo),
                        el.box(#height,boxname,relTo));
  }
  function onRelToChanged(newRelToSym)
  {
    this.metricsRelTo = newRelToSym;
    if(pinned)
      this.showMetrics(pinned); 
  }
  
  
} �   4   C S S   I N S P E C T O R       0          /*marker of pinned element*/
 [pinned-by-inspector]
 {
    outline-offset:-3px;
    outline-color:blue;
    outline-width:3px;
    outline-style:dashed;
 }       �� ���     p	             & F i l e     �H o m e 	 C t r l + S h i f t + H      �& N e w 	 C t r l + S h i f t + N     �& O p e n . . . 	 C t r l + S h i f t + O           �P & r i n t   S e t u p . . .         � A�E x i t   � & H e l p   � @�& A b o u t   s c i t e r . . .   �      �� ��     0	        (   0   `         �
                     ���  �� ��� ���  �  � � ��    � ��� ` � @ � @��  `�  �� @��  `� �`�  �� �@� ���  ��  �` `�� ��  @� ��� � � `�� ��� ` � � �  �� � � ��� @�� @��  �� ��� �`�   � @ � ��`  �` ��` � ` ���   � � � @�� `�� � � � � @��  �� ��� (� (�� (� 0� 8x� 8� 0�� 8� 0� @�� H� p� 0� @x� X� x� p�� 0� H�  �� ��� ��� H�� X�� ��� ��� Px� 8� h�  x� h� 8�� 0P� (H� H� @� @�  p� ��� ��� (P� @� (� X� 0x� ��� ��� (�� 0�� 8�� H�� (�� `�� ��� P�� @�  X� (`� 8�� P�  h� (p� P� P� `� `�� x�� ��� ��� P�� 8X� ���  H� `� x�� ��� ��� (�� h�� ��� X�� h�� �p� ��� @�� X�� X� h� (�� X�� ��� P�� P�� Ph� 8P� @`� 0X�  P� (h� 0p� ��� (x� ��� X� p� 0��  x� �� @�� ��� ���  �� 8�� @�� H�� `�� x�� �x� x�� Pp� ��� (� (X� 0h� @h� 8� @� @�� X�� `� (h� (�� H��  8� (x� H�� X�� `�� h�� ��� ��� h�� x�� ��� ��� xx� PP� PX� x`� @X� X�� ��� (H� 8`� Hp� Hx� Xx� h�� ��� 8p� Hx� p�� x�� ��� ��� (� P� 0h� 8p� 0x� `�� ��� X�� 8� 8�� X�� h�� p�� X�� 8� H�  h� 8�� P�� p�� x�� ��� ��� 8�� h�� h�� ��� ��� p�� � X XX� pX� �X� X`� �h�                   ������������                                 ��ɮ������n���ԕ��                            �ɮ������⸸����nnRR��                        �ɮ������������缼�����R��                    �̮��������������￼�����د�                  �������������������￿���混�ӕ�               ��ڜ����������yy����jj������r�E��             ��ڜ�����������yy���jjj�������rE��           ����e���å����H��yyy���jj��iirrE��          �ۜee��ă������H��yy���jj��iih���drE�         ���ee�f���������zH��llO��jj�iihh���d<E�       �ϰ�eeff�������QPPzHH�llOO�NN�iihhh99�d<R�      ����fLL������mQQPzzH��lOO�NNAiihhgg99�rE�     ����fLL�󇇇__�mQQPzHH�llO��N�Wihhgg999d<ҕ    ����fL��^^^^��__�mQPPzHHllO��NAAWhhgg�99�rE�   ����L��^MMM{{{�__mQQPzHH�lOO�NAAW>hgg�K99d��R  ��ܞfL�^MMM|||{{�__mQPz�H�lOO�NAAW>>gg�KK9�rE�  ���L�^MM���||{{�__mQPP�H��OO�NAAW>>g��KK99d<� ����L�^M�����||{��_mQPP�H���O�NAAW>>g���KK9d<�Ί��efL�^M�����||{{�_mQPP�H����}NAAW>>k����K��<ER��efL�^M��M�ߙasp�mmQPP�H����}NAA�>�kk���K9�dER���efL�^M��????I;;;;s�PP�����}}�AW�>�k���G999d<R�֋efLL^�a???DIII;;;;;�������}}�AW>>�k��GKKK9d<R�֋efL��a�??DDII88;;;;;������}��AW>>kk����KK9d<R�֜e�f�oo=?DDD888888;;;;�O���}�AA�>>kk��GG�K9d<R��ee�o==@D::888888bb;;;��}}�AA�>�k�GCGGKK9d<R����`�o==@:::8888888b;;;��\x��AW>>kCVCCGGKK9d<n����Y�o=@@::::888888b;;;S�\\BBvF��VVVCCGGK9�dEn�ڜ�Y�o=@:::::888888b;;;S�\\BBvv��VVVCCG�K9�dE� �ڜXY�o=@�::::8888888;;;SS\\BBvvF��VVCCG�K9d<E  ���XЀo=@�:::::888888;;;SS\BBBvvF��VVCCGUK9d<R  ���X�Yo=@@�::::8888I;;;SS[\BBvvFF�VVVCG�U9�dEn  ɮՖXY�o=@@:::::88II;;SSS[[BBvFFF�VVCCGUK9d<E�   �ՖX�Yo==@@@::DDDDISSSS[[BBvvFFF�V�CCUU99d<R    ɮ�XXY�o===@@DDDDD??SS[[JBBwwFF��TT�]UU9d<E�     �˖X�Y�o====???????�[[JJJwwFF��TTT�UU��d<R      ��͖XYY�ooo=�???����JJJJwwFFFxxTT�]UU�d<��       ���XX`Y��oaaaaa��JJJJJwwFFFxxTT�]]U�d<En         ��~XX`Y��ZZaaZZZJJJJssFFFxxTTT]]U�dd<n           ��~XX``��ZZZZZZZsssscccxxTT�]]U�d�<�            ���~X�```������ssscccc��TTt]]u�d�<��             ���~~���`p��ppccccc���ttttuuud<<��                ���~����pppppppp�tttttuuud���n                   ���~~���qqqqqqqttt��uu����Ҹ                     ����~ј�qqqqq�����������R�                        ���͗�ѳ���������״�R�                            ����͗������������                                  ������n���                   �����  ��  �  ��  �  ��  �  ��  �  �    �  �      �    ?  �      �      �      �      �      �      �      �      �      �                                                                                              �      �      �      �      �      �      �      �      �      �      �    ?  �    ?  �      ��  �  ��  �  ��  �  ��  �  ��  �  �����  �      �� ��     0	        (       @         �                     ��� ��� ���   �  �  @ �  `� ` � ��`  `� @�� @�� ��� ���  ��  @�  ��  �� � � �@� �`�  �` @�� `�� � � �@�  ��  ��  �� ��� �`@  �@ ��`   ` ��� � � �� � �  �� @�� � � � � @�� `�� ���  ��  �� (� (�� (� @x� Ph� X�  �� 0�� @�� Hp� 8� 8x� 0�� X�� h�� 0� 0� 8� 8� H� (�� ��� x� 8�� ��� PP� (H� Hh� Hx� (� 8h�  (� @� X� 0x� P� h�  p�  x� ��� p� `�� H�� ��� ��� �p� ��� ��� Hh� Px� 0P� Px� H�� X�� @� (P� 0� (h� 0�  h� (p� @� H� `� ��� h� (�� H�� x�� (�� p�� x�� x�� ��� �X� XH� �x� h�� X`� `x� PX� H`� 0X� X�� (X�  (� @� H�  P� (`� ��� (� P� (x� `� p�� ��� X� �� 8�� X�� ��� ��� ��� ���  �� 8�� P�� P�� `�� ��� �H� �X� �X� x`� �h� �p� x�� HH� HP� PX� P`� Ph� Xh� �h� hp� x�� h�� x�� x��  @� 8X� 8`� H�� P�� x�� ��� ��� X�� 8�  8� 8p� 8x� X�� x�� ��� h�� @�  H�  X� 8h� 0p� 0x� 8�� ��� `� 8�� H�� X�� x�� ���  8� P� p� 8�� @�� P�� X�� `�� ���  x� (�� P�� h�� ��� ��� (�� @�� `�� ��� ��� � x �� x(� X � �8� x@� x`� �`� P0� `@� �@� `H� hP� �P� �`� �`� �h� hp� x�� P8� XX� `X� �X� Xh� `h� �h� �h�             �����~��                     ����������ca4~                �]������������dL4I             ����Ϗ�����������39�           ]���Ϗ���YY���s�����34         ]���Ettt���YY��ss�����34       ���EEٕ�tttv�Y��ss��<<DR3�     �^�E�pp���Httv>�=�s8�<<1DR9~    _�EpWW���[yHxv>�=�Z8�<<11D;9   ����W��\\\�[yHwv>=�Z8G<<r11R34  _��W���ޗ\\�[Hwv>�=Z8G7<r66D;9 �_��W��ߘ��\�[yHv>�=Z8G7r�661R9 ���p��������\[yHw>�=Z8G7����1D3a^�EW����E���w[[Hv>�=Z8G7u��F1D;L^�Ep��·@���jC�Hv>�Z8G7u�FF61;L^�EpW�@Ahh@@0OOkv>=�Z8�7u�F�61�L^�Epƻ:h200000jOC���Z877u�FF61�L^�E�f:?22M0000OjOю�8�7uXXXF61;L��ςf:?22MM000OOj��mS��oqqFF6D;d|��J�:?222M0000jjBmnnS�oqXXF6D��뱿J�:?222M0000jBBmnSS5oqXFV1R3  �cJJ�??22200@@BBPPnS55oqXFV1;d  |bJ�::?22h@@@BBPnSS5ooT�VVR3e   ��bJ�:::�AAAAPPCC�55oT�UV1;d     ~bbJff::AA��CCC�55oTTUV�R3      ��bgg�f����CCC�55o�TUU�R��       ��bgg�ć�����QQˎTUU�R��         ����gg���QQQQ��kkllǽ�           ����������kkkkl��3�             ���������iiii�N3d                 4����NNNNN9d�                    }�4```99a�           �������  �  ?�  �  �  �  �  �  �                                        �  �  �  �  �  �  �  �  ?�  �������h      �� ��     0	        (                @                     ��� [x� Fc� >e� =h� Cm� U�� I[� 7]� -^� )a� )e� ,i� 4o� <r� AY� *T�  Q� Q� T� Z� a� i� (q� 9z� H\� &L� E� @� A� E� L� V� `� k� "t� <�� ao� ,L� >� 5� 2� 4� :� B� L� X� d� q� 'x� D�� ��� Sn�  A� 0� '� (� *� 1� ;� F� 
Q� _� m� z� 3y� ��� _�� <� /� $� 	#� &� -�  0� >� S� ^� j� y� +{� I|� ~�� ��� /Y� 	)� *� 	'� '�  !� Q� B�� ;�� )�� v� y� (|� Cx� �� ��� ��� <d� 	0�  (� 4� Ct� q�� [�� D�� 1�� #�� |� (}� ��� ��� ��� ��� ��� ��� ��� ��� o�� Y�� E�� 4�� $�� }� -}� Ht� �_� ��� ��� ��� ��� ��� ��� ��� m�� Y�� F�� 4�� '�� !� 6z� Pq� ��� ��� ��� ��� ��� ��� x�� f�� U�� D�� 4�� (�� *� Er� ��� ��� ��� ��� z�� m�� ^�� O�� @�� 4�� -�� =u� �h� |�� w�� s�� k�� b�� V�� J�� ?�� 9�� ?v� Md� v}� m�� d�� [�� S�� L�� J�� Km� uX� lk� dt� ^r� [f� \T�                                                                                                                                                                                                                                              ������         ��������      ������������    ������������   �������������� ����������������rstuvwxyz{|}~��cdefghijklmnopqbSTUVWXYZ[\]^_`abCDEFGHIJKLMNOPQR456789:;<=>?@AB  &'()*+,-./0123    !"#$%            	
              �  �  �  �  �                         �  �  �  �  �  �%      �� ��     0	        (   0   `          �%                                                                                  � q	z;�EoS��n]��oX��k`��hc��fj��ei��bc��b\��cU��\V��WN��c1�>� �                                                                                                                        �@�<u\��t`��pp��l}��j���f���d���a���_���]���[���Z���Y��Y{��Yw��Zk��ZY��SP��W1�/                                                                                                        �C�H{^��vo��q���n���k���h���e���b���_���\���Z���W���V���T���S���P���P���P���Q|��Tu��Vf��SR��R7�8                                                                                        �7��\��{n��u���q���n���l���i���f���e���a���^���\���Y���W���T���Q���O���M���K���J���I���J���K}��Ot��Qh��LP��Y3�                                                                            �K�Rh��y���u���s���q���o���k���j���g���e���b���_���]���Z���W���T���Q���N���K���I���F���E���D���C���E���H{��Ls��N]��II�F                                                                � U�W���q��y���w���v���t���r���p���o���m���j���h���e���b���^���\���X���T���Q���N���J���H���F���C���A���@���?���@���B}��Fu��Nf��LR�|                                                        � ��Z���x��|���y���x���w���w���v���t���s���p���n���l���h���e���b���^���[���W���R���O���K���G���D���A���?���<���;���;���<���?}��Cv��Ml��RP��                                                � U�]���}��}���}���|���|���|���{���z���y���w���u���r���p���l���h���e���a���]���Z���U���Q���M���I���E���B���>���<���8���7���7���7���:}��Av��Kn��TX��                                            �X���{������������������������������~���|���z���w���t���p���m���h���d���`���\���W���R���O���J���F���A���>���:���8���6���4���3���4���7}��Av��Mn��OV�n                                    �J�H�u�������������������������������������������������|���x���t���p���l���h���c���^���Y���U���P���L���G���C���?���;���7���4���2���0���0���1��7}��Av��Rl��^S�1                            � `�o�䂍������������������������������������������������������|���y���u���p���k���f���b���]���W���R���M���G���D���?���:���7���4���1���.���-���-���1~��8|��Ct��Rf�Ԁ+�                        �g������������������������������������������������������������������}���x���s���o���i���d���^���Z���T���N���J���E���@���;���8���4���1���/���+���*���,���3}��;y��Nu��Rd��                    �4�,�v����������������������������������������������������������������������{���v���q���k���g���a���[���U���P���J���E���@���<���7���3���/���,���+���(���(���-��5}��Dy��Nk��lX�                �k������������������������������������������������������������������������������{���t���o���i���c���]���W���R���M���G���B���;���7���3���/���,���(���'���&���*��0��8|��Er��Nn£            �s�w������������������������������������������������������������������������������}���w���q���l���d���^���Y���R���M���H���A���<���7���3���.���+���(���%���$���&���,��3~��Az��Lo��ww�        �i��������������������������������������������������������������������������������������z���s���m���f���`���[���T���N���H���C���=���7���3���/���+���'���%���"��$��)��0~��=}��Dr��Ru�|    � ��o�؇�����������������������������������������������������������������������������������{���v���n���h���a���[���T���O���H���B���=���8���2���.���*���&���$���!���"~��&���,��7~��?w��Nq��    �t!�}��������������������������������������������������������������������������������������|���w���p���i���b���\���U���O���H���B���>���7���3���-���*���&���"��� ~�� ~��$~��*��2}��:y��Lp��m���b�h����������������������������������������������������������������������������������������}���w���p���j���b���\���V���O���I���B���>���8���2���-���*���%���"��~��}��"��-���.~��7z��Dr��W��[�o������������������������������������������������������������������������������������������}���x���p���j���b���\���V���N���I���B���=���8���1���,���(���$���!��~��}��!}��-���,~��5|��At��QzĘ�n�Ʉ�������������������������������������������p��7c��$P޺A��M�(V��X������������������~���w���p���h���b���\���U���N���G���B���<���7���1���+���(���$�����}��{��"}��'���+~��3|��>v��MyǺ�l�ۄ�����������������������������������4b��;��7��6��5��
4��	2��2��2��3��L�v��Ԅ���}���v���o���g���a���\���T���M���G���B���;���5���0���+���'���#�����}��|��%���$~��*~��1~��<x��Oy�υo�傖��������������������������[���@��;��8��5��3��1��
0��	/��/��.��/��1��2��4h�{���t���m���g���`���Z���S���L���F���A���:���3���/���*���&���!���~��|��~�� ~��#~��)��0~��:y��Ny�ۃq�遗����������������������<k��@��;��7��5��1��0��.��
-��,��,��,��,��.��/��0��E�m���m���f���^���X���Q���K���E���@���9���3���.���)���%��� ���}��~��}��}��#}��)~��0~��:y��Nw�߃q�ꀖ������������������Ft��B��>��9��5��1��/��-��+��
*��)��*��*��*��,��-��.��0��6��Z���c���\���V���P���J���C���>���7���1���-���(���$���~��}��y��|��|��#}��)~��/}��:y��My�ނm�����������������g���F��@��;��6��2��/��-��*��(��
'��'��'��)��*��+��+��-��.��2��4��,h�Z���T���M���G���@���<���6���1���+���&���"��y��s��v��|��}��#}��)~��0~��:x��N|�ԁp��~���~�����������,S��E��>��9��4��0��,��)��(��&��
&��	&��&��(��)��*��+��,��.��1��5��9��?��_�<���F���?���:���4���/���$}��q��j��o��s��w��z��}��#~��)��1}��;w��N���t��|���|���~���]���$J�� C��=��8��2��-��*��)��'��%��
%��	%��%��'��)��*��+��-��/��2��6��9��=��@��E��J��
Q��X��Z��[��`��d��j��n��r��x��{��}��$~��*}��2|��<v��N�ɰ|t��z���y���{���=g��%I�� C��=��7��1��,��(��'��%��%��
$��
%��	%��&��)��*��+��-��1��3��6��:��=��A��E��I��N��	S��
X��\��a��e��j��n��r��w��{��!}��%~��,~��3{��@t��R�Ʌ|i�Ny���w���x���.S��&J��"C��=��6��0��*��&��%��%��%��$��
%��	&��&��'��*��+��.��0��2��6��:��>��B��G��K��	O��
S��X��\��a��e��j��n��s��w��{��"}��&~��-}��5z��Cs��]��J�a�zv��v���m���/P��(K��"C��=��7��1��+��'��%��%��&��&��&��
&��	'��)��+��,��/��2��4��9��<��?��D��H��	K��
P��
U��Y��^��a��f��k��o��t��w��{��#}��(~��/|��8y��Mt��U��    zs��t���e���1P��+L��$F�� @��8��2��,��*��(��&��(��'��'��
)��
*��	+��	-��/��2��4��7��:��>��A��E��	J��
M��
R��V��Z��^��c��g��k��o��u��x��!{��%~��*}��2{��<v��O�ɴ@��    xu�du���f���5Q��-M��'I��"B��=��6��2��-��,��*��)��*��+��+��
,��
.��	0��	2��	3��6��9��<��	@��	C��	H��
J��
N��T��W��\��`��d��h��m��q��u��y��"|��'}��-}��5z��As��Z��]        p��ws��k���9S��0P��)K��$E�� ?��:��5��2��/��.��.��-��-��.��/��0��
2��
5��
7��	9��	<��	>��
B��
E��
H��M��Q��U��Y��\��b��e��i��n��r��u�� y��%}��*}��0|��:w��L{��U��            tz��o���?S��4R��,M��'I��"C��?��:��7��5��3��2��1��1��2��3��3��6��7��9��
<��
>��
A��D��H��K��O��R��V��[��_��c��g��k��o��r��v��#z��'}��-}��5z��@s��W��~                o��tu��P[��:R��0Q��*K��%H��!C��?��<��9��8��7��6��6��6��6��7��9��;��=��?��A��D��H��K��N��R��V��X��]��a��f��h��l��p��u��"w��%{��*}��1{��:w��N|��X��                     r��kch��@R��6R��.O��)L��$H��!D��A��?��=��:��:��:��9��:��=��=��>��@��C��D��G��J��N��Q��U��X��\��_��c��h��k��o��s��!u��$y��){��.|��6y��Cs��[��e                        ���rx��MV��=S��4S��-P��(M��$I��!F��D��B��@��?��>��?��?��@��A��C��D��G��I��K��O��P��T��X��[��_��b��f��i��m��q�� s��#w��(z��-{��4z��=u��Q�ɪP��                            i��"hc��ER��:T��2R��,Q��'O��$L��!H��H��E��E��C��C��D��D��E��G��H��I��L��N��R��U��W��[��_��b��d��h��l��o��!s��#v��(x��-y��3z��;v��M~��[��*                                    m��D_Z��DS��:T��2T��,S��(P��$M��!M��K��I��I��H��I��I��I��L��M��N��P��S��U��Y��Z��^��a��d��h��k��n��"q��$t��(w��-x��3x��:v��Kw��[��L                                            k��]WV��DS��:V��2V��-T��)R��%Q��#P��!O��O��M��N��N��O��O��R��S��U��X��Y��[��_��b��e��g��j�� m��"q��&r��)u��-w��3w��:v��Ju��Z��X ��                                                d��^VW��DU��:X��5W��/V��*V��'U��%S��"T��!R��R��T��T��V��V��W��Z��\��]��`��b��e��h�� j��"m��$p��'q��+t��/u��4u��;t��Kw��Z��[@��                                                        c��KZ`��GT��<X��5Y��2Y��-Y��*X��'W��%X��#W��"X��!X�� Z��[��[��^��`��a�� d��!f��"h��#k��%m��'o��*q��-s��1t��6s��=r��Q}��Z��JU��                                                                `��%_r��NW��@X��:Z��5[��0[��-\��*\��(\��&\��&\��%^��#^��#`��#b��#d��$d��$g��&i��&k��(n��+o��.p��1q��5q��;q��Ep��U�ȟU��-                                                                            ]��b��hZc��HX��@[��:\��5^��2_��/`��-`��+`��*b��*b��)c��)e��)g��*h��*j��+k��.l��0m��3n��6n��;n��Bn��P|��Y��aY��                                                                                        X��f��zXh��KZ��A\��<^��9_��6`��4b��3d��2d��1f��1f��1h��1h��3k��4k��6k��:l��=k��Fj��P{��\��rW��&                                                                                                        X��g��YZ���Wg��K^��C]��@_��=b��<c��<c��;e��<f��<g��?f��@h��Hh��Qs��V�ȡ`��UW��#                                                                                                                        @��W��#`��Ef��q\�ÙT�öU~��Zs��Yt��R�ĵU�´X�șd��k[��FW��&`��                                                                ��  ��  ��  ?�  ��  �  ��  �  ��  �  �    �  �      �    ?  �      �      �      �      �      �      �      �                                                                                                                             �       �      �      �      �      �      �      �      �      �      �    ?  �      ��  �  ��  �  ��  �  ��  ?�  ��  ��  �      �� ��     0	        (       @          �                                  h� sy� {\�m���7� � iQ�y?�JoY��m]��ib��ej��bj��a`��_Y��ZT��b=�DU � y S-� QM�TQ�LX� N]�                             �W� }l� �U�y`� |W� �?�)xb��rn��ny��h���d���`���\���X���V���T���T��Uq��Td��U\��R4�#PL� RS� RV�N^� LR�                     v�� �F� }m�d�� sn�~]�}yq��r���m���h���e���a���\���X���U���P���M���J���H���I���Lu��Nf��OP�xFX�H\� N_�KF� :��             �X� v�� �G��]� �Y�"�d��x���t���q���n���k���g���c���^���Z���V���P���L���H���D���A���?���B���Gs��L\��OQ�MV� KG�=�� OV�     �o� �V� �o��h� �B�)�o��{���x���w���v���s���q���m���i���c���_���Y���S���M���G���B���>���;���9���:���Bv��Md��UD�"N]� Jg�Ei� Rf� �e� �Y�{�� �v��q��}���}���~���}���|���z���w���s���o���i���c���]���W���P���J���C���=���9���6���4���4���?v��Nf��Nh�Dz� He�Rd� �d��R�1���e���������������������������������{���u���o���h���a���Z���S���L���D���>���8���4���0���.���1~��@v��Rc��I��8��Rd� �}��r� �X�n����������������������������������������{���t���m���f���^���V���N���G���?���8���3���/���+���+��2}��Fr��X_�]Zi� Pi��a��v��}�慠������������������������������������������z���r���j���b���Y���P���H���@���9���3���-���)���'���*~��:|��Kn��Qx�_y� ��� �e�~����������������������������������������������������v���n���d���[���S���K���B���9���2���,���'���$���&��/~��Bv��Ol�oFd� ���:�z�·���������������������������������������������������{���q���g���^���T���K���B���:���3���,���&���"���"~��*��:{��Iq��$��\����������������������������������������������������������}���t���i���_���U���L���B���;���2���+���%��� �� }��&~��1}��Cs��t��&�u�ȅ�������������������������������������������������������}���u���k���`���V���L���C���;���2���*���$���}��|��&��-��<u��Sx�{�~�愛����������������������������_���Q~��Y���x��ړ�������~���t���i���_���U���K���B���:���1���)���#���~��{��$~��*~��8w��LvŽ�����������������������i���F��	2�� )�� '�� '��.��A��Y��ۀ���t���f���^���T���I���A���7���/���(���"���|��|��"~��'~��5z��Lw�؀�������������������:f��
1��4��2��0��.��-��+��+�� '��-_��o���j���[���R���H���@���6���.���'��� ��|��|�� |��(~��3{��Kv� �������������;g��5��9��1��-��
*��	(��(��)��*��.�� %��G��T���^���R���F���=���4���-���&���}��w��{��|��'}��3z��Kx��~~��|�������_���=��<��3��-��)��&��%��&��(��)��*��.�� .��8��#b��<���A���9���1���&~��r��o��s��z��}��(~��4y��K|��{|��{���z���4\��>��9��0��)��'��$��	$��$��&��)��+��.��3��7�� 7��A��	M��V��[��^��e��l��t��y��!|��)}��6w��L�ǲxr��z���l���&J�� A��8��/��'��$��$��
$��	$��%��(��*��/��3��9��?��E��J��Q��
X��_��g��m��s��z��"|��*}��;t��U��lx_��z���_���(H��"C��9��/��(��$��%��&��	%��'��*��,��1��5��;��@��G��L��
T��Z��`��g��m��u��y��%}��.z��Bw�����$~`�y��^y��,K��%G��=��3��-��*��(��)��*��	+��.��1��4��8��=��C��H��	O��U��\��b��h��o��v��!z��(}��4w��G�̽	�t� |z�few��2O��)K��!B��:��4��0��.��-��.��/��
1��
5��	9��<��	A��	F��L��R��X��^��d��j��p��v��${��,{��<v��T��`LY� bp�qo�kr��AT��-N��%H��A��;��7��6��4��4��5��7��:��=��
@��F��J��P��U��[��b��g��m��s��"w��(}��4w��H}��Lx�\�� hm�{{� }��LV_��5O��,N��$H��C��?��<��;��:��;��>��?��C��F��J��O��U��Z��_��d��j��p�� u��&z��.z��?w��X��MLx� Gz�z�� m2�v&� iq��GR��2Q��*O��$L��G��E��C��A��B��C��F��H��K��P��T��Y��_��c��h��m�� s��&w��,y��;t��N�̋= �E,�Z�� x� f�� UK� ^J�
^h��DR��2T��*S��%N�� M��K��J��J��K��M��N��Q��U��Y��^��c��g��l��"p��&u��-w��:s��N�˪Rl�Hh� R�� X�� rx� g�� ]y�]Z� ~��Wd��DS��3U��,U��&T��#R�� Q��Q��S��T��U��Y��[��_��c��g�� k��$o��(s��.s��;q��K�˫j��Ps� Q��R�� Q��     m�� UK� g��^o� j��[s��HX��9V��0Y��*Y��&Y��$X��"Y��![��\�� _�� a��!e��#h��$l��(o��-p��4n��@t��P�ˇb��T�� a��Gh� [��             WV� e�� _r�c�� j�� f��PRf��D]��8X��0\��-^��*_��)`��(b��'d��(g��)j��+k��/k��5j��?q��J��\��MfS� ]�� U��_�� Ju�                     c�� _r� ho� e�� t�� y��`w�`Qo��Hc��@]��:_��7b��6d��5e��6g��8h��=i��Dq��K�ǱW��^q��j�� [�� _�� U�� Z��                             _r� ht� f��u��|�� ]t� ���i��pTk��Lk��Fk��Gg��Gj��Fo��Is��Qv��d��jr��T�� ~�� k��]��    U��                 �������  �  ?�  �  �  �  �  �  �                                        �  �  �  �  �  �  �  �  ?�  �������h      �� ��     0	        (                 @                  � I }h� X��d�� |� uX�qlk��dt��^r��[f��\T�lg� ^~� `O�Mb� 9�� �5� c�yo� ~_�Gv}��m���d���[���S���L���J���Km��QX�DPX� L]�3�� �s��p� �h�e|���w���s���k���b���V���J���?���9���?v��Md�^Jh� At��� �h�A����������������z���m���^���O���@���4���-���=u��Ve�6Mq�������Ό�������������������x���f���U���D���4���(���*��Er��4~� �_������������������������������m���Y���F���4���'���!��6z��Pq�V��������������������������o���Y���E���4���$���}��-}��Ht�������������<d��	0�� (��4��Ct��q���[���D���1���#���|��(}��Cx��~�������/Y��	)��*��	'��'�� !��Q��B���;���)���v��y��(|��Cx�넒��_���<��/��$��	#��&��-�� 0��>��S��^��j��y��+{��I|������Sn�� A��0��'��(��*��1��;��F��
Q��_��m��z��3y��T��L_`�ao��,L��>��5��2��4��:��B��L��X��d��q��'x��D���0c� IK� OO�0H\��&L��E��@��A��E��L��V��`��k��"t��<���9d�0Dt�=@�@E� BK�MAY��*T�� Q��Q��T��Z��a��i��(q��9z��7c�M8]� =i�� m��DQ� ]j�4I[��7]��-^��)a��)e��,i��4o��<r��S��2;`� c��'Q�   � ~�� ��xia� MD [x��Fc��>e��=h��Cm��U�Ç ][� ���r¾ !I� �  �  �  �  �                         �  �  �  �  �  Z       �� ���     0	            00    �         �       h   00     �%          �        h           �� ��d     0	        � Ȁ         � f     A b o u t    M S   S a n s   S e r i f    P    � Q 2   ��� O K        P     9 N   ����� s c i t e r   A p p l i c a t i o n   v 1 . 0 
 
 ( c )   C o p y r i g h t   2 0 0 8       P    7    ����� ���     P      s X �����              ��	 ���     p 	         H �   N  �  � O �  $      �� ��     0 	        $4   V S _ V E R S I O N _ I N F O     ���               ?                         �   S t r i n g F i l e I n f o   `   0 4 0 9 0 4 b 0       C o m m e n t s        C o m p a n y N a m e     D   F i l e D e s c r i p t i o n     s c i t e r   M o d u l e   6   F i l e V e r s i o n     1 ,   0 ,   0 ,   1     .   I n t e r n a l N a m e   s c i t e r     B   L e g a l C o p y r i g h t   C o p y r i g h t   2 0 0 8     (    L e g a l T r a d e m a r k s     >   O r i g i n a l F i l e n a m e   s c i t e r . e x e          P r i v a t e B u i l d   <   P r o d u c t N a m e     s c i t e r   M o d u l e   :   P r o d u c t V e r s i o n   1 ,   0 ,   0 ,   1          S p e c i a l B u i l d   D    V a r F i l e I n f o     $    T r a n s l a t i o n     	�,       �� ��	     p	         s c i t e r                               �      �� ��    0	         C r e a t e   a   n e w   d o c u m e n t 
 N e w  O p e n   a n   e x i s t i n g   d o c u m e n t 
 O p e n  C l o s e   t h e   a c t i v e   d o c u m e n t 
 C l o s e  S a v e   t h e   a c t i v e   d o c u m e n t 
 S a v e 0 S a v e   t h e   a c t i v e   d o c u m e n t   w i t h   a   n e w   n a m e 
 S a v e   A s & C h a n g e   t h e   p r i n t i n g   o p t i o n s 
 P a g e   S e t u p 3 C h a n g e   t h e   p r i n t e r   a n d   p r i n t i n g   o p t i o n s 
 P r i n t   S e t u p  P r i n t   t h e   a c t i v e   d o c u m e n t 
 P r i n t     D i s p l a y   f u l l   p a g e s 
 P r i n t   P r e v i e w                     �� ��    0	        ? D i s p l a y   p r o g r a m   i n f o r m a t i o n ,   v e r s i o n   n u m b e r   a n d   c o p y r i g h t 
 A b o u t 4 Q u i t   t h e   a p p l i c a t i o n ;   p r o m p t s   t o   s a v e   d o c u m e n t s 
 E x i t                               �       �� ��    0	        ( S w i t c h   t o   t h e   n e x t   w i n d o w   p a n e 
 N e x t   P a n e 5 S w i t c h   b a c k   t o   t h e   p r e v i o u s   w i n d o w   p a n e 
 P r e v i o u s   P a n e                               |      �� ��    0	        6 O p e n   a n o t h e r   w i n d o w   f o r   t h e   a c t i v e   d o c u m e n t 
 N e w   W i n d o w 7 A r r a n g e   i c o n s   a t   t h e   b o t t o m   o f   t h e   w i n d o w 
 A r r a n g e   I c o n s / A r r a n g e   w i n d o w s   s o   t h e y   o v e r l a p 
 C a s c a d e   W i n d o w s 5 A r r a n g e   w i n d o w s   a s   n o n - o v e r l a p p i n g   t i l e s 
 T i l e   W i n d o w s 5 A r r a n g e   w i n d o w s   a s   n o n - o v e r l a p p i n g   t i l e s 
 T i l e   W i n d o w s ( S p l i t   t h e   a c t i v e   w i n d o w   i n t o   p a n e s 
 S p l i t                     (      �� ��    0	         E r a s e   t h e   s e l e c t i o n 
 E r a s e  E r a s e   e v e r y t h i n g 
 E r a s e   A l l 3 C o p y   t h e   s e l e c t i o n   a n d   p u t   i t   o n   t h e   C l i p b o a r d 
 C o p y 1 C u t   t h e   s e l e c t i o n   a n d   p u t   i t   o n   t h e   C l i p b o a r d 
 C u t  F i n d   t h e   s p e c i f i e d   t e x t 
 F i n d  I n s e r t   C l i p b o a r d   c o n t e n t s 
 P a s t e      R e p e a t   t h e   l a s t   a c t i o n 
 R e p e a t 1 R e p l a c e   s p e c i f i c   t e x t   w i t h   d i f f e r e n t   t e x t 
 R e p l a c e % S e l e c t   t h e   e n t i r e   d o c u m e n t 
 S e l e c t   A l l  U n d o   t h e   l a s t   a c t i o n 
 U n d o & R e d o   t h e   p r e v i o u s l y   u n d o n e   a c t i o n 
 R e d o       �      �� ���    0	         C h a n g e   t h e   w i n d o w   s i z e  C h a n g e   t h e   w i n d o w   p o s i t i o n  R e d u c e   t h e   w i n d o w   t o   a n   i c o n  E n l a r g e   t h e   w i n d o w   t o   f u l l   s i z e " S w i t c h   t o   t h e   n e x t   d o c u m e n t   w i n d o w & S w i t c h   t o   t h e   p r e v i o u s   d o c u m e n t   w i n d o w 9 C l o s e   t h e   a c t i v e   w i n d o w   a n d   p r o m p t s   t o   s a v e   t h e   d o c u m e n t s                   �       �� ���    0	            ! R e s t o r e   t h e   w i n d o w   t o   n o r m a l   s i z e  A c t i v a t e   T a s k   L i s t                        A c t i v a t e   t h i s   w i n d o w   *       �� ��    0	           R e a d y                               D       �� ���    0	                             O p e n   t h i s   d o c u m e n t           X       �� ��    0	               O p e n   a   n e w   w i n d o w 
 N e w   W i n d o w                         