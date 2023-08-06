#!/usr/bin/env python3
import matplotlib.pyplot as plt

# Create lists of epoch numbers
epochs_train = [1, 2, 3, 4, 5]
epochs_val = [1, 2, 3, 4, 5]

# Create lists of loss values
loss_train = [1.177, 0.000, 0.000, 0.000, 0.000]
loss_val = [407.578, 658.517, 773.610, 820.082, 836.596]

# Create lists of accuracy values
acc_train = [95.92, 100.00, 100.00, 100.00, 100.00]
acc_val = [94.12, 94.12, 94.12, 94.12, 94.12]

# Plot the training and validation loss as line graphs
plt.plot(epochs_train, loss_train, label="Training loss")
plt.plot(epochs_val, loss_val, label="Validation loss")

# Add labels and title
plt.xlabel("Epoch")
plt.ylabel("Loss")
plt.title("Training and Validation Loss")


plt.gca().spines["top"].set_visible(False)
plt.gca().spines["right"].set_visible(False)
plt.gca().spines["bottom"].set_visible(False)
plt.gca().spines["left"].set_visible(False)

# Add legend
plt.legend()

# Show the graph
plt.show()
