import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import butter, lfilter, freqz
import matplotlib.pyplot as plt

def show_hp(unfiltered, timestamps, cutoff, fs, order=5):
    b, a = butter_highpass(cutoff, fs, order)

    # Frequency response graph
    w, h = freqz(b, a, worN=8000)
    plt.subplot(2, 1, 1)
    plt.plot(0.5 * fs * w / np.pi, np.abs(h), 'b')
    plt.plot(cutoff, 0.5 * np.sqrt(2), 'ko')
    plt.axvline(cutoff, color='k')
    plt.xlim(0, 0.5 * fs)
    plt.title("Highpass Filter Frequency Response")
    plt.xlabel('Frequency [Hz]')
    plt.ylabel('Amplitute')
    plt.grid()

    filtered = butter_highpass_filter(unfiltered, cutoff, fs, order)

    plt.subplot(2, 1, 2)
    plt.plot(timestamps, unfiltered, 'r-', label='Unfiltered')
    plt.plot(timestamps, filtered, 'g-', linewidth=2, label='High Pass filtered')
    plt.xlabel('Time [sec]')
    plt.ylabel('Acc Amplitute (mm\/sec2)')
    plt.grid()
    plt.legend()

    plt.subplots_adjust(hspace=0.35)
    plt.show()


def butter_highpass(cutoff, fs, order=5):
    nyq = 0.5 * fs
    normal_cutoff = cutoff / nyq
    # print "filtering with normal_cutoff = " , normal_cutoff
    b, a = butter(order, normal_cutoff, btype='high', analog=False)
    return b, a

def butter_highpass_filter(data, cutoff, fs, order=2):
    print "High Cutt" , cutoff
    b, a = butter_highpass(cutoff, fs, order=order)
    y = lfilter(b, a, data)
    return y