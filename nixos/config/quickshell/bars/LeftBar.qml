import Quickshell
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Services.Pipewire

import "../widgets"
import "../widgets/audio"
import "../colors"

PanelWindow {
    id: leftBar 

    property bool isExpand: true 

    anchors {
        top: true
        left: true
        bottom: true
    }
    implicitWidth: (isExpand) ? 250 : 60
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 100
            easing.type: Easing.InOutCubic
        }
    }

    color: WalColors.background

    ColumnLayout{
        anchors.fill: parent
        Button{
            text: "Change"
            Layout.preferredWidth: 30
            onClicked: isExpand = !isExpand
        }
        Rectangle{
            Layout.fillHeight: true 
            Layout.minimumHeight: 100
            Layout.preferredHeight: 200
            Layout.preferredWidth: leftBar.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: "red"
            ScrollView {
                anchors.fill: parent
                contentWidth: availableWidth

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    // get a list of nodes that output to the default sink
                    PwNodeLinkTracker {
                        id: linkTracker
                        node: Pipewire.defaultAudioSink
                    }

                    MixerEntry {
                        anchors.fill: parent
                       node: Pipewire.defaultAudioSink
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        color: "#000" 
                        implicitHeight: 1
                    }

                    // Repeater {
                    //     model: linkTracker.linkGroups
                    //
                    //     MixerEntry {
                    //         required property PwLinkGroup modelData
                    //         // Each link group contains a source and a target.
                    //         // Since the target is the default sink, we want the source.
                    //         node: modelData.source
                    //     }
                    // }
                }
            }
        }
        Rectangle{
            Layout.fillHeight: true 
            Layout.minimumHeight: 100
            Layout.preferredHeight: 300
            Layout.preferredWidth: leftBar.width
            color: "blue"
        }
        Rectangle{
            Layout.fillHeight: true 
            Layout.minimumHeight: 100
            Layout.preferredHeight: 300
            Layout.preferredWidth: leftBar.width
            color: "green"
        }
    }
}
