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
        left: true
    }

    BarCorner {
        id: topRightBarCorner
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        position: "bottom-left"
        shapeColor: WalColors.background
    }
}
