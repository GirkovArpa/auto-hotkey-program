Menu, Tray,  Icon, icon.ico
Gui, Add, ComboBox, x12 y9 w100 h200 vKey1, A||B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, ComboBox, x122 y9 w100 h200 vKey2, A|B||C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, ComboBox, x232 y9 w100 h200 vKey3, A||B|C||D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, Button, x12 y39 w320 h30 gActivate, Activate
Gui, Show, x511 y196 h80 w347, Auto Hotkey Program


global activated := false
global Key1 := "a"
global Key2 := "b"
global Key3 := "c"

Activate() { 
  activated := true
  GuiControlget,Key1,,Key1 
  GuiControlget,Key2,,Key2 
  GuiControlget,Key3,,Key3 

  StringLower, Key1, Key1
  StringLower, Key2, Key2
  StringLower, Key3, Key3

  Hotkey,~%Key1% & %Key2%,KEY1_KEY2
  Hotkey,%Key2%,KEY2
  Hotkey,%Key2% up,KEY2_UP
}

global KEY1_PRESSED := false
global KEY2_PRESSED := false
global KEY2_RELEASED := false

SetTimer, myLoop, 0

myLoop(){
    if (!activated) { 
      return 
    }
    if (KEY2_PRESSED) {
      Send, {%Key3% down}
    }
}

Hotkey,~%Key1% & %Key2%,KEY1_KEY2

KEY1_KEY2() {
  if (!activated) {
    return
  }
  KEY1_PRESSED := true
  return
}

Hotkey,%Key2%,KEY2

KEY2() {
  if (!activated) {
    Send, {%KEY2% down}
    return
  }
  if (KEY1_PRESSED) {
    KEY2_PRESSED := true
    return
  }
  Send, {%KEY2% down}
  return
}

Hotkey,%Key2% up,KEY2_UP

KEY2_UP() {
  if (!activated) {
    Send, {%KEY2% up}
    return
  }
  if (KEY2_PRESSED and not KEY2_RELEASED) {
    KEY2_RELEASED := true 
    return
  }
  if (KEY2_RELEASED) {
    KEY1_PRESSED := false
    KEY2_PRESSED := false
    KEY2_RELEASED := false
    Hotkey,~%Key1% & %Key2%, Off
    Hotkey,%Key2%, Off
    Hotkey,%Key2% up, Off
    return
  }
  Send, {%KEY2% up}
  return
}

global canClose := false

GuiClose:
  if (not canClose) {
    canClose := true
    return
  }
  if (canClose) {
    exitapp
  }
return