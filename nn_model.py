import tensorflow as tf
import numpy as np
from tensorflow import keras
import keras_cv
from tensorflow.python.keras import layers
from PySide2 import QtCore
from PySide2.QtCore import Slot, QObject, Signal, QTimer
from properties import PropertyMeta, Property
import random


class ModelDefinition(QObject, metaclass=PropertyMeta):
    epochs_count = Property(int)
    batch_size = Property(int)
    validation_split = Property(float)

    conv_layer_0_checked = Property(bool)
    conv_layer_1_checked = Property(bool)
    conv_layer_2_checked = Property(bool)
    pooling_0_checked = Property(bool)
    pooling_1_checked = Property(bool)
    pooling_2_checked = Property(bool)

    conv_layer_0_filters = Property(int)
    conv_layer_1_filters = Property(int)
    conv_layer_2_filters = Property(int)
    conv_layer_0_side = Property(int)
    conv_layer_1_side = Property(int)
    conv_layer_2_side = Property(int)
    conv_layer_0_activation = Property(str)
    conv_layer_1_activation = Property(str)
    conv_layer_2_activation = Property(str)

    conv_layer_0_pool_size = Property(int)
    conv_layer_1_pool_size = Property(int)
    conv_layer_2_pool_size = Property(int)

    dropout_0_chance = Property(float)
    dropout_1_chance = Property(float)
    dropout_2_chance = Property(float)

    dense_layer_0_n_count = Property(int)
    dense_layer_1_n_count = Property(int)

    dense_layer_0_checked = Property(str)
    dense_layer_1_checked = Property(str)

    dense_layer_0_act_function = Property(str)
    dense_layer_1_act_function = Property(str)

    optimizer_str = Property(str)
    loss_function = Property(str)

    doodle_prediction_text = Property(str)
    game_end_screen_text = Property(str)
    game_start_screen_text = Property(str)
    game_start_button_visible = Property(bool)

    game_end_screen = Property(bool)
    game_start_screen = Property(bool)

    def __init__(self, data_handler, parent=None):
        super().__init__(parent)

        self.epochs_count = 10
        self.batch_size = 32
        self.validation_split = 0.1
        self.conv_layer_0_checked = True
        self.conv_layer_1_checked = True
        self.conv_layer_2_checked = True
        self.pooling_0_checked = False
        self.pooling_1_checked = False
        self.pooling_2_checked = False
        self.conv_layer_0_pool_size = 2
        self.conv_layer_1_pool_size = 2
        self.conv_layer_2_pool_size = 2
        self.conv_layer_0_filters = 4
        self.conv_layer_1_filters = 4
        self.conv_layer_2_filters = 4
        self.conv_layer_0_side = 2
        self.conv_layer_1_side = 2
        self.conv_layer_2_side = 2
        self.conv_layer_0_activation = "relu"
        self.conv_layer_1_activation = "relu"
        self.conv_layer_2_activation = "relu"
        self.dropout_0_chance = 0
        self.dropout_1_chance = 0
        self.dropout_2_chance = 0
        self.dense_layer_0_n_count = 1
        self.dense_layer_1_n_count = 1
        self.dense_layer_0_checked = False
        self.dense_layer_1_checked = False
        self.dense_layer_0_act_function = "relu"
        self.dense_layer_1_act_function = "relu"

        self.optimizer_str = "adam"
        self.loss_function = "categorical_crossentropy"

        self.doodle_prediction_text = ""
        self.game_end_screen_text = ""
        self.game_start_screen_text = "Create NN model first"
        self.game_start_button_visible = False

        self.game_start_screen = True
        self.game_end_screen = False

        self.data_handler = data_handler

        self.guess_timers_list = [QTimer(), QTimer(), QTimer(), QTimer(), QTimer()]
        self.t_delay = 4000  # miliseconds

        self.top_prediction_name = ""

    @Slot()
    def guessing_start(self):
        self.game_end_screen = False
        self.game_start_screen = False
        self.doodle_prediction_text = ""

        for i in range(len(self.guess_timers_list) - 1):
            timer = self.guess_timers_list[i]
            timer.timeout.connect(self.predict_user_drawing)
            timer.setSingleShot(True)
            timer.start(self.t_delay + i * self.t_delay)

        timer = self.guess_timers_list[-1]
        timer.timeout.connect(self.popup_endscreen)
        timer.setSingleShot(True)
        timer.start(len(self.guess_timers_list) * self.t_delay)

    @Slot()
    def predict_user_drawing(self):
        if self.game_end_screen:
            return

        self.data_handler.load_image()

        if np.any(self.data_handler.user_image):
            prediction = self.model.predict(self.data_handler.user_image[0:3])

            top_prediction_chance = 0
            self.top_prediction_name = ""

            for i in range(len(prediction[0])):
                print(self.data_handler.class_names[i] + ": ", prediction[0][i])
                if prediction[0][i] > top_prediction_chance:
                    top_prediction_chance = prediction[0][i]
                    self.top_prediction_name = self.data_handler.class_names[i]

            if top_prediction_chance >= 0.75:
                new_text = "Oh, I know - it's " + self.top_prediction_name + "!"
                self.doodle_prediction_text = new_text
                self.popup_endscreen(sure_guess=True)
            elif top_prediction_chance >= 0.35:
                new_text = "I think it's " + self.top_prediction_name
                self.doodle_prediction_text = new_text
            elif top_prediction_chance >= 0.2:
                new_text = "Is that " + self.top_prediction_name + "?"
                self.doodle_prediction_text = new_text
            else:
                new_text = "I don't know what that is"
                self.doodle_prediction_text = new_text

            # print("baseline model prediction:")
            # prediction = self.model_baseline.predict(self.data_handler.user_image_rgb[0:3])
            # for i in range(len(prediction[0])):
            #    print(self.data_handler.class_names[i] + ": " , prediction[0][i])
        else:
            print("User image not available")

    def popup_endscreen(self, sure_guess=False):
        if self.game_end_screen:
            return

        self.game_end_screen = True
        self.game_start_screen = False

        for i in range(len(self.guess_timers_list)):
            self.guess_timers_list[i].stop()

        if sure_guess:
            if self.top_prediction_name == self.current_random_label:
                self.game_end_screen_text = "I guessed your sketch correctly"
            else:
                self.game_end_screen_text = "I got it wrong, sorry"
        else:
            if self.top_prediction_name == self.current_random_label:
                self.game_end_screen_text = (
                    "Timeout\nI wasn't sure, but guessed your sketch correctly"
                )
            else:
                self.game_end_screen_text = "Timeout\nI wasn't able to guess correctly"

        available_labels = [
            x for x in self.data_handler.class_names if x
        ]  # eliminate empty strings
        self.current_random_label = random.choice(available_labels)
        self.game_start_screen_text = (
            "Sketch the suggested object:\n" + self.current_random_label
        )

    def initial_random_label(self):
        available_labels = [
            x for x in self.data_handler.class_names if x
        ]  # eliminate empty strings
        self.current_random_label = random.choice(available_labels)
        self.game_start_screen_text = (
            "Sketch the suggested object:\n" + self.current_random_label
        )
        self.game_start_button_visible = True

    @Slot()
    def fit_model(self):
        print("x_train shape = ", self.data_handler.x_train.shape)
        print("y_train shape = ", self.data_handler.y_train.shape)

        print(self.dropout_0_chance, self.dropout_1_chance, self.dropout_2_chance)
        self.model.fit(
            x=self.data_handler.x_train,
            y=self.data_handler.y_train,
            validation_split=self.validation_split,
            batch_size=self.batch_size,
            verbose=2,
            epochs=self.epochs_count,
        )

        # x_train_shape_rgb =  self.data_handler.x_train.shape
        # x_train_shape_rgb_temp = list(x_train_shape_rgb)
        # x_train_shape_rgb_temp[-1] = 3
        # x_train_shape_rgb = tuple(x_train_shape_rgb_temp)
        # x_rgb = np.resize(self.data_handler.x_train, x_train_shape_rgb)

        # y_train_shape_rgb =  self.data_handler.y_train.shape
        # y_train_shape_rgb_temp = list(y_train_shape_rgb)
        # y_train_shape_rgb_temp[-1] = 3
        # y_train_shape_rgb = tuple(y_train_shape_rgb)
        # y_rgb = np.resize(self.data_handler.y_train, y_train_shape_rgb)

        # self.model_baseline.fit(x = x_rgb, y = y_rgb, validation_split=self.validation_split, batch_size = self.batch_size, verbose=2, epochs=self.epochs_count)

        print("finished training")
        # score = self.model.evaluate(self.data_handler.x_test, self.data_handler.y_test, verbose=2)
        score = self.model.evaluate(
            self.data_handler.x_train, self.data_handler.y_train, verbose=2
        )

        self.initial_random_label()
        # print('Test loss:', score[0])
        # print('Test accuracy:', score[1])
        # self.model.fit(x = self.data_handler.x_train, y = self.data_handler.y_train, validation_split=0.1, batch_size = 256, verbose=2, epochs=self.epochs_count)

    @Slot()
    def create_model(self):
        self.model = keras.Sequential()

        layer_input_shape = self.data_handler.x_train.shape[1:]
        print("input shape for layer", layer_input_shape)

        if self.conv_layer_0_checked:
            self.model.add(
                layers.Convolution2D(
                    self.conv_layer_0_filters,
                    (self.conv_layer_0_side, self.conv_layer_0_side),
                    padding="same",
                    input_shape=layer_input_shape,
                    activation=self.conv_layer_0_activation,
                )
            )
        if self.pooling_0_checked:
            self.model.add(
                layers.MaxPooling2D(
                    pool_size=(self.conv_layer_0_pool_size, self.conv_layer_0_pool_size)
                )
            )
        self.model.add(layers.Dropout(self.dropout_0_chance))

        if self.conv_layer_1_checked:
            self.model.add(
                layers.Convolution2D(
                    self.conv_layer_1_filters,
                    (self.conv_layer_1_side, self.conv_layer_1_side),
                    padding="same",
                    input_shape=layer_input_shape,
                    activation=self.conv_layer_1_activation,
                )
            )
        if self.pooling_1_checked:
            self.model.add(
                layers.MaxPooling2D(
                    pool_size=(self.conv_layer_1_pool_size, self.conv_layer_1_pool_size)
                )
            )

        self.model.add(layers.Dropout(self.dropout_1_chance))

        if self.conv_layer_2_checked:
            self.model.add(
                layers.Convolution2D(
                    self.conv_layer_2_filters,
                    (self.conv_layer_2_side, self.conv_layer_2_side),
                    padding="same",
                    input_shape=layer_input_shape,
                    activation=self.conv_layer_2_activation,
                )
            )
        if self.pooling_2_checked:
            self.model.add(
                layers.MaxPooling2D(
                    pool_size=(self.conv_layer_2_pool_size, self.conv_layer_2_pool_size)
                )
            )

        self.model.add(layers.Dropout(self.dropout_2_chance))

        self.model.add(layers.Flatten())

        if self.dense_layer_0_checked:
            self.model.add(
                layers.Dense(
                    self.dense_layer_0_n_count,
                    activation=self.dense_layer_0_act_function,
                )
            )
        if self.dense_layer_1_checked:
            self.model.add(
                layers.Dense(
                    self.dense_layer_1_n_count,
                    activation=self.dense_layer_1_act_function,
                )
            )

        self.model.add(
            layers.Dense(self.data_handler.y_train.shape[1], activation="softmax")
        )

        self.model.compile(
            loss=self.loss_function,
            optimizer=self.optimizer_str,
            metrics=["top_k_categorical_accuracy"],
        )
        #self.model_baseline.compile(
        #    loss="categorical_crossentropy",
        #    optimizer=optimizer,
        #    metrics=["top_k_categorical_accuracy"],
        #)
        print("NN model compiled")
