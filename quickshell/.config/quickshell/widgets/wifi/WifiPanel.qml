import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import QtQuick.Controls.Basic
import "../../colors"

PanelWindow {
    id: wifiPanel 
    
    property bool active: WifiPanelSingleton.active

    anchors {
        top: true
        right: true
    }
    
    margins {
        top: 15
        right: 15
    }
    
    aboveWindows: true 
    implicitHeight: 500
    implicitWidth: 320
    visible: active || (contentRect.opacity > 0)
    color: "transparent"
    exclusionMode: ExclusionMode.None
    
    focusable: showingPasswordInput // Only take focus when inputting password

    property var wifiList: []
    property string selectedSsid: ""
    property bool showingPasswordInput: false

    function refreshWifi() {
        wifiProc.running = true
    }

    onActiveChanged: {
        if (active) {
            refreshWifi()
            showingPasswordInput = false
        }
    }

    onShowingPasswordInputChanged: {
        if (showingPasswordInput) {
            passInput.forceActiveFocus()
        }
    }

    Process {
        id: wifiProc
        command: ["sh", "-c", "nmcli -t -f ACTIVE,SSID,SIGNAL,SECURITY dev wifi"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = text.trim().split("\n")
                let newList = []
                for (let line of lines) {
                    if (line.trim() === "") continue
                    let parts = line.split(":")
                    if (parts.length >= 4) {
                        newList.push({
                            active: parts[0] === "*",
                            ssid: parts[1],
                            signal: parts[2],
                            security: parts[3]
                        })
                    }
                }
                wifiPanel.wifiList = newList
                wifiProc.running = false
            }
        }
    }

    Process {
        id: connectProc
        property string ssid: ""
        property string password: ""
        command: ["sh", "-c", `nmcli dev wifi connect "${ssid}" password "${password}"`]
        stdout: StdioCollector {
            onStreamFinished: {
                wifiPanel.showingPasswordInput = false
                refreshWifi()
                connectProc.running = false
            }
        }
    }

    Rectangle {
      id: contentRect
      anchors.top: parent.top
      anchors.right: parent.right
      width: 300
      height: showingPasswordInput ? 200 : Math.min(450, mainLayout.implicitHeight + 40)
      
      color: WalColors.background
      border.color: WalColors.color5
      border.width: 1
      radius: 12
      
      opacity: wifiPanel.active ? 0.98 : 0
      scale: wifiPanel.active ? 1 : 0.95
      
      Behavior on opacity { NumberAnimation { duration: 150 } }
      Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }
      Behavior on height { NumberAnimation { duration: 200 } }

      /* layer.enabled: true
      layer.effect: MultiEffect {
          shadowEnabled: true
          shadowBlur: 0.8
          shadowColor: "#80000000"
          shadowVerticalOffset: 4
      } */

      ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: 15
        spacing: 12

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: showingPasswordInput ? "Connect to WiFi" : "WiFi Networks"
                font.pixelSize: 16
                font.bold: true
                color: WalColors.foreground
                Layout.fillWidth: true
            }
            
            // Reload button
            Text {
                visible: !showingPasswordInput
                text: "󰑐"
                font.pixelSize: 18
                color: wifiProc.running ? WalColors.color8 : WalColors.color5
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: refreshWifi()
                    cursorShape: Qt.PointingHandCursor
                }
                
                RotationAnimation on rotation {
                    running: wifiProc.running
                    loops: Animation.Infinite
                    from: 0
                    to: 360
                    duration: 1000
                }
            }

            Text {
                text: "󰖩"
                font.pixelSize: 18
                color: WalColors.color5
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: WalColors.color8
            opacity: 0.2
        }

        // List View
        ScrollView {
          visible: !showingPasswordInput
          Layout.fillWidth: true
          Layout.fillHeight: true
          clip: true
          ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

          ColumnLayout {
            width: mainLayout.width - 30
            spacing: 8

            Repeater {
              model: wifiPanel.wifiList
              WifiEntry {
                ssid: modelData.ssid
                signal: modelData.signal
                security: modelData.security
                active: modelData.active
                onClicked: {
                    if (active) return
                    wifiPanel.selectedSsid = ssid
                    wifiPanel.showingPasswordInput = true
                }
              }
            }
          }
        }

        // Password Input UI
        ColumnLayout {
            visible: showingPasswordInput
            Layout.fillWidth: true
            spacing: 15

            Text {
                text: "SSID: " + wifiPanel.selectedSsid
                color: WalColors.foreground
                font.pixelSize: 12
                opacity: 0.8
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            TextField {
                id: passInput
                Layout.fillWidth: true
                placeholderText: "Enter password..."
                echoMode: TextField.Password
                color: WalColors.foreground
                focus: wifiPanel.showingPasswordInput
                
                background: Rectangle {
                    color: WalColors.color8
                    opacity: 0.2
                    radius: 5
                    border.color: passInput.activeFocus ? WalColors.color5 : "transparent"
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Button {
                    text: "Cancel"
                    Layout.fillWidth: true
                    onClicked: wifiPanel.showingPasswordInput = false
                    background: Rectangle {
                        color: WalColors.color8
                        opacity: 0.3
                        radius: 5
                    }
                    contentItem: Text {
                        text: parent.text
                        color: WalColors.foreground
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Button {
                    text: "Connect"
                    Layout.fillWidth: true
                    onClicked: {
                        connectProc.ssid = wifiPanel.selectedSsid
                        connectProc.password = passInput.text
                        connectProc.running = true
                    }
                    background: Rectangle {
                        color: WalColors.color5
                        radius: 5
                    }
                    contentItem: Text {
                        text: parent.text
                        color: WalColors.background
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                    }
                }
            }
        }
      }
    }

    // Close when clicking outside
    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: WifiPanelSingleton.active = false
    }
}
