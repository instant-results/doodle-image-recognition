import QtQuick 2.15
import QtQuick.Controls 2.15

SpinBox {
    id: control

    width: 120
    height: 32

    property int decimals: 2
    property int valueDivider: 100
    property real realValue: value / valueDivider

    editable: true
    onValueChanged: {
        textInput.focus = false
        focus = false
    }
    from: -99999
    value: 0
    to: 99999

    validator: DoubleValidator {
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    textFromValue: function(value, locale) {
        return Number(value / valueDivider).toLocaleString(locale, 'f', control.decimals)
    }

    valueFromText: function(text, locale) {
        return Number.fromLocaleString(locale, text) * valueDivider
    }

    contentItem: TextInput {
        id: textInput
        z: 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: control.textFromValue(control.value, control.locale)
        color: "#e2e2e2"
        selectionColor: "#283537"
        font {
            pixelSize: 13
        }
        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly

        onAccepted: focus = false
        onEditingFinished: focus = false
        onFocusChanged: {
            if (focus) {
                selectAll()
            } else {
                deselect()
            }
        }
        onActiveFocusChanged: {
            if(!activeFocus) {
                deselect()
            }
        }
    }

    up.indicator: Rectangle {
        radius: 5
        x: control.mirrored ? 0 : parent.width - width
        height: parent.height
        implicitWidth: control.height
        implicitHeight: control.height
        color: control.value == control.to ? "#283537" : (control.up.pressed ? "#013734" : "#014744")
        border {
            width: 1
            color: "#323334"
        }


        StyledText {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "+"
        }
    }

    down.indicator: Rectangle {
        radius: 5
        x: control.mirrored ? parent.width - width : 0
        height: parent.height
        implicitWidth: control.height
        implicitHeight: control.height
        color: control.value == control.from ? "#283537" : (control.down.pressed ? "#013734" : "#014744")
        border {
            width: 1
            color: "#323334"
        }

        StyledText {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "-"
        }
    }

    background: Rectangle {
        implicitWidth: control.width
        implicitHeight: control.height
        color: "#016764"
        radius: 5
        border {
            width: 1
            color: "#323334"
        }
    }

    WheelHandler {
        onWheel: {
            if (event.angleDelta.y > 0) {
                control.value += control.stepSize
            } else {
                control.value -= control.stepSize
            }
        }
    }
}
