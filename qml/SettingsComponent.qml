import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    property alias text: activeBox.text
    property alias realValue: spinBox.realValue
    property alias checked: activeBox.checked
    property alias value: spinBox.value
    property alias valueFrom: spinBox.from
    property alias valueTo: spinBox.to
    property alias stepSize: spinBox.stepSize
    property alias checkBoxEnabled: activeBox.enabled

    width: column.width
    height: column.height

    ColumnLayout {
        id: column
        spacing: 5
        anchors.left: parent.left
        anchors.right: parent.right

        StyledCheckBox {
            id: activeBox
            Layout.alignment: Qt.AlignCenter
            size: 21
            toolTip: "Active"
            checked: true
        }

        StyledDoubleSpinBox {
            id: spinBox
            Layout.alignment: Qt.AlignCenter
            from: 0
            value: 5000
            to: 20000
            stepSize: 100
            valueDivider: 100
        }
    }
}
