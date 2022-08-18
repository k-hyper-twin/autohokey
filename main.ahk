;------------------------------------------------------------------------------
; AutoHotKeyの使用方法
; https://so-zou.jp/software/tool/system/auto-hot-key/hotkeys/
; キーボードの入力スピードを飛躍的に向上させる入力テクニック
; http://sato001.com/high-speed-input-keyboard
;
;  前提：
;    Change Key使用
;      Caps Lock -> 左Ctrl
;    HHKB使用
;
;おまじない　https://qiita.com/ryoheiszk/items/092cc5d76838cb5a13f1
#Persistent
#SingleInstance, Force
#NoEnv
#UseHook
#InstallKeybdHook
#InstallMouseHook
#HotkeyInterval, 2000
#MaxHotkeysPerInterval, 200
Process, Priority,, Realtime
SendMode, Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

; 変換を修飾キーとして扱うための準備
; 変換を押し続けている限りリピートせず待機
$vk1C::
    startTime := A_TickCount
    KeyWait, vk1C
    keyPressDuration := A_TickCount - startTime
    ; 変換を押している間に他のホットキーが発動した場合は入力しない
    ; 変換を長押ししていた場合も入力しない
    If (A_ThisHotkey == "$vk1C" and keyPressDuration < 200) {
        Send,{vk1C}
    }
    Return

; 無変換を修飾キーとして扱うための準備
; 無変換を押し続けている限りリピートせず待機
; ※無変換＋スペースでEnterを押しているので、押し間違いが多発したため停止中
$vk1D::
    startTime := A_TickCount
    KeyWait, vk1D
    keyPressDuration := A_TickCount - startTime
    ; 無変換を押している間に他のホットキーが発動した場合は入力しない
    ; 無変換を長押ししていた場合も入力しない
    If (A_ThisHotkey == "$vk1D" and keyPressDuration < 120) {
        Send,{vk1D}
    }
    Return

; Tabを修飾キーとして扱うための準備
; Tabを押し続けている限りリピートせず待機
$Tab::
    startTime := A_TickCount
    KeyWait, Tab
    keyPressDuration := A_TickCount - startTime
    ; Tabを押している間に他のホットキーが発動した場合は入力しない
    ; Tabを長押ししていた場合も入力しない
    If (A_ThisHotkey == "$Tab" and keyPressDuration < 200) {
        Send,{Tab}
    }
    Return

; Ctrlを空打ちした場合ESCキーを入力する
$Ctrl::
    startTime := A_TickCount
    KeyWait, Ctrl
    keyPressDuration := A_TickCount - startTime
    ; Ctrlを押している間に他のホットキーが発動した場合は入力しない
    ; Ctrlを長押ししていた場合も入力しない
    If (A_ThisHotkey == "$Ctrl" and keyPressDuration < 200) {
        Send,{Esc}
    }
    Return


; ■無変換+スペースでEnterの動作
; 　無変換キーは左
~vk1D & Space::Send,{Blind}{Enter}    ;Enter
; ■無変換+:でDEL、無変換+;でBSの動作
~vk1D & vkBA::Send,{Delete}           ;Del
~vk1D & vkBB::Send,{BS}               ;BS
; ■無変換+HJKLで矢印キーの動作(Vim方式)
; Blindは他キーとの同時打鍵を有効にするものです。
~vk1D & H::Send,{Blind}{Left}         ;Left
~vk1D & J::Send,{Blind}{Down}         ;Down
~vk1D & K::Send,{Blind}{Up}           ;Up
~vk1D & L::Send,{Blind}{Right}        ;Right
~vk1D & Q::Send,{LButton}             ;左クリック
~vk1D & E::Send,{RButton}             ;右クリック
~vk1D & Z::Send,{WheelLeft}           ;WheelLeft
~vk1D & X::Send,{MButton}             ;中クリック
~vk1D & C::Send,{WheelRight}          ;WheelRight
~vk1D & R::Send,{WheelUp}             ;WheelUp
~vk1D & F::Send,{WheelDown}           ;WheelDown
~vk1D & U::Send,^c                    ;Ctrl+C
~vk1D & I::Send,^z                    ;Ctrl+Z
~vk1D & O::Send,^v                    ;Ctrl+V
~vk1D & P::Send,{Blind}{vkBD}         ;マイナスキー
~vk1D & vk1C::Send,{vkF3}             ;変換
~vk1D & N::Send,{Blind}+{6}           ;無変換 + N = &
~vk1D & M::Send,{Blind}+{7}           ;無変換 + M = '
~vk1D & ,::Send,{Blind}+{8}           ;無変換 + , = (
~vk1D & .::Send,{Blind}+{9}           ;無変換 + . = )
;~vk1D & V::Send,{Blind}{Enter}        ;Enter
;~vk1D & H::Send,{Blind}{Esc}          ;Esc
;~vk1D & C::Send,{Blind}{LWin}         ;LWin
;~vk1D & W::Send,{WheelUp}             ;WheelUp
;~vk1D & S::Send,{WheelDown}           ;WheelDown
; ■無変換+マウスとの組み合わせ
~vk1D & LButton::Send,^c              ;Ctrl+C
~vk1D & RButton::Send,^v              ;Ctrl+V
~vk1D & MButton::Send,^z              ;Ctrl+z

; ■マウス操作
; 無変換 + WASD = マウスカーソル上, 左, 下, 右
; そのままだと細かい操作には向くが大きな移動には遅すぎる
; カーソル操作中にCtrlキーを一瞬押すといい感じにブーストできる
; CtrlとShiftでの加速減速はWindowsのマウスキー機能を踏襲
; 精密操作がしたい時は 変換+Shift+WASD でカーソルをゆっくり動かせる
;~vk1D & W::MouseMove 0,-20,0,R        ;マウスカーソル移動(上) 無変換 + ↑
;~vk1D & S::MouseMove 0,20,0,R         ;マウスカーソル移動(下) 無変換 + ↓
;~vk1D & A::MouseMove -20,0,0,R        ;マウスカーソル移動(左) 無変換 + ←
;~vk1D & D::MouseMove 20,0,0,R         ;マウスカーソル移動(右) 無変換 + →
~vk1D & W::
~vk1D & A::
~vk1D & S::
~vk1D & D::
    While (GetKeyState("vk1D", "P"))                 ; 無変換キーが押され続けている間マウス移動の処理をループさせる
    {
        MoveX := 0, MoveY := 0
        MoveY += GetKeyState("W", "P") ? -11 : 0     ; 無変換キーと一緒にIJKLが押されている間はカーソル座標を変化させ続ける
        MoveX += GetKeyState("A", "P") ? -11 : 0
        MoveY += GetKeyState("S", "P") ? 11 : 0
        MoveX += GetKeyState("D", "P") ? 11 : 0
        MoveX *= GetKeyState("Ctrl", "P") ? 10 : 1   ; Ctrlキーが押されている間は座標を10倍にし続ける(スピードアップ)
        MoveY *= GetKeyState("Ctrl", "P") ? 10 : 1
        MoveX *= GetKeyState("Shift", "P") ? 0.15 : 1 ; Shiftキーが押されている間は座標を15%にする（スピードダウン）
        MoveY *= GetKeyState("Shift", "P") ? 0.15 : 1
        MouseMove, %MoveX%, %MoveY%, 1, R            ; マウスカーソルを移動する
        Sleep, 0                                     ; 負荷が高い場合は設定を変更 設定できる値は-1、0、10～m秒 詳細はSleep
    }
    Return

; ■無変換組み合わせ未使用
;~vk1D & 1::Send,{Blind}{F1}
;~vk1D & 2::Send,{Blind}{F2}
;~vk1D & 3::Send,{Blind}{F3}
;~vk1D & 4::Send,{Blind}{F4}
;~vk1D & 5::Send,{Blind}{F5}
;~vk1D & 6::Send,{Blind}{F6}
;~vk1D & 7::Send,{Blind}{F7}
;~vk1D & 8::Send,{Blind}{F8}
;~vk1D & 9::Send,{Blind}{F9}
;~vk1D & 0::Send,{Blind}{F10}
;~vk1D & -::Send,{Blind}{F11}
;~vk1D & ^::Send,{Blind}{F12}
;~vk1D & Q::Send,{Blind}{Esc}
;~vk1D & A::Send,{Blind}{Del}
;~vk1D & W::Send,{Blind}{Up}           ;Up
;~vk1D & A::Send,{Blind}{Left}         ;Left
;~vk1D & S::Send,{Blind}{Down}         ;Down
;~vk1D & D::Send,{Blind}{Right}        ;Right

; ■変換組み合わせ
; 　変換キーは右
~vk1C & Q::Send,{Blind}#^{Right}       ;Windows + ctrl + →
~vk1C & W::Send,{Blind}!{F4}           ;Alt+F4
~vk1C & E::Send,{Blind}{Esc}           ;Esc
~vk1C & R::Send,{Blind}#^{Left}        ;Windows + ctrl + ←
;~vk1C & Y::Send,{Blind}+!{Tab}         ;Shift+Alt+Tab
~vk1C & Y::Send,{Blind}+!{Tab}         ;Shift+Alt+Tab
~vk1C & U::Send,{Blind}{Home}          ;Home
~vk1C & I::Send,{Blind}{End}           ;End
;~vk1C & O::Send,{Blind}!{Tab}          ;      Alt+Tab
~vk1C & O::AltTabMenu                  ;windowsのAltTabMenuを表示しっぱなしにする(Alt+Tabだけだとmenuがすぐ消えるためO
;~vk1C & P::Send,{Blind}{PrintScreen}   ;PrintScreen
~vk1C & H::Send,{Blind}{Left}          ;Left
~vk1C & J::Send,{Blind}{Down}          ;Down
~vk1C & K::Send,{Blind}{Up}            ;Up
~vk1C & L::Send,{Blind}{Right}         ;Right
~vk1C & Z::Send,{Blind}+{1}            ; 変換 + Z = !
~vk1C & X::Send,{Blind}+{2}            ; 変換 + X = ""
~vk1C & C::Send,{Blind}+{3}            ; 変換 + C = #
~vk1C & V::Send,{Blind}+{4}            ; 変換 + V = $
~vk1C & B::Send,{Blind}+{5}            ; 変換 + B = %
~vk1C & M::Send,{Blind}+^{Tab}         ;Shift+Ctrl+Tab
~vk1C & ,::Send,{Blind}{PgUp}          ;PageUp
~vk1C & .::Send,{Blind}{PgDn}          ;PageDown
~vk1C & /::Send,{Blind}^{Tab}          ;      Ctrl+Tab

; ■右シフトはPauseに変更
~RShift::Send,{Blind}{Pause}

; ■マクロキー
; 英語ページを日本語に(ctrl + qキーを押すとGoogle翻訳の機能拡張を開いて日本語翻訳する。要ChromeにGoogle翻訳のインストールとChromeのショートカット・キー設定Alt+t)
^q::
  Send, !t            ;Alt+tキーでGoogle翻訳を開く
  Sleep, 1000         ;1000ms待つ
  Send, {Tab}         ;tabキーを押す
  Sleep, 1000         ;1000ms待つ
  Send, {Tab}         ;tabキーを押す
  Sleep, 1000         ;1000ms待つ
  Send, {Enter}       ;Enterキーを押す
  Return
; SeleniumIDE用(ctrl + shift + eキーを押すとSeleniumIDEの機能拡張を開いてsideファイルを開いてマクロ実行する。要ChromeにSeleniumIDEのインストールとChromeのショートカット・キー設定(Alt+z)
^+e::
  Send, !z            ;Alt+zキーでSeleniumIDEを開く
  Sleep, 3000         ;3000ms待つ
  Send, {Tab}         ;tabキーを押す
  Sleep, 3000         ;3000ms待つ
  Send, {Enter}       ;Enterキーを押す
  Sleep, 3000         ;3000ms待つ
  Send, O{NumpadDot}side ;O.sideと文字を打つ
  Sleep, 3000         ;3000ms待つ
  Send, !o            ;Alt+oキーで開く
  Sleep, 3000         ;3000ms待つ
  Send, ^r            ;Cntr+rキーでマクロ実行
  Sleep, 5000         ;5000ms待つ
  Send, !{Tab}        ;Alt+tabキーを押す
  Sleep, 5000         ;5000ms待つ
  Send, #{Down}       ;WindowsKey+Downキーを押す

; チューニングしてるとだんだんスクリプトの編集・ロードをこまめにやりたくなってくるので追加
; Editだとnotepad.exeが起動するが、VSCodeで編集したかったのでRunで記述
; フルパスを書く必要がある
; 環境変数は使わなくてもいいけどGistで公開する際のユーザー名マスク用途で使っている
; 同じキーマップを使いたくなったらコメントアウトする
; 無変換 + 1 = スクリプト編集
~vk1D & 1::
    Run, "C:\Program Files (x86)\sakura\sakura.exe" "E:\AutoHotkey\main.ahk"
    Return
~vk1D & 2::Reload               ; 無変換 + 2 = スクリプトのリロード
~vk1D & 3::Suspend              ; 無変換 + 3 = スクリプトのサスペンド(ON OFF切り替え>

  
; Tabとの組み合わせで括弧とその他の記号を入力する
; 下記、~を先頭に付与することでTabキー本来の動きも使えるようにしている
~Tab & H::Send,{Blind}{[}          ; Tab + H = [
~Tab & J::Send,{Blind}{]}          ; Tab + J = ]
~Tab & K::Send,{Blind}+{[}         ; Tab + K = {
~Tab & L::Send,{Blind}+{]}         ; Tab + L = }
~Tab & N::Send,{Blind}+{8}         ; Tab + N = (
~Tab & M::Send,{Blind}+{9}         ; Tab + M = )
~Tab & ,::Send,{Blind}+{,}         ; Tab + , = <
~Tab & .::Send,{Blind}+{.}         ; Tab + . = >
~Tab & vkBB::Send,{Blind}+{sc01A}  ; Tab + ; = `
~Tab & /::Send,{Blind}+{sc00D}     ; Tab + / = ~

;------------------------------------------------------------------------------
;   第５弾 数字キー行
;       数字キー行の記号をホームポジションから入力できるようになると、
;       今度は数字キーも遠く感じるようになる。
;       一方で、英数字を絡めた入力をする際には1キーで数字を入力できる方が効率的だと感じることもある
;       できるだけ数字キー行と同じような入力体験を維持したままホームポジションから手を動かさない入力を行いたい
;       上記を満たすため、Tabキーと数字キーの下の行の組み合わせで入力できるようにする
;------------------------------------------------------------------------------

; Tabとの組み合わせで数字キー入力
~Tab & Q::Send,{Blind}{1}          ; Tab + Q = 1
~Tab & W::Send,{Blind}{2}          ; Tab + W = 2
~Tab & E::Send,{Blind}{3}          ; Tab + E = 3
~Tab & R::Send,{Blind}{4}          ; Tab + R = 4
~Tab & T::Send,{Blind}{5}          ; Tab + T = 5
~Tab & Y::Send,{Blind}{6}          ; Tab + Y = 6
~Tab & U::Send,{Blind}{7}          ; Tab + U = 7
~Tab & I::Send,{Blind}{8}          ; Tab + I = 8
~Tab & O::Send,{Blind}{9}          ; Tab + O = 9
~Tab & P::Send,{Blind}{0}          ; Tab + P = 0

;------------------------------------------------------------------------------
;   第６弾 特定のアプリの時だけ動作するコード
;------------------------------------------------------------------------------
; VS Code
#IfWinActive,ahk_exe Code.exe
~vk1D & @::Send,^+P                   ;Ctrl+Shift+P(無変換+@で２コマンドパレット起動)
return
#IfWinActive


; ============================================================
; ============================================================
; ============================================================
; XXXXXX_残骸_XXXXXX
; ============================================================
; ============================================================
; ============================================================
/*
; RWinキー2連打でWin+Ctl+右矢印（仮想デスクトップの次の画面に移動）
RWin::
  KeyWait, RWin
  if (A_PriorHotkey == A_ThisHotkey) && (300 > A_TimeSincePriorHotkey)
    Send, #^{Right}
  else
    Send, {Rwin}
return

; 右矢印2連打でWin+Ctl+右矢印（仮想デスクトップの次の画面に移動）
$vk27::
  KeyWait, vk27
  if (A_ThisHotkey == $vk27) && (A_TimeSincePriorHotkey < 300)
    Send, #^{Right}
  else
return

; 左矢印2連打でWin+Ctl+右矢印（仮想デスクトップの次の画面に移動）
$vk25::
  if (A_PriorHotkey == A_ThisHotkey) && (300 > A_TimeSincePriorHotkey)
    Send, #^{Left}
  else
    Send, {Left}
return

; ■同じキーを2連打(300ミリ秒以内の入力に限定)
; 無変換2連打でBS
vk1D::
  KeyWait, vk1D
  if (A_PriorHotkey == A_ThisHotkey) && (300 > A_TimeSincePriorHotkey)
    Send, {BS}
return

; 変換2連打でDEL
vk1C::
  KeyWait, vk1C
  if (A_PriorHotkey == A_ThisHotkey) && (300 > A_TimeSincePriorHotkey)
    Send, {DEL}
return
*/
