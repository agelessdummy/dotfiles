/* generated javascript */
var skin = 'monobook';
var stylepath = '/skins-1.5';

/* MediaWiki:Common.js */
//<nowiki> Common javascript code which effects everyone
 
 if (window.showModalDialog && document.compatMode && document.compatMode == "CSS1Compat")
 {
   var oldWidth;
   var docEl = document.documentElement;
   
   function fixIEScroll()
   {
     if (!oldWidth || docEl.clientWidth > oldWidth)
       doFixIEScroll();
     else
       setTimeout(doFixIEScroll, 1);
  
     oldWidth = docEl.clientWidth;
   }
   
   function doFixIEScroll() {
     docEl.style.overflowX = (docEl.scrollWidth - docEl.clientWidth < 4) ? "hidden" : "";
   }
   
   document.attachEvent("onreadystatechange", fixIEScroll);
   attachEvent("onresize", fixIEScroll);
 }
 
 function addLoadEvent(func) 
 {
   if (window.addEventListener) 
     window.addEventListener("load", func, false);
   else if (window.attachEvent) 
     window.attachEvent("onload", func);
 }
 
 function import_script(name)
 {
   document.write('<script type="text/javascript" src="/w/index.php?title=' + name + '&action=raw&ctype=text/javascript"><\/script>');
 }
 
 // hasClass()
 // Description: Uses regular expressions and caching for better performance.
 // Maintainers: User:Mike Dillon, User:R. Koot, User:SG
 
 var hasClass = (function () {
    var reCache = {};
    return function (element, className) {
      return (reCache[className] ? reCache[className] : (reCache[className] = new RegExp("(?:\\s|^)" + className + "(?:\\s|$)"))).test(element.className);
    };
 })();
 
 function LinkFA() 
 {
   // iterate over all <span>-elements
   var spans = document.getElementsByTagName("span");
   var lists = document.getElementsByTagName("li");
   
   for (var i=0; a = spans[i]; i++) {
     // if found a FA span
     if (hasClass(a, "FA")) {
       // iterate over all <li>-elements
       for (var j=0; b = lists[j]; j++) {
         // if found a FA link
         if (hasClass(b, "interwiki-" + a.id)) {
           b.style.padding = "0 0 0 16px";
           b.style.backgroundImage = "url('http://upload.wikimedia.org/wikipedia/en/6/60/LinkFA-star.png')";
           b.style.backgroundRepeat = "no-repeat";
           b.title = "This book has gained featured status";
         }
       }
     }
   }
 }
 
 addLoadEvent(LinkFA);
 
 // ============================================================
 // BEGIN Dynamic Navigation Bars (experimantal)
 
 // set up the words in your language
 var NavigationBarHide = '▲';
 var NavigationBarShow = '▼';
 
 // set up max count of Navigation Bars on page,
 // if there are more, all will be hidden
 // NavigationBarShowDefault = 0; // all bars will be hidden
 // NavigationBarShowDefault = 1; // on pages with more than 1 bar all bars will be hidden
 var NavigationBarShowDefault = 0;
 
 // shows and hides content and picture (if available) of navigation bars
 // Parameters:
 //     indexNavigationBar: the index of navigation bar to be toggled
 function toggleNavigationBar(indexNavigationBar)
 {
   var NavToggle = document.getElementById("NavToggle" + indexNavigationBar);
   var NavFrame = document.getElementById("NavFrame" + indexNavigationBar);
   
   if (!NavFrame || !NavToggle) {
     return false;
   }
   
   // if shown now
   if (NavToggle.firstChild.data == NavigationBarHide) {
     for (var NavChild = NavFrame.firstChild; NavChild != null; NavChild = NavChild.nextSibling) {
       if (hasClass(NavChild, 'NavPic')) {
         NavChild.style.display = 'none';
       }
       if (hasClass(NavChild, 'NavContent')) {
         NavChild.style.display = 'none';
       }
     }
     NavToggle.firstChild.data = NavigationBarShow;
   // if hidden now
   } else if (NavToggle.firstChild.data == NavigationBarShow) {
     for (var NavChild = NavFrame.firstChild; NavChild != null; NavChild = NavChild.nextSibling) {
       if (hasClass(NavChild, 'NavPic')) {
         NavChild.style.display = 'block';
       }
       if (hasClass(NavChild, 'NavContent')) {
         NavChild.style.display = 'block';
       }
     }
     NavToggle.firstChild.data = NavigationBarHide;
   }
 }
 
 // adds show/hide-button to navigation bars
 function createNavigationBarToggleButton()
 {
    var indexNavigationBar = 0;
    var divs = document.getElementsByTagName("div");
    
    // iterate over all < div >-elements
    for (var i=0; NavFrame = divs[i]; i++) {
      // if found a navigation bar
      if (hasClass(NavFrame, 'NavFrame')) {
        indexNavigationBar++;
        var NavToggle = document.createElement("a");
        NavToggle.className = 'NavToggle';
        NavToggle.setAttribute('id', 'NavToggle' + indexNavigationBar);
        NavToggle.setAttribute('href', 'javascript:toggleNavigationBar(' + indexNavigationBar + ');');
        
        var NavToggleText = document.createTextNode(NavigationBarHide);
        NavToggle.appendChild(NavToggleText);
        // Find the NavHead and attach the toggle link (Must be this complicated because Moz's firstChild handling is borked)
        for (var j=0; j < NavFrame.childNodes.length; j++) {
          if (NavFrame.childNodes[j].className == "NavHead") {
            NavFrame.childNodes[j].appendChild(NavToggle);
          }
        }
        NavFrame.setAttribute('id', 'NavFrame' + indexNavigationBar);
      }
    }
    // if more Navigation Bars found than Default: hide all
    if (NavigationBarShowDefault < indexNavigationBar) {
      for (var i=1; i<=indexNavigationBar; i++) {
        toggleNavigationBar(i);
      }
    }
 }
 
 addLoadEvent(createNavigationBarToggleButton);
 
 if (wgNamespaceNumber >= 1 && (wgTitle == "Main Page" || wgTitle.indexOf("Main Page ") == 0))
 {
   document.write('<style type="text/css">/*<![CDATA[*/ #siteSub, #contentSub, h1.firstHeading { display: none !important; } /*]]>*/</style>');
   
   function mainPageRenameNamespaceTab()
   {
     try {
       var Node = document.getElementById('ca-nstab-main').firstChild;
       if (Node.textContent ) {      // Per DOM Level 3
         Node.textContent = 'Main Page';
       } else if (Node.innerText) { // IE doesn't handle .textContent
         Node.innerText = 'Main Page';
       } else if (Node.innerHTML) { // Fallbacks
         Node.innerHTML = 'Main Page';
       } else {
         Node.replaceChild(Node.firstChild, document.createTextNode('Main Page')); 
       }
     } catch(e) {
       // bailing out!
     }
   }
   // Main page tab no longer says article
   addOnloadHook(mainPageRenameNamespaceTab);
 }
 
 // adds buttons to the edit toolbar
 if (mwCustomEditButtons) {
   import_script("MediaWiki:EditToolbar.js");
 }
  
 // ==================================================
 // Book-wide search using Google
 // from pl.wikibooks, maintainer [[b:pl:User:Piotr]]
 // ==================================================
 
 function getBookName() {
   var start = 0;
   var PSEUDONAMESPACE = "Programming:";
   if (wgPageName.slice(0, PSEUDONAMESPACE.length) == PSEUDONAMESPACE) start = PSEUDONAMESPACE.length;
   var i = wgPageName.indexOf(':', start);
   var k = wgPageName.indexOf('/', start);
   if ( (i != -1 && k < i) || i == -1 ) {
      if ( k != -1 ) i = k;
   }
   
   var book = wgPageName;
   if ( i != -1 ) {
     book = wgPageName.slice(0, i);
   }
   return book;
 }
 
 function insertGoogleSearch() {
   if ( wgNamespaceNumber != 0 && wgNamespaceNumber != 102 && wgNamespaceNumber != 110) { // 102 - Cookbook / 110 - Wikijunior
     return;
   }
   var google = "http://www.google.com/custom?sa=Google+Search&domains=en.wikibooks.org/wiki/PAGE&sitesearch=en.wikibooks.org/wiki/PAGE";
   var tb = document.getElementById('p-tb').getElementsByTagName('ul')[0];
   var link = document.createElement('a');
   var book = getBookName();
   
   link.href = google.replace(/PAGE/g, book);
   link.appendChild(document.createTextNode("Search this book"));
   
   var li = document.createElement('li');
   li.id = "google-trick-search";
   
   li.appendChild(link);
   tb.insertBefore(li, tb.firstChild);
 }
 
 addOnloadHook(insertGoogleSearch);
 
 /** Add dismiss button to watchlist-message *************************************
  *
  *  Description: Hide the watchlist message for one week.
  *  Maintainers: [[w:User:Ruud Koot|Ruud Koot]]
  */
 
 function addDismissButton() {
    var watchlistMessage = document.getElementById("watchlist-message");
    if ( watchlistMessage == null ) return;
    
    if ( document.cookie.indexOf( "hidewatchlistmessage=yes" ) != -1 ) {
        watchlistMessage.style.display = "none";
    }
    
    var Button     = document.createElement( "span" );
    var ButtonLink = document.createElement( "a" );
    var ButtonText = document.createTextNode( "dismiss" );
    
    ButtonLink.setAttribute( "id", "dismissButton" );
    ButtonLink.setAttribute( "href", "javascript:dismissWatchlistMessage();" );
    ButtonLink.setAttribute( "title", "Hide this message for one week" );
    ButtonLink.appendChild( ButtonText );
    
    Button.appendChild( document.createTextNode( "[" ) );
    Button.appendChild( ButtonLink );
    Button.appendChild( document.createTextNode( "]" ) );
    
    watchlistMessage.appendChild( Button );
 }
 
 function dismissWatchlistMessage() {
     var e = new Date();
     e.setTime( e.getTime() + (7*24*60*60*1000) );
     document.cookie = "hidewatchlistmessage=yes; expires=" + e.toGMTString() + "; path=/";
     var watchlistMessage = document.getElementById("watchlist-message");
     watchlistMessage.style.display = "none";
 }
 
 addOnloadHook( addDismissButton );
 
 // Adds a Select All button to Special:Undelete and selects all checkboxs by default.
 function UndeleteAll() {
   if (wgPageName == "Special:Undelete") {
     var fi = document.getElementsByTagName("input");
     for (i = 0; i < fi.length; i++)
     {
       if (!fi[i].hasAttribute("type"))
         continue;
       if (fi[i].getAttribute("type") == "reset") {
         var sa = document.createElement("input");
         sa.setAttribute("type", "button");
         sa.setAttribute("value", "Select All");
         fi[i].parentNode.insertBefore(sa, fi[i].nextSibling);
         sa.onclick = function() {
            for (var i=0;i<fi.length;i++) {
              if (fi[i].hasAttribute("type") && fi[i].getAttribute("type") == "checkbox") {
                fi[i].checked = true;
              }
            }
         };
       } else if (fi[i].hasAttribute("type") && fi[i].getAttribute("type") == "checkbox") {
         fi[i].checked = true;
       }
     }
   }
 }
 
 addOnloadHook( UndeleteAll );
 
 //////////////////////////////////////////////////////////////////
 // BEGIN RANDOM BOOK
 //////////////////////////////////////////////////////////////////
 
 // Gets a page from the wiki and runs function action on it
 function GetPage(page, action)
 {
   var doc; 
   try { doc = new XMLHttpRequest(); }                 
   catch(e) { doc = new ActiveXObject(Microsoft.XMLHTTP); }
   
   if (doc) {
     var url = wgArticlePath;
     doc.onreadystatechange = function() { action(doc); };
     url = url.replace(/\$1$/, page);
     doc.open('GET', url+'?printable=true',  true);
     doc.overrideMimeType('text/xml');
     doc.send(null); 
   }
 }
 
 // Get a random page from Wikibooks:Alphabetical_classification
 function RandomBook()
 {
   function random_book(doc) {
     try {
       if (doc.readyState == 4 && doc.status == 200)
       {
         var wiki = doc.responseXML;
         if (wiki)
         {
           var books = wiki.getElementsByTagName('li');
           if (books && books.length > 0) {
             var page = books.item(Math.floor(Math.random() * books.length + 1)).firstChild;
             while (hasClass(page, "new") || hasClass(page, "external")) {
               page = books.item(Math.floor(Math.random() * books.length + 1)).firstChild;
             }
             window.location = page.href;
           }
         }
       }
     } catch (e) { }
   }
   GetPage("Wikibooks:Alphabetical_classification", random_book);
 }
 
 // Adds a random book link to the navigation toolbar and calls RandomBook when clicked
 function RandomBookLink() {
   var tb = document.getElementById('p-Navigation');
   var link = document.createElement('a');
   var li = document.createElement('li');
   
   if (tb) {
     tb = tb.getElementsByTagName('ul')[0];
     link.href = "javascript:RandomBook();";
     link.title = "Random Book";
     link.onmouseover = function() { window.status = "Random Book"; return true; }
     link.onmouseout = function() { window.status = ""; return true; }
     link.appendChild(document.createTextNode("Random book"));
     li.id = "n-random-book";
     li.appendChild(link);
     tb.appendChild(li);
   }
 }
 
 addOnloadHook( RandomBookLink );
 
 //</nowiki> End of Common.js

/* MediaWiki:Monobook.js (deprecated; migrate to Common.js!) */
/*
See also: [[MediaWiki:Common.js]]

<pre>
*/

/* Functions for adding links to the personal links section and the toolbox*/
function AddPersonalLink(link, text, tag, ibefore)
{
  var li = document.createElement( 'li' );
  li.id = tag;
  var a = document.createElement( 'a' );
  a.appendChild( document.createTextNode( text ) ); 
  a.href = link;
  li.appendChild( a );
  if ( ! ibefore ) // append to end (right) of list
  {
     document.getElementById( 'pt-logout' ).parentNode.appendChild( li );
  }
  else
  {
      var before = document.getElementById( ibefore );
      before.appendChild( li, before );
  }
}

function AddToolboxLink(text, href, onclick, linkid) {
  var tb = document.getElementById('p-tb').getElementsByTagName('ul')[0];
  
  var link = document.createElement('a');
  link.onclick = onclick;
  link.href = href;
  link.appendChild(document.createTextNode(text));

  var li = document.createElement('li');
  li.id = linkid;
  li.appendChild(link);

  tb.insertBefore(li, tb.firstChild);
  return;
}
/*
</pre>
*/