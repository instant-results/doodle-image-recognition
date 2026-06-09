import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    ColumnLayout {
        spacing: 30
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            margins: 40
            leftMargin: 0
        }
        RowLayout {
            spacing: 30
            Layout.alignment: Qt.AlignHCenter

            Item {
                implicitWidth: 180
                implicitHeight: 35

                StyledSpinBox {
                    id: epochsSpinBox
                    from: 1
                    value: 5
                    to: 10000
                    stepSize: 1
                    anchors.centerIn: parent
                    onValueChanged: {
                        nn_model.epochs_count = epochsSpinBox.value
                    }
                    Component.onCompleted: {
                        nn_model.epochs_count = epochsSpinBox.value
                    }
                }

                StyledText {
                    anchors {
                        centerIn: parent
                        verticalCenterOffset: -28
                    }
                    text: "Epochs"
                }
            }

            Item {
                implicitWidth: 180
                implicitHeight: 35

                StyledSpinBox {
                    id: batchSizeSpinBox
                    from: 1
                    value: 32
                    to: 10000
                    stepSize: 4
                    anchors.centerIn: parent
                    onValueChanged: {
                        nn_model.batch_size = batchSizeSpinBox.value
                    }
                    Component.onCompleted: {
                        nn_model.batch_size = batchSizeSpinBox.value
                    }
                }

                StyledText {
                    anchors {
                        centerIn: parent
                        verticalCenterOffset: -28
                    }
                    text: "Batch size"
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 2
            color: "#88e2e2e2"
        }

        RowLayout {
            spacing: 25
            Layout.fillWidth: true

            StyledCheckBox {
                id: convL0CheckBox
                text: "Convoluted\nlayer"
                checked: true
                onCheckedChanged: {
                    nn_model.conv_layer_0_checked = convL0CheckBox.checked
                }
                Component.onCompleted: {
                    nn_model.conv_layer_0_checked = convL0CheckBox.checked
                }
            }
            ColumnLayout {
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Filters\ncount"
                }
                StyledSpinBox {
                    id: convL0Filters
                    value: 16
                    from: 1
                    to: 128
                    stepSize: 1
                    decimals: 4
                    onValueChanged: {
                        nn_model.conv_layer_0_filters = convL0Filters.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_0_filters = convL0Filters.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Kernel side\nlength"
                }
                StyledSpinBox {
                    id: convL0SideLength
                    value: 4
                    from: 2
                    to: 8
                    stepSize: 1
                    onValueChanged: {
                        nn_model.conv_layer_0_side = convL0SideLength.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_0_side = convL0SideLength.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Activation\nfunction"
                }
                StyledDoubleSpinBox {
                    id: activationSpinBox1
                    property var items: ["relu", "sigmoid", "softmax", "softplus", "softsign"]
                    value: 0
                    from: 0
                    to: items.length - 1
                    textFromValue: function(value) {
                        return items[value];
                    }
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                    validator: RegExpValidator {
                        regExp: new RegExp("(relu|sigmoid|softmax|softplus|softsign)", "i")
                    }
                    onValueChanged: {
                        nn_model.conv_layer_0_activation = activationSpinBox1.items[value]
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_0_activation = activationSpinBox1.items[value]
                    }
                }
            }
            StyledCheckBox {
                id: convL0Pooling
                text: "Pooling"
                checked: true
                onCheckedChanged: {
                    nn_model.pooling_0_checked = convL0Pooling.checked
                }
                Component.onCompleted: {
                    nn_model.pooling_0_checked = convL0Pooling.checked
                }
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Pool\nsize"
                }
                StyledSpinBox {
                    id: convL0PoolingSize
                    value: 6
                    from: 1
                    to: 16
                    stepSize: 1
                    onValueChanged: {
                        nn_model.conv_layer_0_pool_size = convL0PoolingSize.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_0_pool_size = convL0PoolingSize.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 30
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Dropout\nchance"
                }
                StyledDoubleSpinBox {
                    id: convL0Dropout
                    value: 0
                    from: 0
                    to: 100
                    stepSize: 5
                    onValueChanged: {
                        nn_model.dropout_0_chance = convL0Dropout.realValue
                    }
                    Component.onCompleted: {
                        nn_model.dropout_0_chance = convL0Dropout.realValue
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
            spacing: 25
            Layout.fillWidth: true

            StyledCheckBox {
                id: convL1CheckBox
                text: "Convoluted\nlayer"
                checked: true
                onCheckedChanged: {
                    nn_model.conv_layer_1_checked = convL1CheckBox.checked
                }
                Component.onCompleted: {
                    nn_model.conv_layer_1_checked = convL1CheckBox.checked
                }
            }
            ColumnLayout {
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Filters\ncount"
                }
                StyledSpinBox {
                    id: convL1Filters
                    value: 16
                    from: 1
                    to: 128
                    stepSize: 1
                    decimals: 4
                    onValueChanged: {
                        nn_model.conv_layer_1_filters = convL1Filters.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_1_filters = convL1Filters.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Kernel side\nlength"
                }
                StyledSpinBox {
                    id: convL1SideLength
                    value: 4
                    from: 2
                    to: 8
                    stepSize: 1
                    onValueChanged: {
                        nn_model.conv_layer_1_side = convL1SideLength.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_1_side = convL1SideLength.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Activation\nfunction"
                }
                StyledDoubleSpinBox {
                    id: activationSpinBox2
                    property var items: ["relu", "sigmoid", "softmax", "softplus", "softsign"]
                    value: 0
                    from: 0
                    to: items.length - 1
                    textFromValue: function(value) {
                        return items[value];
                    }
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                    validator: RegExpValidator {
                        regExp: new RegExp("(relu|sigmoid|softmax|softplus|softsign)", "i")
                    }
                    onValueChanged: {
                        nn_model.conv_layer_1_activation = activationSpinBox2.items[value]
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_1_activation = activationSpinBox2.items[value]
                    }
                }
            }
            StyledCheckBox {
                id: convL1Pooling
                text: "Pooling"
                onCheckedChanged: {
                    nn_model.pooling_1_checked = convL1Pooling.checked
                }
                Component.onCompleted: {
                    nn_model.pooling_1_checked = convL1Pooling.checked
                }
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Pool\nsize"
                }
                StyledSpinBox {
                    id: convL1PoolingSize
                    value: 4
                    from: 1
                    to: 16
                    stepSize: 1
                    onValueChanged: {
                        nn_model.conv_layer_1_pool_size = convL1PoolingSize.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_1_pool_size = convL1PoolingSize.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 30
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Dropout\nchance"
                }
                StyledDoubleSpinBox {
                    id: convL1Dropout
                    value: 0
                    from: 0
                    to: 100
                    stepSize: 5
                    onValueChanged: {
                        nn_model.dropout_1_chance = convL1Dropout.realValue
                    }
                    Component.onCompleted: {
                        nn_model.dropout_1_chance = convL1Dropout.realValue
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
            spacing: 25
            Layout.fillWidth: true

            StyledCheckBox {
                id: convL2CheckBox
                text: "Convoluted\nlayer"
                onCheckedChanged: {
                    nn_model.conv_layer_2_checked = convL2CheckBox.checked
                }
                Component.onCompleted: {
                    nn_model.conv_layer_2_checked = convL2CheckBox.checked
                }
            }
            ColumnLayout {
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Filters\ncount"
                }
                StyledSpinBox {
                    id: convL2Filters
                    value: 4
                    from: 1
                    to: 128
                    stepSize: 1
                    decimals: 4
                    onValueChanged: {
                        nn_model.conv_layer_2_filters = convL2Filters.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_2_filters = convL2Filters.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Kernel side\nlength"
                }
                StyledSpinBox {
                    id: convL2SideLength
                    value: 3
                    from: 2
                    to: 8
                    stepSize: 1
                    onValueChanged: {
                        nn_model.conv_layer_2_side = convL2SideLength.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_2_side = convL2SideLength.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Activation\nfunction"
                }
                StyledDoubleSpinBox {
                    id: activationSpinBox3
                    property var items: ["relu", "sigmoid", "softmax", "softplus", "softsign"]
                    value: 1
                    from: 0
                    to: items.length - 1
                    textFromValue: function(value) {
                        return items[value];
                    }
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                    validator: RegExpValidator {
                        regExp: new RegExp("(relu|sigmoid|softmax|softplus|softsign)", "i")
                    }
                    onValueChanged: {
                        nn_model.conv_layer_2_activation = activationSpinBox3.items[value]
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_2_activation = activationSpinBox3.items[value]
                    }
                }
            }
            StyledCheckBox {
                id: convL2Pooling
                text: "Pooling"
                onCheckedChanged: {
                    nn_model.pooling_2_checked = convL2Pooling.checked
                }
                Component.onCompleted: {
                    nn_model.pooling_2_checked = convL2Pooling.checked
                }
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Pool\nsize"
                }
                StyledSpinBox {
                    id: convL2PoolingSize
                    value: 3
                    from: 1
                    to: 16
                    stepSize: 1
                    onValueChanged: {
                        nn_model.conv_layer_2_pool_size = convL2PoolingSize.value
                    }
                    Component.onCompleted: {
                        nn_model.conv_layer_2_pool_size = convL2PoolingSize.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 30
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Dropout\nchance"
                }
                StyledDoubleSpinBox {
                    id: convL2Dropout
                    value: 0
                    from: 0
                    to: 100
                    stepSize: 5
                    onValueChanged: {
                        nn_model.dropout_2_chance = convL2Dropout.realValue
                    }
                    Component.onCompleted: {
                        nn_model.dropout_2_chance = convL2Dropout.realValue
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
            spacing: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            StyledCheckBox {
                id: denseL0CheckBox
                text: "Dense\nlayer"
                checked: true
                onCheckedChanged: {
                    nn_model.dense_layer_0_activation = denseL0CheckBox.checked
                }
                Component.onCompleted: {
                    nn_model.dense_layer_0_activation = denseL0CheckBox.checked
                }
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Neurons\ncount"
                }
                StyledSpinBox {
                    id: denseL0NCount
                    value: 64
                    from: 1
                    to: 2000
                    stepSize: 10
                    onValueChanged: {
                        nn_model.dense_layer_0_n_count = denseL0NCount.value
                    }
                    Component.onCompleted: {
                        nn_model.dense_layer_0_n_count = denseL0NCount.value
                    }
                } 
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Activation\nfunction"
                }
                StyledDoubleSpinBox {
                    id: denseL0activation
                    property var items: ["linear", "relu", "sigmoid", "softmax", "softplus", "softsign"]
                    value: 0
                    from: 0
                    to: items.length - 1
                    textFromValue: function(value) {
                        return items[value];
                    }
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                    validator: RegExpValidator {
                        regExp: new RegExp("(relu|sigmoid|softmax|softplus|softsign)", "i")
                    }
                    onValueChanged: {
                        nn_model.dense_layer_0_act_function = denseL0activation.items[value]
                    }
                    Component.onCompleted: {
                        nn_model.dense_layer_0_act_function = denseL0activation.items[value]
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
            spacing: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            StyledCheckBox {
                id: denseL1CheckBox
                text: "Dense\nlayer"
                checked: false
                onCheckedChanged: {
                    nn_model.dense_layer_1_activation = denseL1CheckBox.checked
                }
                Component.onCompleted: {
                    nn_model.dense_layer_1_activation = denseL1CheckBox.checked
                }
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Neurons\ncount"
                }
                StyledSpinBox {
                    id: denseL1NCount
                    value: 32
                    from: 1
                    to: 2000
                    stepSize: 10
                    onValueChanged: {
                        nn_model.dense_layer_1_n_count = denseL1NCount.value
                    }
                    Component.onCompleted: {
                        nn_model.dense_layer_1_n_count = denseL1NCount.value
                    }
                }
            }
            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Activation\nfunction"
                }
                StyledDoubleSpinBox {
                    id: denseL1activation
                    property var items: ["linear", "relu", "sigmoid", "softmax", "softplus", "softsign"]
                    value: 0
                    from: 0
                    to: items.length - 1
                    textFromValue: function(value) {
                        return items[value];
                    }
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                    validator: RegExpValidator {
                        regExp: new RegExp("(relu|sigmoid|softmax|softplus|softsign)", "i")
                    }
                    onValueChanged: {
                        nn_model.dense_layer_1_act_function = denseL1activation.items[value]
                    }
                    Component.onCompleted: {
                        nn_model.dense_layer_1_act_function = denseL1activation.items[value]
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
            spacing: 100
            Layout.alignment: Qt.AlignHCenter

            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Optimizer"
                }
                StyledDoubleSpinBox {
                    id: optimizerSpinBox
                    property var items: ["adam", "adadelta", "adagrad", "adamax", "nadam", "ftrl", "SGD", "rmsprop"]
                    value: 0
                    from: 0
                    to: items.length - 1
                    textFromValue: function(value) {
                        return items[value];
                    }
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                    validator: RegExpValidator {
                        regExp: new RegExp("(adam|adadelta|adagrad|adamax|nadam|ftrl|SGD|rmsprop)", "i")
                    }
                    onValueChanged: {
                        nn_model.optimizer_str = optimizerSpinBox.items[value]
                    }
                    Component.onCompleted: {
                        nn_model.optimizer_str = optimizerSpinBox.items[value]
                    }
                }
            }

            ColumnLayout {
                anchors.leftMargin: 10
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Loss function"
                }
                StyledDoubleSpinBox {
                    id: lossFunctionSpinBox
                    property var items: ["categorical_crossentropy", "binary_crossentropy", "sparse_categorical_crossentropy", "poisson", "kl_divergence"]
                    value: 0
                    from: 0
                    to: items.length - 1
                    textFromValue: function(value) {
                        return items[value];
                    }
                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                    validator: RegExpValidator {
                        regExp: new RegExp("(categorical_crossentropy|binary_crossentropy|sparse_categorical_crossentropy|poisson|kl_divergence)", "i")
                    }
                    onValueChanged: {
                        nn_model.optimizer_str = optimizerSpinBox.items[value]
                    }
                    Component.onCompleted: {
                        nn_model.optimizer_str = optimizerSpinBox.items[value]
                    }
                }
            }

            StyledButton {
                
                text: "Train model"
                onClicked: {
                    nn_model.create_model()
                    nn_model.fit_model()
                }
            }
        }
    }
}
