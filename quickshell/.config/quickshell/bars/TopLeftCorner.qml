import Quickshell
import Quickshell.Wayland
import QtQuick

import "../widgets"
import "../colors"

PanelWindow {
    id: root
    exclusionMode: ExclusionMode.Normal

    focusable: false 
    aboveWindows: false 
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    color: "transparent"

    mask: Region {}

    anchors {
        top: true
        left: true
    }

    BarCorner {
        id: topRightBarCorner
        anchors {
            top: parent.top
            left: parent.left
        }
        position: "top-left"
        shapeColor: WalColors.background
    }
}

