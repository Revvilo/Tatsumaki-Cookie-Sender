#SingleInstance, force
#NoEnv
SetTitleMatchMode, 2

command := "t!cookie "
user := ""

While, user == "" {
    user := GetTargetFromUser()
    if(ErrorLevel)
        ExitApp
}

return

GetTargetFromUser() {
    InputBox, user, %A_ScriptName% - Enter Discord Username, % "Please enter the exact name of the Discord user you wish to automatically send cookies to`n`nOnce you hit OK, press ALT+F to start and stop the automatic loop, and press ALT+CTRL+F to exit the script completely.`n`nKeep Discord focused for messages to be entered.`nDon't worry about focusing another window by mistake. Messages won't be entered into anything other than Discord.`n`n Just make sure you're in the right channel!",,,320
    return user
}

SendCookie:
    if (!loopEnabled)
        SetTimer, SendCookie, Off
    temp := Clipboard
    Clipboard := command user
    ControlSend,, {ctrl down}v{ctrl up}, Discord
    ControlSend,, {enter}, Discord
    Clipboard := temp
    Sleep, 5010
return

!^F::
    TrayTip,, % "Exiting Script..."
    ExitApp
return

!F::
    KeyWait, Alt
    if (loopEnabled) {
        loopEnabled = 0
        SetTimer, SendCookie, Off
    } else {
        loopEnabled = 1
        SetTimer, SendCookie, On
    }
    TrayTip,, % loopEnabled ? "Loop started. Messages won't be entered into Discord unless the window is focused." : "Loop stopped. You may use your PC."
return