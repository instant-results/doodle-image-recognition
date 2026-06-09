import numpy as np
from PIL import Image
from tensorflow import keras
import glob
import os
from PySide2 import QtCore
from PySide2.QtCore import Slot, QObject, Signal
from properties import PropertyMeta, Property


class DataHandler(QObject, metaclass=PropertyMeta):
    class_items_limit = Property(int)
    files_statuses_list = Property(list)
    test_part = Property(float)

    files_limit = 16

    def __init__(self, root_dir, engine, parent=None):
        super().__init__()
        print("initiating data read")
        self.root_dir = root_dir
        self.engine = engine
        self.class_items_limit = 6000
        self.class_names = self.files_limit * [""]
        self.user_image = None
        self.files_statuses_list = []
        self.test_part = 0.25

    def check_available_files(self):
        all_files = glob.glob(os.path.join(self.root_dir, "*.npy"))
        print("all data files at: ", all_files)

        for i, file in enumerate(all_files[: self.files_limit]):
            print(file)
            class_name, ext = os.path.splitext(os.path.basename(file))
            class_name = class_name.rsplit("full_numpy_bitmap_", 1)
            self.class_names[i] = class_name[-1]

        print(self.class_names)

    def set_qml_strings(self):
        for i in range(16):
            object_name = "file" + str(i) + "Obj"

            r = self.engine.rootObjects()[0].findChild(QtCore.QObject, object_name)
            r.setProperty("text", self.class_names[i])

    def transform_data(self):
        image_size = 28
        num_classes = self.files_statuses_list.count(True)
        print("num_classes = ", num_classes)

        self.x_train = self.x_train.reshape(
            self.x_train.shape[0], image_size, image_size, 1
        ).astype("float32")
        self.x_test = self.x_test.reshape(
            self.x_test.shape[0], image_size, image_size, 1
        ).astype("float32")

        self.x_train /= 255.0
        self.x_test /= 255.0

        # Convert class vectors to class matrices
        self.y_train = keras.utils.to_categorical(self.y_train, num_classes)
        self.y_test = keras.utils.to_categorical(self.y_test, num_classes)

        print("x_train.shape = ", self.x_train.shape)
        print("y_train.shape = ", self.y_train.shape)

    @Slot()
    def load_data(self):
        all_files = glob.glob(os.path.join(self.root_dir, "*.npy"))
        print("all data files at: ", all_files)
        class_names = []
        x = np.empty([0, 784])  # 28 x 28
        y = np.empty([0])
        class_labels = 0
        print("class items limit = ", self.class_items_limit)

        index_offset = 0

        for i, file in enumerate(all_files[: self.files_limit]):
            print("status pliku: ", self.files_statuses_list[i])
            if False == self.files_statuses_list[i]:
                index_offset += 1
                continue

            class_data = np.load(file)
            print("loaded file")
            class_data = class_data[0 : self.class_items_limit, :]
            class_labels = np.full(class_data.shape[0], i - index_offset)
            print("class labels = ", class_labels)
            print("class labels size = ", len(class_labels))

            x = np.concatenate((x, class_data), axis=0)
            y = np.append(y, class_labels)

            class_name, ext = os.path.splitext(os.path.basename(file))
            class_name = class_name.rsplit("full_numpy_bitmap_", 1)
            class_names.append(class_name[-1])

        # comment out to stop randomizing the dataset
        # permutation = np.random.permutation(y.shape[0])
        # x = x[permutation, :]
        # y = y[permutation]
        print("x.shape = ", x.shape)
        print("y.shape = ", y.shape)
        test_data_size = int(x.shape[0] / 100 * (self.test_part * 100))

        x_train = x[test_data_size : x.shape[0], :]
        y_train = y[test_data_size : y.shape[0]]
        x_test = x[0:test_data_size, :]
        y_test = y[0:test_data_size]

        print("x_train.shape = ", x_train.shape)
        print("x_test.shape = ", x_test.shape)

        print(class_labels)
        print(class_names)
        class_data = None
        class_labels = None

        self.x_train = x_train
        self.y_train = y_train
        self.x_test = x_test
        self.y_test = y_test
        self.class_names = class_names

        self.transform_data()

    @Slot()
    def load_image(self):
        with Image.open(r"userDrawing.png") as image:
            new_dim = (28, 28)
            image = image.resize(new_dim)
            np_frame = np.array(image.getdata())
            np_frame = np.delete(np_frame, [0, 1, 2], 1)
            image_size = 28
            np_frame = np_frame.reshape(1, image_size, image_size, 1).astype("float32")
            np_frame /= 255.0

            self.user_image = np_frame
