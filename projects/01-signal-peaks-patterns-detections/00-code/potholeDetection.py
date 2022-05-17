import numpy as np

####################################################################
# Naame  : PeakDetection()
# Input  : Band Filtered data and timeStamp
# Output : Dict Peaks containing Peaks and corresponding timestamps
#
# Aut : Pravin Jogdand
###################################################################
def PeakDetection(data, tmss):
    previous_state = None
    present_state = None
    previous_peak = None
    last_below = None

    # zero = GRAVITY
    zero = np.mean(data) + np.std(data)
    # print np.std(data)
           # + np.std(data)
           # - np.std(data)
    # zero = np.mean(data) + 1
    print "zero = " , zero
    peaks = []
    for i, (d, tms) in enumerate(zip(data, tmss)):

        if d < zero:
            present_state = 'below'
        elif d > zero:
            present_state = 'above'

        if present_state is not previous_state:
            if previous_state is 'below':
                last_below = None
                previous_peak = None
            elif previous_state is 'above':
                peaks.append(previous_peak)

        if present_state is 'above' and (previous_peak is None or d > previous_peak["val"]):
            previous_peak = { "ts": tms,"val": float(d)}

        previous_state = present_state

    return np.array(peaks)

############################################################
# Naame  : PotHoleStartAndEndDetection()
# Input  : Peaks detected vector and timestamps
# Output : Vetor of start/end detected timestamps and peaks
#
# Aut : Pravin Jogdand
############################################################
def PotHoleStartAndEndDetection(peak_ts , peak_val):
    jerk_area_start_ts  = []
    jerk_area_end_ts    = []

    jerk_area_start_ts_i = []
    jerk_area_end_ts_i   = []
    jerk_area_start_end  = []

    JDDT = 17.0
    for i,pt in enumerate(peak_ts):
        if i == 0:
            # pass
            jerk_area_start_end.append(peak_ts[i+1])
        elif i == len(peak_ts) -1:
            jerk_area_start_end.append(peak_ts[-1])
        elif ( peak_ts[i+1] - peak_ts[i] ) >= JDDT:
            print "Got Tansition at " , peak_ts[i] , peak_ts[i+1] ,i , i+1
            jerk_area_start_ts.append(peak_ts[i]) , jerk_area_end_ts.append(peak_ts[i+1])
            jerk_area_start_ts_i.append(i) , jerk_area_end_ts_i.append(i+1)
            jerk_area_start_end.append(peak_ts[i])
            jerk_area_start_end.append(peak_ts[i+1])
        else:
            pass


    print jerk_area_start_end

    Jerk_corner = []
    for j in jerk_area_start_end:
        for i,pt in enumerate(peak_ts):
            if pt == j and j%2 == 0:
                Jerk_corner.append(peak_val[i-JDDT])
            elif pt == j and j%2 != 0:
                Jerk_corner.append(peak_val[i])
    print Jerk_corner
    return jerk_area_start_end , Jerk_corner