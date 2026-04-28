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
        bottom: true
        right: true
    }

    BarCorner {
        id: topRightBarCorner
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        position: "bottom-right"
        shapeColor: WalColors.background
    }
}

