import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    width: 1600
    height: 950
    visible: true
    title: qsTr("Metody uczenia maszynowego w rozpoznawaniu obrazów")
    color: "#323435"
    onClosing: Qt.quit()

    property var statuses: [drawingItem, settingsItem, dataItem]

    ListModel{
        id: myListModel
        ListElement { name: "Drawing" }
        ListElement { name: "Neural network" }
        ListElement { name: "Data" }
    }


    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    Rectangle {
        id: titleBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        color: "#121212"
        height: 60

        StyledText {
            anchors {
                fill: parent
                margins: 20
            }
            text: "Doodle recognition"
            font {
                pixelSize: 18
                weight: Font.DemiBold
            }
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: menuRect
        anchors{
            top: titleBar.bottom
            bottom: parent.bottom
            left: parent.left
        }
        width: 200
        color: "#242628"

        TabBar {
            id: menu
            anchors {
                fill: parent
                margins: 15
            }
            currentIndex: 0

            background: Item {}
            contentItem: ListView {
                id:list
                model: myListModel
                spacing: 10
                delegate: Item {
                    width: menu.width
                    height: 45

                    Rectangle {
                        antialiasing: true
                        anchors {
                            left: parent.left
                            leftMargin: 10
                            verticalCenter: nameText.verticalCenter
                        }

                        width: 12
                        height: 12
                        radius: 6
                        color: root.statuses[index].status === 1 ? "#00AA14" : "transparent"
                    }

                    StyledText {
                        id: nameText
                        anchors.centerIn: parent
                        text: name
                        font {
                            pixelSize: 14
                        }
                    }

                    Rectangle {
                        color: "#e2e2e2"
                        height: 1
                        width: parent.width * 0.7
                        anchors {
                            top: parent.bottom
                            topMargin: 5
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: list.currentIndex = index
                    }
                }
                currentIndex: menu.currentIndex
                orientation: ListView.Vertical
                boundsBehavior: Flickable.StopAtBounds
                flickableDirection: Flickable.AutoFlickIfNeeded
                snapMode: ListView.SnapToItem

                highlight: Rectangle {
                    color: "#016764"
                    radius: 5
                }
            }
        }
    }

    StackLayout {
        anchors {
            left: menuRect.right
            right: parent.right
            top: titleBar.bottom
            bottom: parent.bottom
        }
        currentIndex: menu.currentIndex

        Drawing {
            id: drawingItem
        }

        Settings {
            id: settingsItem
        }

        Data {
            id: dataItem
        }
    }
}
