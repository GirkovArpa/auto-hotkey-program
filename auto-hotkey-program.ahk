Gui, Add, ComboBox, x12 y9 w100 h200 vKey1, A||B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, ComboBox, x122 y9 w100 h200 vKey2, A|B||C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, ComboBox, x232 y9 w100 h200 vKey3, A||B|C||D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, Button, x12 y39 w320 h30 gActivate, Activate
Gui, Add, ListBox, x12 y79 w320 h210, ListBox
Gui, Show, x511 y196 h294 w347, 

;global VAR := "A"
;global VAR2 := "B"

;Hotkey,~%VAR% & %VAR2%,Button
;Return
;Button() {
;MsgBox You pressed %VAR%%VAR2%
;Return
;}

global activated := false
global Key1 := "a"
global Key2 := "b"
global Key3 := "c"

Activate() { 
  activated := true
  GuiControlget,Key1,,Key1 
  GuiControlget,Key2,,Key2 
  GuiControlget,Key3,,Key3 
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
;Return

KEY1_KEY2() {
  ;MsgBox "KEY1_KEY2"
  if (!activated) {
    return
  }
  KEY1_PRESSED := true
  return
}

Hotkey,%Key2%,KEY2
;Return

KEY2() {
  ;MsgBox "KEY2"
  if (!activated) {
    Send, {%KEY% down}
    return
  }
  if (KEY1_PRESSED) {
    KEY2_PRESSED := true
    return
  }
  Send, {t down}
  return
}

Hotkey,%Key2% up,KEY2_UP
;return

KEY2_UP() {
  ;MsgBox "KEY2_UP"
  if (!activated) {
    Send, {t up}
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
    return
  }
  Send, {t up}
  return
}