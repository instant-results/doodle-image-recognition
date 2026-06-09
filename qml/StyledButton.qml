import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: control
    text: ""

    contentItem: StyledText {
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: control.text
    }

    background: Rectangle {
        implicitWidth: 180
        implicitHeight: 35
        color: control.pressed ? "#014744" : "#016764"
        radius: 5
        border {
            width: 2
            color: "#323334"
        }
    }
}
