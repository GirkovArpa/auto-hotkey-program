
Gui, Add, ComboBox, x12 y9 w100 h200, A||B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, ComboBox, x122 y9 w100 h200, A|B||C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, ComboBox, x232 y9 w100 h200, A||B|C||D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|0|1|2|3|4|5|6|7|6|8|9
Gui, Add, Button, x12 y39 w320 h30 gActivate, Activate
Gui, Add, ListBox, x12 y79 w320 h210, ListBox
; Generated using SmartGUI Creator 4.0
Gui, Show, x511 y196 h294 w347, 

global activated := false

Activate() {
  activated := true
}

global ctrl_i_pressed := false
global t_pressed := false
global t_released := false

SetTimer, myLoop, 0

myLoop(){
    if (!activated) { 
      return 
    }
    if (t_pressed) {
      Send, {z down}
    }
}

^i::
  if (!activated) {
    return
  }
  ctrl_i_pressed := true
  return

$t::
  if (!activated) {
    Send, {t down}
    return
  }
  if (ctrl_i_pressed) {
    t_pressed := true
    return
  }
  Send, {t down}
  return

t up::
  if (!activated) {
    Send, {t up}
    return
  }
  if (t_pressed and not t_released) {
    t_released := true 
    return
  }
  if (t_released) {
    ctrl_i_pressed := false
    t_pressed := false
    t_released := false
    return
  }
  Send, {t up}
  return