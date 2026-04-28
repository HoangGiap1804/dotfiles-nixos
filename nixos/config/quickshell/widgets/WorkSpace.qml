import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "../colors"

Rectangle {
    id: workspaceRectangle

    property int underlineHeight: 2
    property real fontSize: height * 0.75
    property real itemWidth: height * 0.9
    property var activeIcons: ["󰲠", "󰲢", "󰲤", "󰲦", "󰲨", "󰲪", "󰲬", "󰲮", "󰲰", "󰿬"]
    property var inActiveIcons: ["󰬺", "󰬻", "󰬼", "󰬽", "󰬾", "󰬿", "󰭀", "󰭁", "󰭂", "󰿩"]
    property int focusedId: Hyprland.focusedWorkspace !== null ? Hyprland.focusedWorkspace.id : 0

    readonly property var workspaceIds: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    readonly property var reversedWorkspaceIds: workspaceIds.slice().reverse()

    property var focusedItem: null

    anchors.verticalCenter: parent.verticalCenter
    height: parent && parent.height > 6 ? parent.height - 6 : 24
    width: Math.max(150, rowLayout.implicitWidth + 10)
    radius: 10
    color: WalColors.color8

    onFocusedIdChanged: {
        for (let i = 0; i < rowLayout.children.length; ++i) {
            if (rowLayout.children[i].workspaceId === focusedId) {
                focusedItem = rowLayout.children[i];
                return;
            }
        }
    }

    Component.onCompleted: {
        for (let i = 0; i < rowLayout.children.length; ++i) {
            if (rowLayout.children[i].workspaceId === focusedId) {
                focusedItem = rowLayout.children[i];
                return;
            }
        }
    }

    RowLayout {
        id: rowLayout
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5
        layoutDirection: Qt.RightToLeft

        Repeater {
            model: workspaceRectangle.reversedWorkspaceIds

            delegate: MouseArea {
                id: workspaceMouseArea
                width: workspaceRectangle.itemWidth
                height: workspaceRectangle.height

                readonly property int workspaceId: modelData
                readonly property bool isFocused: workspaceId === workspaceRectangle.focusedId
                readonly property bool exists: Hyprland.workspaces.values.some(ws => ws.id === workspaceId)
                readonly property color defaultItemColor: {
                    if (isFocused || exists) {
                        WalColors.color2 ? WalColors.color0 : null;
                    } else {
                        palette.text.alpha(0.4);
                    }
                }
                readonly property string icon: isFocused ? workspaceRectangle.activeIcons[workspaceId - 1] ?? "" : workspaceRectangle.inActiveIcons[workspaceId - 1] ?? ""

                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch(`workspace ${workspaceMouseArea.workspaceId}`)

                Text {
                    id: iconText
                    anchors.centerIn: parent

                    text: workspaceMouseArea.icon

                    font.pixelSize: workspaceRectangle.fontSize
                    color: workspaceMouseArea.containsMouse ? WalColors.color0 : workspaceMouseArea.defaultItemColor

                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }

                    onTextChanged: {
                        if (exists) {
                            fadeTransition.restart();
                        }
                    }

                    SequentialAnimation {
                        id: fadeTransition
                        running: false
                        PropertyAnimation {
                            target: iconText
                            property: "opacity"
                            to: 0.5
                            duration: 150
                            easing.type: Easing.InQuad
                        }
                        PropertyAnimation {
                            target: iconText
                            property: "opacity"
                            to: 1
                            duration: 150
                            easing.type: Easing.OutQuad
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: slidingIndicator

        x: workspaceRectangle.focusedItem ? rowLayout.x + workspaceRectangle.focusedItem.x : -width
        width: workspaceRectangle.focusedItem ? workspaceRectangle.focusedItem.width : 0

        height: workspaceRectangle.underlineHeight
        anchors.bottom: parent.bottom
        color: WalColors.color1
        radius: height / 2

        Behavior on x {
            NumberAnimation {
                duration: 250
                easing.type: Easing.InOutCubic
            }
        }
        Behavior on width {
            NumberAnimation {
                duration: 250
                easing.type: Easing.InOutCubic
            }
        }
    }
}
