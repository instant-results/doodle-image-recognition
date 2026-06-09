import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    
    ColumnLayout {
        spacing: 0
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            margins: 15
        }

        RowLayout {
            spacing: 30
            Layout.alignment: Qt.AlignHCenter

            StyledText {
                id: classText
                text: nn_model.doodle_prediction_text
                color: "white"
                font {
                    pixelSize: 36
                }
            }
        }    

        Rectangle {
            id: rect
            width: 784
            height: 784
            color: "white"
            border.color: "#016764"
            border.width: 5

            Canvas {
                id: mainCanvas
                visible: true
                width: 784
                height: 784
                property double lastX: 0
                property double lastY: 0

                function clear() {
                    var ctx = getContext('2d');
                    ctx.reset();
                    mainCanvas.requestPaint();
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent

                    onPressed: {
                        mainCanvas.lastX = mouseX;
                        mainCanvas.lastY = mouseY;
                    }

                    onPositionChanged: {
                        mainCanvas.requestPaint();
                    }
                }

                onPaint: {
                    //var ctx = getContext("2d");
                    //ctx.fillStyle = Qt.rgba(99, 140, 129, 1);
                    //ctx.fillRect(0, 0, width, height);
                    var ctx = getContext('2d');
                    ctx.lineWidth = 16;
                    ctx.beginPath();
                    ctx.moveTo(lastX, lastY);
                    lastX = mouseArea.mouseX;
                    lastY = mouseArea.mouseY;
                    ctx.lineTo(lastX, lastY);
                    ctx.stroke();

                    save(`userDrawing.png`)
                }

            Rectangle {
                id: endBox

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    //verticalCenter: parent.verticalCenter
                    bottom: parent.bottom
                    bottomMargin: 55
                }
                radius: 5
                implicitHeight: 190
                implicitWidth: 400
                color: "#014744"
                visible: nn_model.game_end_screen

                ColumnLayout {
                    spacing: 15
                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                        margins: 40
                    }

                    StyledText {
                        id: gameEndText
                        text: "Game end"
                        color: "white"
                        font {
                            pixelSize: 22
                        }
                    }

                    StyledText {
                        id: endText
                        text: nn_model.game_end_screen_text
                        color: "white"
                        font {
                            pixelSize: 18
                        }
                    }

                    StyledButton {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Try again"
                        implicitWidth: 160
                        onClicked: {
                            //mainCanvas.clear()
                            //nn_model.guessing_start()
                            nn_model.game_end_screen = false
                            nn_model.game_start_screen = true
                            //startBox.visible = false
                        }
                    }
                }
            }

            Rectangle {
                id: startBox

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    //verticalCenter: parent.verticalCenter
                    bottom: parent.bottom
                    bottomMargin: 55
                }
                
                radius: 5
                
                implicitHeight: 160
                implicitWidth: 400
                color: "#014744"
                visible: nn_model.game_start_screen

                ColumnLayout {
                    spacing: 15
                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                        margins: 40
                    }

                    StyledText {
                        id: startText
                        Layout.alignment: Qt.AlignHCenter
                        text: nn_model.game_start_screen_text
                        color: "white"
                        font {
                            pixelSize: 18
                        }
                    }
                    StyledButton {
                        Layout.alignment: Qt.AlignHCenter
                        visible: nn_model.game_start_button_visible
                        text: "Start"
                        implicitWidth: 160
                        onClicked: {
                            mainCanvas.clear()
                            nn_model.guessing_start()
                            //startBox.visible = false
                        }
                    }
                }
            }
        }
        //onReleased: {
        //    draw_window.mouseReleaseEvent()
        //}
        RowLayout {
            spacing: 30
            anchors {
                top: rect.bottom
                horizontalCenter: parent.horizontalCenter
                leftMargin: 15
            }
                StyledButton {
                    text: "Clear the canvas"
                    onClicked: {
                        mainCanvas.clear()
                    }
                }
                StyledButton {
                    text: "Interpret the drawing"
                    onClicked: {
                        nn_model.predict_user_drawing()
                    }
                }
            }
        }
    }
}
