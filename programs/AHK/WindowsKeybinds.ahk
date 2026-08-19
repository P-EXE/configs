#Requires AutoHotkey v2.0
#include ./lib/VD.ahk

#q:: WinKill("A")

$#1::VD.goToDesktopNum(1)
$#2::VD.goToDesktopNum(2)
$#3::VD.goToDesktopNum(3)
$#4::VD.goToDesktopNum(4)
$#5::VD.goToDesktopNum(5)
$#6::VD.goToDesktopNum(6)
$#7::VD.goToDesktopNum(7)
$#8::VD.goToDesktopNum(8)
$#9::VD.goToDesktopNum(9)
$#0::VD.goToDesktopNum(10)

$#+1::VD.MoveWindowToDesktopNum("A",1,true)
$#+2::VD.MoveWindowToDesktopNum("A",2,true)
$#+3::VD.MoveWindowToDesktopNum("A",3,true)
$#+4::VD.MoveWindowToDesktopNum("A",4,true)
$#+5::VD.MoveWindowToDesktopNum("A",5,true)
$#+6::VD.MoveWindowToDesktopNum("A",6,true)
$#+7::VD.MoveWindowToDesktopNum("A",7,true)
$#+8::VD.MoveWindowToDesktopNum("A",8,true)
$#+9::VD.MoveWindowToDesktopNum("A",9,true)
$#+0::VD.MoveWindowToDesktopNum("A",10,true)