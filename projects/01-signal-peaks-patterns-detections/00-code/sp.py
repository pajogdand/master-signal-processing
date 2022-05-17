import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import butter, lfilter, freqz
import matplotlib.pyplot as plt
from myhighpassfilter import show_hp , butter_highpass_filter
from mylowpassfilter import butter_lowpass_filter , show_lp
from potholeDetection import PeakDetection , PotHoleStartAndEndDetection


def ax_from_mat(data):
    return data[:,0], data[:,1], data[:,2] , data[:,3]


####################################################################
# Naame  : FindLPFilterCutFrq()
# Input  : Mean RMS data of 3 Axis , fs
# Output : Dict Peaks containing Peaks and corresponding timestamps
#
# Aut : Pravin Jogdand
###################################################################
def FindLPFilterCutFrq(r,fs):
    # print r
    import numpy as np
    from numpy import sqrt , mean , square
    import scipy.stats as ss
    AllFrqCut = np.arange(0.01*fs,0.5*fs,0.01)
    r_rms = sqrt(mean(square(r)))
    SNR = []
    for fc in AllFrqCut:
        fildata     = butter_lowpass_filter(r,fc,fs)
        fildata_rms = np.sqrt(mean(square(fildata)))

        #Method a
        diff_in_rms = ss.signaltonoise(fildata)

        #Method b
        # diff_in_rms = r_rms - fildata_rms

        SNR.append([ diff_in_rms , fc])
    return SNR

if __name__ == "__main__":

        # Take data from data.scv file
        fs = 200
        order = 3
        AllAxisdata = np.loadtxt("data.csv", delimiter=',', skiprows=1)
        x, y, z, tFromFile = ax_from_mat(AllAxisdata)
        data = z
        n = len(data)
        sampling = fs
        T = sampling/fs
        nsample  = len(x)
        dt = 1.0 / sampling
        t = np.linspace(0.0, nsample*dt,nsample)
        timestamps = t

        r = np.array([])
        R =  np.sqrt(np.square(np.array(x)) + np.square(np.array(y)) + np.square(np.array(z)))

        # Compute best LowCutOff and HighCutOff frq
        SNR = FindLPFilterCutFrq(R,fs)
        AllSNR = [snr[0] for snr in SNR]
        Allfc  = [snr[1] for snr in SNR]
        Index  = AllSNR.index(max(AllSNR))

        lowcut  = Allfc[Index]
        highcut = fs/2 - 10*lowcut

        print " Setting up lowcut = "  , lowcut
        print " Setting up highcut = " , highcut

        show_lp(R, timestamps, lowcut, fs, order)

        rLowPass  = butter_lowpass_filter(R,lowcut, fs, order)
        rHighPass = butter_highpass_filter(R,highcut,fs,order)
        show_hp(R, timestamps, highcut, fs, order)
        r = rLowPass + rHighPass

        #Detect Peaks in Filtered Data
        peaks = PeakDetection(r, timestamps)
        peak_ts = [above['ts'] for above in peaks]
        peak_val = [above['val'] for above in peaks]

        #Detect Start and End of the Pothole
        jerk_area_start_end ,Jerk_corner =  PotHoleStartAndEndDetection(peak_ts ,peak_val )

        # Show the result
        plt.plot(timestamps, R, 'b-', linewidth=2 , label = 'Orignal Signal')
        # plt.plot(timestamps, rLowPass, 'k-', linewidth=3 , label = 'LowPass Filtered Signal')
        # plt.plot(timestamps, rHighPass, 'g-', linewidth=1 , label = 'HighPass Filtered Signal')
        # plt.plot(timestamps, r, 'r-', linewidth=.5 , label = 'Band Pass Filtered Signal')
        # plt.plot(timestamps, r, 'g-', linewidth=2)
        # plt.plot(timestamps, z, 'k-', linewidth=2)
        # plt.plot(timestamps, r, 'b-', linewidth=1)
        plt.plot(peak_ts, peak_val, 'go' , ms=4 , label = 'Peaks')
        plt.plot(jerk_area_start_end[::2], Jerk_corner[::2], 'ko',ms=8 , label = 'PotHoleStart')
        plt.plot(jerk_area_start_end[1::2], Jerk_corner[1::2], 'yo',ms=8 , label = 'PotHoleEnd')
        # plt.title("Detected Start and End of Potholes")
        plt.xlabel('Time [sec]')
        plt.ylabel('Acc in mm/sec2')
        plt.grid()
        plt.legend()
        plt.show()
