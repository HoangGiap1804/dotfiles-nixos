// AudioPanelSingleton.qml
pragma Singleton
import QtQuick 
import Quickshell

PersistentProperties {
    id: singleton

    property bool visible: false   // điều khiển hiển thị
    property PanelWindow panel: null

    function toggle() {
        if (panel) {
            panel.visible = !panel.visible
        }
        visible = panel ? panel.visible : false
        console.log("Gia tri "+panel.visible);
    }

    function show() {
        if (panel) panel.visible = true
        visible = true
    }

    function hide() {
        if (panel) panel.visible = false
        visible = false
    }
}
