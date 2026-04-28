import Quickshell
import QtQuick
import QtQuick.Layouts
import "./colors"

PanelWindow {
    id: rightEdgePanel

    anchors {
        top: true
        right: true
    }
    
    margins {
        top: 100
        right: 15
    }
    
    aboveWindows: true 
    implicitHeight: 500
    implicitWidth: 500
    
    color: "transparent"
    exclusionMode: ExclusionMode.None
    
    Rectangle {
        id: body
        anchors.fill: parent
        anchors.margins: 12
        radius: 16
        
        // Use colors from your system (WalColors)
        color: WalColors.background
        opacity: 0.6
        
        
    }
}
