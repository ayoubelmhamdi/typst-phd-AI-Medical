import matplotlib.pyplot as plt
import numpy as np

td = np.array(
    [
        [-40, -40, -40],
        [-20, -4, -20],
        [0, 32, 0],
        [20, 68, 20],
        [40, 104, 40],
        [60, 140, 60],
        [80, 176, 80],
        [100, 212, 100],
        [220, 428, 220],
    ]
)

plt.plot(td[:, 0], td[:, 1], "bo--")
plt.plot(td[:, 0], td[:, 2], "r")

plt.title("Températures prévues et réelles")
plt.xlabel("Celsius")
plt.ylabel("Fahrenheit")
# plt.text(5.5, 6, 'This is the graph of X vs Y')

plt.annotate(
    r"$F=\frac{9}{5}C+32$", xy=(5, 2), xytext=(25, 185), color="blue", fontweight="bold"
)
plt.annotate(
    r"$F=1\cdot C+0$", xy=(5, 2), xytext=(162, 145), color="red", fontweight="bold"
)

plt.gca().set_aspect("equal")
plt.xlim(0, 220)
plt.ylim(0, 220)
# plt.grid()
# plt.xticks(np.arange(0, 221, 40))
# plt.yticks(np.arange(0, 221, 40))

# Add major grid lines every 40
plt.grid(which="major", axis="both")

# Add minor grid lines every 10
plt.grid(which="minor", axis="both", alpha=1)
plt.minorticks_on()

# Set the ticks to be every 40
plt.xticks(np.arange(0, 221, 100))
plt.yticks(np.arange(0, 221, 100))
plt.savefig("temperaturesPrevuesReelles.svg")
plt.show()
