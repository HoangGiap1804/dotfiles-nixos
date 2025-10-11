import QtQuick
import QtQuick.Controls.Basic
Button {
    required property string colorBorder;
    required property string colorButtonUp;
    required property string colorButtonDown;
    required property string colorText;
    id: button
    text: "Button"
    background: Rectangle {
        implicitWidth: 50
        implicitHeight: 30
        color: button.down ? colorButtonDown : colorButtonUp
        border.color: colorBorder
        border.width: 2
        radius: 10
    }
}
