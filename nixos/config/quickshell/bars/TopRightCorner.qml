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

    color: "transparent"

    anchors {
        top: true
        right: true
    }

    BarCorner {
        id: topRightBarCorner
        anchors {
            top: parent.top
            right: parent.right
        }
        position: "top-right"
        shapeColor: WalColors.background
    }
}

