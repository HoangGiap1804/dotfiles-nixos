import QtQuick
import QtQuick.Controls.Basic

Button {
    id: button
    required property string colorBorder;
    required property string colorButtonUp;
    required property string colorButtonDown;
    required property string colorText;
    
    property int maxWidth: 70
    leftPadding: 8
    rightPadding: 8
    font.pixelSize: 13

    background: Rectangle {
        implicitWidth: 70
        implicitHeight: 24
        color: button.down ? colorButtonDown : colorButtonUp
        border.color: colorBorder
        border.width: 1
        radius: 8
    }

    contentItem: Item {
        clip: true
        Text {
            id: textItem
            text: button.text
            font: button.font
            anchors.verticalCenter: parent.verticalCenter
            
            SequentialAnimation on x {
                id: marqueeAnimation
                running: textItem.width > parent.width
                loops: Animation.Infinite
                
                PauseAnimation { duration: 2000 }
                NumberAnimation {
                    from: 0
                    to: -(textItem.width - parent.width)
                    duration: Math.max(1000, (textItem.width - parent.width) * 40)
                    easing.type: Easing.Linear
                }
                PauseAnimation { duration: 2000 }
                PropertyAction { target: textItem; property: "x"; value: 0 }
            }
        }
    }
}
