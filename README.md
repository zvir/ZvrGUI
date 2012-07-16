ZvrGUI
======
ZvrGUI in Acition
[![Launch Examples](http://www.zvir.pl/gui/ZvrGUIinActionSmall.png)](http://www.zvir.pl/gui/ZvrGUIinAction.png)

Click to see full image

Features:

- simple and pure as3
- real time - no invalitation like in FlexComponent
- every action has its own event
- skins (component = component base + skin)
- styles (custom values, attached to one or more state)
- states (multi state - more than one state at the time e.g: selected, over, down. No more selectedAndDown)
- behaviors (for conecting usert input with states or functionality of component, eg: dragable, rollOver)
- layouts - managing of childs distribution 

drawbacks:
- multi state styles are a little bit tricky
- changing component properties: width, height, x, y, top, left, bottom, right, left can be a little bit funky (due explicit priorities)
- data contaier is not as fast as it should be
- skin cannot be changed to another one