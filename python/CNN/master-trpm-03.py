#!/usr/bin/env python
import multiprocessing
import os
import pickle

import h5py
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf

from keras.layers import (Conv2D, Dense, Flatten, GlobalAveragePooling2D,
                          MaxPooling2D, RandomFlip, RandomRotation)
from keras.models import Sequential, load_model
from matplotlib import pyplot as plt
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import KFold, train_test_split
from tensorflow import keras
from tensorflow.keras import datasets, layers, models

# FOLD


def save_history(history, filename):
    with open(filename, "wb") as f:
        pickle.dump(history.history, f)


def load_history(filename):
    with open(filename, "rb") as f:
        history = tf.keras.callbacks.History()
        history.history = pickle.load(f)
    return history


def plot_history(hist):
    plt.plot([acc * 100 for acc in hist["accuracy"]])
    plt.plot([acc * 100 for acc in hist["val_accuracy"]])

    plt.ylabel("Accuracy (%)")

    plt.title("Résultat d'entraînement et de validation")
    plt.ylabel("accuracy")
    plt.xlabel("epoch")
    plt.legend(["train", "val"], loc="upper left")

    # hide bordure
    plt.gca().spines["top"].set_visible(False)
    plt.gca().spines["right"].set_visible(False)
    plt.gca().spines["bottom"].set_visible(False)
    plt.gca().spines["left"].set_visible(False)

    plt.grid(axis="y")

    # plt.savefig("/kaggle/working/class2.svg")

    print("Done")
    plt.show()


def concatenate_histories(*histories):
    hist = {}
    hist["loss"] = []
    hist["val_loss"] = []
    hist["accuracy"] = []
    hist["val_accuracy"] = []

    for history in histories:
        hist["loss"] += history.history["loss"]
        hist["val_loss"] += history.history["val_loss"]
        if "accuracy" in history.history:
            hist["accuracy"] += history.history["accuracy"]
            hist["val_accuracy"] += history.history["val_accuracy"]

    return hist


f = h5py.File("/app/lungnodemalignancy/all_patches.hdf5", "r")

ct_slices = f["ct_slices"]
slice_class = f["slice_class"]

ct_slices = np.array(ct_slices)
slice_class = np.array(slice_class)

print(ct_slices.shape)
print(slice_class.shape)
print(ct_slices[1].min())

exit(0)
ct_slices = ct_slices.reshape(6691, 64, 64, 1)

X_train, X_test, y_train, y_test = train_test_split(
    ct_slices, slice_class, test_size=0.20, random_state=42
)

y_train = keras.utils.to_categorical(y_train, num_classes=2)
y_test = keras.utils.to_categorical(y_test, num_classes=2)


print(X_train.shape)
print(y_train.shape)


def create_model():
    print("Num GPUs Available: ", len(tf.config.list_physical_devices("GPU")))

    # Create a MirroredStrategy for two T4 GPUs
    strategy = tf.distribute.MirroredStrategy(["GPU:0", "GPU:1"])
    print("Number of devices: {}".format(strategy.num_replicas_in_sync))

    # Open a strategy scope and create the model
    with strategy.scope():
        model = Sequential()
        model.add(RandomFlip("horizontal_and_vertical"))
        model.add(RandomRotation(1.0))

        model.add(
            Conv2D(
                64,
                kernel_size=(8, 8),
                activation="relu",
                padding="same",
                input_shape=(64, 64, 1),
            )
        )
        model.add(Conv2D(64, kernel_size=(2, 2), activation="relu", padding="same"))

        model.add(MaxPooling2D(pool_size=(8, 8), name="max_pooling2d_1"))

        model.add(Conv2D(64, kernel_size=(2, 2), activation="softmax", padding="same"))
        model.add(Conv2D(64, kernel_size=(2, 2), activation="relu", padding="same"))

        model.add(MaxPooling2D(pool_size=(2, 2), name="max_pooling2d_2"))

        model.add(Conv2D(64, kernel_size=(2, 2), activation="relu", padding="same"))
        model.add(Conv2D(64, kernel_size=(2, 2), activation="relu", padding="same"))
        model.add(
            Conv2D(64, kernel_size=(8, 8), activation="relu", padding="same")
        )  # add this
        model.add(MaxPooling2D(pool_size=(2, 2), name="max_pooling2d_3"))

        model.add(GlobalAveragePooling2D())
        model.add(Flatten())

        model.add(Dense(2, activation="softmax"))

        model.compile(
            loss=keras.losses.categorical_crossentropy,
            # optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
            optimizer=tf.keras.optimizers.Adam(),
            metrics=["accuracy"],
        )

    return model


model_3 = create_model()


# model_2.compile(loss=keras.losses.categorical_crossentropy, optimizer=tf.keras.optimizers.Adam(learning_rate=0.001), metrics=['accuracy'])


get_ipython().run_cell_magic(
    "time",
    "",
    "#history_1 = model_3.fit( X_train,y_train, batch_size=640, epochs=6, validation_data=(X_test, y_test))\n#model_3.save('/kaggle/working/save3/model3_4.h5')\n#save_history(history_1, '/kaggle/working/save3/history_4.h5')\n",
)


# model_4   = load_model('/kaggle/working/save3/model3_4.h5')
# history_2 = load_history('/kaggle/working/save3/history_2.h5')


# In[ ]:


get_ipython().run_cell_magic(
    "time",
    "",
    "## shange modeil hyperParam\n#model_3.compile(loss=keras.losses.categorical_crossentropy,optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),metrics=['accuracy'])\n#history_2 = model_3.fit( X_train,y_train, batch_size=32, epochs=10, validation_data=(X_test, y_test))\n",
)


get_ipython().run_cell_magic(
    "time",
    "",
    "tensorboard_callback = tf.keras.callbacks.TensorBoard(\"logs\")\n\n#history_5 = model_5.fit( X_train,y_train, batch_size=640, epochs=1000, validation_data=(X_test, y_test),callbacks=[tensorboard_callback],)\nmodel_5.save('/kaggle/working/save3/model3_5.h5')\nsave_history(history_5, '/kaggle/working/save3/history_5.h5')\n",
)


model_4.summary()


get_ipython().system("mkdir -p /kaggle/working/save5/")
model_5.save_weights("/kaggle/working/save5/model5_weights.h5")
model_6 = create_model()
history_6 = model_6.fit(
    X_train, y_train, batch_size=640, epochs=1, validation_data=(X_test, y_test)
)
model_6.load_weights("/kaggle/working/save5/model5_weights.h5", by_name=True)
model_6.summary()


combined_history = concatenate_histories(
    history_1,
    history_2,
    history_3,
    history_4,
    #      history_5,
    #      history_6,
    #      history_7,
    #      history_8,
    #      history_9,
)


plot_history(combined_history)
plot_history(history_11.history)
