import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    ColumnLayout {
        spacing: 30
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            margins: 40
        }

        RowLayout {
            spacing: 30
            Layout.alignment: Qt.AlignHCenter

            Item {
                implicitWidth: 180
                implicitHeight: 35

                StyledSpinBox {
                    id: classItemsLimitSpinBox
                    from: 1
                    value: 2000
                    to: 100000
                    stepSize: 500
                    anchors.centerIn: parent
                    onValueChanged: {
                        data_handler.class_items_limit = classItemsLimitSpinBox.value
                    }
                    Component.onCompleted: {
                        data_handler.class_items_limit = classItemsLimitSpinBox.value
                    }
                }

                StyledText {
                    anchors {
                        centerIn: parent
                        verticalCenterOffset: -28
                    }
                    text: "Class items"
                }
            }
            Item {
                implicitWidth: 180
                implicitHeight: 35

                StyledDoubleSpinBox {
                    id: testPartSplitSpinBox
                    from: 1
                    value: 25
                    to: 99
                    stepSize: 10
                    decimals: 2
                    anchors.centerIn: parent
                    
                    onValueChanged: {
                        data_handler.test_part = testPartSplitSpinBox.realValue
                    }
                    Component.onCompleted: {
                        data_handler.test_part = testPartSplitSpinBox.realValue
                    }
                }

                StyledText {
                    anchors {
                        centerIn: parent
                        verticalCenterOffset: -28
                    }
                    text: "Test part"
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 2
            color: "#88e2e2e2"
        }

        GridLayout {
            Layout.leftMargin: 20
            columns: 4
            Layout.alignment: Qt.AlignLeft

            Item {
                id: file0Item
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file0CheckBox
                    objectName: "file0Obj"
                    text: ""
                    checked: true
                    visible: false
                    
                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_1_status = checked
                    }
                }
            }
            Item {
                id: file1Item
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file1CheckBox
                    objectName: "file1Obj"
                    text: ""
                    checked: true
                    visible: false
                    
                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_2_status = checked
                    }
                }
            }
            Item {
                id: file2Item
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file2CheckBox
                    objectName: "file2Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_3_status = checked
                    }
                }
            }
            Item {
                id: file3Item
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file3CheckBox
                    objectName: "file3Obj"
                    text: ""
                    checked: true
                    visible: false
                    
                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_4_status = checked
                    }
                }
            }
        
            Item {
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file4CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file4Obj"
                    text: ""
                    checked: true
                    visible: false
                    
                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_4_status = checked
                    }
                }
            }

            Item {
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file5CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file5Obj"
                    text: ""
                    checked: true
                    visible: false
                    
                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_5_status = checked
                    }
                }
            }

            Item {
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file6CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file6Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_6_status = checked
                    }
                }
            }

            Item {
                id: item7
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file7CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file7Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_7_status = checked
                    }
                }
            }

            Item {
                id: item8
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file8CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file8Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_8_status = checked
                    }
                }
            }

            Item {
                id: item9
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file9CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file9Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_9_status = checked
                    }
                }
            }

            Item {
                id: item10
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file10CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file10Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_10_status = checked
                    }
                }
            }

            Item {
                id: item11
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file11CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file11Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_11_status = checked
                    }
                }
            }

            Item {
                id: item12
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file12CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file12Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_12_status = checked
                    }
                }
            }

            Item {
                id: item13
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file13CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file13Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_13_status = checked
                    }
                }
            }

            Item {
                id: item14
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file14CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file14Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_14_status = checked
                    }
                }
            }

            Item {
                id: item15
                implicitWidth: 180
                implicitHeight: 35
                Layout.alignment: Qt.AlignLeft

                StyledCheckBox {
                    id: file15CheckBox
                    implicitWidth: 180
                    implicitHeight: 35
                    objectName: "file15Obj"
                    text: ""
                    checked: true
                    visible: false

                    onTextChanged: {
                        visible = (text === "") ? false : true
                    }
                    onCheckedChanged: {
                        data_handler.file_15_status = checked
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 2
            color: "#88e2e2e2"
        }

        RowLayout {
            spacing: 15
            Layout.alignment: Qt.AlignHCenter

            StyledButton {
                text: "Load data"

                function updateValues(){
                    data_handler.files_statuses_list = [
                        file0CheckBox.checked,
                        file1CheckBox.checked,
                        file2CheckBox.checked,
                        file3CheckBox.checked,
                        file4CheckBox.checked,
                        file5CheckBox.checked,
                        file6CheckBox.checked,
                        file7CheckBox.checked,
                        file8CheckBox.checked,
                        file9CheckBox.checked,
                        file10CheckBox.checked,
                        file11CheckBox.checked,
                        file12CheckBox.checked,
                        file13CheckBox.checked,
                        file14CheckBox.checked,
                        file15CheckBox.checked
                    ]
                }

                onClicked: {
                    updateValues()
                    data_handler.load_data()
                }
            }
        }
    }
}