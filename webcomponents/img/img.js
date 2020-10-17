var theimg=document.getElementById("theimg")

if ( document.addEventListener ) {
  addEv = function ( el, e, f ) { el.addEventListener( e, f, false ) }
} else {
  addEv = function ( el, e, f ) { el.attachEvent( "on" + e, f ) }
}
addEv(document,"click",handleClick);

function getEvTarget(event) {
  if (!event) {
    return undefined;
  }
  if(event.REPLAYTARGET) { return event.REPLAYTARGET; }
  return event.target ? 
    ((event.target.nodeType==3)?event.target.parentElement:event.target)
    : event.srcElement;
}

function handleClick(ev) {
  var target = getEvTarget(ev);
  if(target.tagName=="IMG") {
    gICAPI.Action("click");
  }
  return true;
}

onICHostReady = function(version) {
   gICAPI.onFocus = function(polarity) {
   }
   gICAPI.onData = function(data) {
     theimg.src=data;
   }
   gICAPI.onProperty = function(p) {
   }
}
