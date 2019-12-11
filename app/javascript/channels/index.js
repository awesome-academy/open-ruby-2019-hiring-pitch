// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

setTimeout(() => {
  const textHide = document.getElementsByClassName("hide-text");
  for (let i = 0; i < textHide.length; i++) {
    textHide[i].style.display = "block";
    textHide[i].style.width = "300px";
    textHide[i].style.overflow = "hidden";
    textHide[i].style.whiteSpace = "nowrap";
  }}, 1000);

showText = (current) => {
  var text = current.previousSibling;
  if (text.hasAttribute("style")) {
    text.removeAttribute("style");
  } 
  else {
    text.style.display = "block";
    text.style.width = "300px";
    text.style.overflow = "hidden";
    text.style.whiteSpace = "nowrap";
  }
}
