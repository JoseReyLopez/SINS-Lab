import matplotlib.pyplot as plt
from scipy.io import loadmat
import scipy.io as io
import numpy as np
import copy
import cv2
import os
from glob import glob



sorted32 = loadmat('channel_43_sorted_32.mat')['tosave']
sorted40 = loadmat('channel_43_sorted_40.mat')['tosave']



rat_number = int(glob('time_marker_32*.mat')[-1].split('.')[0].split('_')[-1])



time_marker_32 = loadmat(f'time_marker_32_{rat_number}.mat')['time_marker_32']
time_marker_32 = time_marker_32[time_marker_32>0]

time_marker_40 = loadmat(f'time_marker_40_{rat_number}.mat')['time_marker_40']
time_marker_40 = time_marker_40[time_marker_40>0]




V32 = np.sort(time_marker_32)
V40 = np.sort(time_marker_40)

I32 = np.argsort(time_marker_32)
I40 = np.argsort(time_marker_40)

size_trials = V32.shape[0]



import matplotlib as mpl
mpl.rcParams['figure.dpi'] = 300



###############################################




fig, ax = plt.subplots(1, 2,figsize=(15,7.5))


channel_mean = np.mean(sorted32)
channel_std = np.std(sorted32)

scale = np.max([np.abs(channel_mean-channel_std), np.abs( channel_mean + channel_std)])


im = ax[0].imshow(sorted32[:, 93:].T, cmap = 'jet', vmin = -scale , vmax = scale , aspect=10)
ax[0].plot([2000, 2000], [0, size_trials], 'k', lw = 3)
ax[0].plot(V32[V32>0].T + 2000, list(range(0, size_trials,1)), 'k', lw = 3)
ax[0].scatter(time_marker_40[I32]+2000, list(range(0,size_trials,1)), s = 3, c = 'black')
ax[0].set_title('Sorted by reaction time [Channel 43] ; # trials = '+str(size_trials) , fontsize = 10)
ax[0].set_ylim(0, size_trials)
ax[0].set_xticks([i for i in range(0, 7001, 1000)])
ax[0].set_xticklabels([str(int(i/1000-2)) for i in range(0, 7001, 1000)])
ax[0].set_xlabel('Time (s)')
ax[0].set_ylabel('# Trials')
cbar = fig.colorbar(im, ax = ax[0], shrink = 0.6)


channel_mean = np.mean(sorted40)
channel_std = np.std(sorted40)

im = ax[1].imshow(sorted40[:, 93:].T, cmap = 'jet', vmin = -scale, vmax =  scale, aspect=10)
ax[1].plot([2000, 2000], [0, size_trials], 'k', lw = 3)
ax[1].plot(V40[V40>0].T + 2000, list(range(0, size_trials,1)), 'k', lw = 3)
ax[1].scatter(time_marker_32[I40]+2000, list(range(0,size_trials,1)), s = 3, c = 'black')
ax[1].set_title('Sorted by movement time [Channel 43] ; # trials = '+str(size_trials) , fontsize = 10)
ax[1].set_ylim(0, size_trials)
ax[1].set_xticks([i for i in range(0, 7001, 1000)])
ax[1].set_xticklabels([str(int(i/1000-2)) for i in range(0, 7001, 1000)])
ax[1].set_xlabel('Time (s)')
ax[1].set_ylabel('# Trials')
cbar = fig.colorbar(im, ax = ax[1], shrink = 0.6)


if 0:

    channel_mean = np.mean(sorted32 - sorted40)
    channel_std  = np.std(sorted32 - sorted40)



    im = ax[2].imshow(np.flipud(sorted32[:, 103:].T) - np.flipud(sorted40[:, 103:].T), cmap = 'jet', vmin = -scale, vmax =  scale, aspect=10)
    ax[2].set_title('ERP reaction t - ERP movement t ; Reaction stronger' , fontsize = 5)
    ax[2].plot([2000, 2000], [0, size_trials], 'k', lw = 2)
    ax[2].plot(V32[V32>0].T + 2000, list(range(0,size_trials,1))[::-1], 'k', lw = 2)
    ax[2].plot(V40[V40>0].T + 2000, list(range(0,size_trials,1))[::-1], 'k', lw = 2)
    cbar = fig.colorbar(im, ax = ax[2], shrink = 0.6)


plt.savefig('ERP__CRT_CMT.png', dpi = 300, transparent = False, facecolor='white')




####################################################################################



fig, ax = plt.subplots(1, 3,figsize=(10,10))


channel_mean = np.mean(sorted32)
channel_std = np.std(sorted32)

ax[0].imshow(sorted32[:, 83:].T, cmap = 'jet', vmin = channel_mean-channel_std, vmax = channel_mean + channel_std, aspect=10)
ax[0].plot([2000, 2000], [0, size_trials], 'k', lw = 2)
ax[0].plot(V32[V32>0].T + 2000, list(range(0,size_trials,1)), 'k', lw = 2)
ax[0].scatter(time_marker_40[I32]+2000, list(range(0,size_trials,1)), s = 2, c = 'black')
ax[0].set_title('Sorted by reaction time [Channel 43]' , fontsize = 8)
ax[0].set_xticks([i for i in range(0, 7001, 1000)])
ax[0].set_xticklabels([str(int(i/1000-2)) for i in range(0, 7001, 1000)], fontsize = 5)

ax[0].set_yticks([i for i in range(0, 601, 100)])
ax[0].set_yticklabels([str(i) for i in range(0, 601, 100)], fontsize = 5)
ax[0].set_ylabel('# Trials', fontsize = 5)

ax[0].set_xticks([i for i in range(0, 7001, 1000)])
ax[0].set_xticklabels([str(int(i/1000-2)) for i in range(0, 7001, 1000)], fontsize = 5)
ax[0].set_xlabel('Time (s)', fontsize = 5)
ax[0].set_ylim(0, size_trials)




channel_mean = np.mean(sorted40)
channel_std = np.std(sorted40)

ax[1].imshow(sorted40[:, 93:].T, cmap = 'jet', vmin = channel_mean-channel_std, vmax = channel_mean + channel_std, aspect=10)
ax[1].plot([2000, 2000], [0, size_trials], 'k', lw = 2)
ax[1].plot(V40[V40>0].T + 2000, list(range(0,size_trials,1)), 'k', lw = 2)
ax[1].scatter(time_marker_32[I40]+2000, list(range(0,size_trials,1)), s = 2, c = 'black')

ax[1].set_yticks([i for i in range(0, 601, 100)])
ax[1].set_yticklabels([str(i) for i in range(0, 601, 100)], fontsize = 5)
ax[1].set_ylabel('# Trials', fontsize = 5)

ax[1].set_xticks([i for i in range(0, 7001, 1000)])
ax[1].set_xticklabels([str(int(i/1000-2)) for i in range(0, 7001, 1000)], fontsize = 5)
ax[1].set_xlabel('Time (s)', fontsize = 5)

ax[1].set_title('Sorted by movement time [Channel 43]' , fontsize = 8)
ax[1].set_ylim(0, size_trials)




channel_mean = np.mean(sorted32 - sorted40)
channel_std  = np.std(sorted32 - sorted40)



ax[2].imshow(sorted32[:,93:].T - sorted40[:, 93:].T, cmap = 'jet', vmin = channel_mean-channel_std, vmax = channel_mean + channel_std, aspect=10)
ax[2].set_title('ERP reaction t - ERP movement t ; Reaction stronger' , fontsize = 8)
ax[2].plot([2000, 2000], [0, size_trials], 'k', lw = 2)
ax[2].plot(V32[V32>0].T + 2000, list(range(0,size_trials,1)), 'k', lw = 2)
ax[2].plot(V40[V40>0].T + 2000, list(range(0,size_trials,1)), 'k', lw = 2)

ax[2].set_yticks([i for i in range(0, 601, 100)])
ax[2].set_yticklabels([str(i) for i in range(0, 601, 100)], fontsize = 5)
ax[2].set_ylabel('# Trials', fontsize = 5)

ax[2].set_xticks([i for i in range(0, 7001, 1000)])
ax[2].set_xticklabels([str(int(i/1000-2)) for i in range(0, 7001, 1000)], fontsize = 5)
ax[2].set_xlabel('Time (s)', fontsize = 5)

ax[2].set_ylim(0, size_trials)

plt.savefig('ERP__CRT_CMT_difference.png', dpi = 300, transparent = False, facecolor='white')