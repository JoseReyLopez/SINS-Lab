from matplotlib.patches import Rectangle
import matplotlib.pyplot as plt
from scipy.io import loadmat
from glob import glob
import numpy as np
import shutil
import h5py
import os



RAT = 397550

tf_cspc = loadmat('../Discrimination_'+str(RAT)+'/TF_csp_correct.mat')['tf_Csp_correct'][0][0][2]
tf_csmc = loadmat('../Discrimination_'+str(RAT)+'/TF_csm_correct.mat')['tf_Csm_correct'][0][0][2]
tf_csmi = loadmat('../Discrimination_'+str(RAT)+'/TF_csm_incorrect.mat')['tf_Csm_incorrect'][0][0][2]

tf_cspc_crt = loadmat('../Discrimination_'+str(RAT)+'/TF_CRT_csp_correct_baseline.mat')['tf_CRT_csp_correct_baseline'][0][0][2]
tf_csmc_crt = loadmat('../Discrimination_'+str(RAT)+'/TF_CRT_csm_correct_baseline.mat')['tf_CRT_csm_correct_baseline'][0][0][2]
tf_csmi_crt = loadmat('../Discrimination_'+str(RAT)+'/TF_CRT_csm_incorrect_baseline.mat')['tf_CRT_csm_incorrect_baseline'][0][0][2]

zero_crt = loadmat('../Discrimination_'+str(RAT)+'/TF_CRT_csm_incorrect_baseline.mat')['tf_CRT_csm_incorrect_baseline'][0][0][5][0][0];
time_crt = loadmat('../Discrimination_'+str(RAT)+'/TF_CRT_csm_correct_baseline.mat')['tf_CRT_csm_correct_baseline'][0][0][1][0];

tf_cspc_cmt = loadmat('../Discrimination_'+str(RAT)+'/TF_CMT_csp_correct_baseline.mat')['tf_CMT_csp_correct_baseline'][0][0][2]
tf_csmc_cmt = loadmat('../Discrimination_'+str(RAT)+'/TF_CMT_csm_correct_baseline.mat')['tf_CMT_csm_correct_baseline'][0][0][2]
tf_csmi_cmt = loadmat('../Discrimination_'+str(RAT)+'/TF_CMT_csm_incorrect_baseline.mat')['tf_CMT_csm_incorrect_baseline'][0][0][2]

zero_cmt = loadmat('../Discrimination_'+str(RAT)+'/TF_CMT_csm_incorrect_baseline.mat')['tf_CMT_csm_incorrect_baseline'][0][0][5][0][0];
time_cmt = loadmat('../Discrimination_'+str(RAT)+'/TF_CMT_csm_correct_baseline.mat')['tf_CMT_csm_correct_baseline'][0][0][1][0];


frex = loadmat('../Discrimination_'+str(RAT)+'/TF_csp_correct.mat')['tf_Csp_correct'][0][0][0][0]




time_add_CST = [700, 1200]
time_add_CRT = [100, 600]
time_add_CMT = [-800, -300]

time_range_CST = [2000 + time_add_CST[0],      2000 + time_add_CST[1]]
time_range_CRT = [zero_crt + time_add_CRT[0],  zero_crt + time_add_CRT[1]]
time_range_CMT = [zero_cmt + time_add_CMT[0],  zero_cmt + time_add_CMT[1]]

freq_range = [2, 5, 6, 12, 15, 30, 58, 89]


fq = np.array(freq_range).reshape(-1, 2)

pos_freq = []
for i in freq_range:
    pos_freq.append(np.argmin(np.abs(frex-i)))
    

regions = np.array([[0,16,32,48],[16, 32, 48, 64]]).T

pos_freq_rev = np.subtract(49, pos_freq)



channel = 12

v = 2

### PLOT WITHOUT COLORBAR

fig, ax = plt.subplots(3, 3, figsize = (10,10), sharex = True, sharey = True)

im = ax[0,0].imshow(np.flipud(tf_cspc[channel, :, 500:3500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)
ax[0,1].imshow(np.flipud(tf_csmc[channel, :, 500:3500]), aspect = 3000/50 ,      cmap = 'jet', vmin = -v, vmax = v)
ax[0,2].imshow(np.flipud(tf_csmi[channel, :, 500:3500]), aspect = 3000/50 ,      cmap = 'jet', vmin = -v, vmax = v)


ax[1,0].imshow(np.flipud(tf_cspc_crt[channel, :, zero_crt-1500:zero_crt+1500]),  aspect = 3000/50 ,   cmap = 'jet', vmin = -v, vmax = v)
ax[1,1].imshow(np.flipud(tf_csmc_crt[channel, :, zero_crt-1500:zero_crt+1500]),  aspect = 3000/50 ,   cmap = 'jet', vmin = -v, vmax = v)
ax[1,2].imshow(np.flipud(tf_csmi_crt[channel, :, zero_crt-1500:zero_crt+1500]),  aspect = 3000/50 ,   cmap = 'jet', vmin = -v, vmax = v)


ax[2,0].imshow(np.flipud(tf_cspc_cmt[channel, :, zero_cmt-1500:zero_cmt+1500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)
ax[2,1].imshow(np.flipud(tf_csmc_cmt[channel, :, zero_cmt-1500:zero_cmt+1500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)
ax[2,2].imshow(np.flipud(tf_csmi_cmt[channel, :, zero_cmt-1500:zero_cmt+1500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)



lw = 2

for i in range(3):
    for j in range(3):
        ax[i,j].plot([1500, 1500], [0, 49], 'k-')
        ax[i,j].plot([0, 2999], [30,30], 'k:')

for i in range(3):
    for j in range(3):
        for freq_i in range(4):
            if i == 0:
                ax[i, j].add_patch(Rectangle((time_add_CST[0]+1500, pos_freq_rev[freq_i*2]), time_add_CST[1]-time_add_CST[0], -(pos_freq_rev[freq_i*2]-pos_freq_rev[freq_i*2+1]), fill = False, edgecolor = 'k', lw = lw))

            if i == 1:
                ax[i, j].add_patch(Rectangle((time_add_CRT[0]+1500, pos_freq_rev[freq_i*2]), time_add_CRT[1]-time_add_CRT[0], -(pos_freq_rev[freq_i*2]-pos_freq_rev[freq_i*2+1]), fill = False, edgecolor = 'k', lw = lw))

            if i == 2:
                ax[i, j].add_patch(Rectangle((time_add_CMT[0]+1500, pos_freq_rev[freq_i*2]), time_add_CMT[1]-time_add_CMT[0], -(pos_freq_rev[freq_i*2]-pos_freq_rev[freq_i*2+1]), fill = False, edgecolor = 'k', lw = lw))


ax[2, 0].set_xticks([i for i in range(0, 3001, 500)])
ax[2, 0].set_xticklabels([str((i-1500)/1000) for i in range(0, 3001, 500)])

ax[2, 1].set_xticks([i for i in range(0, 3001, 500)])
ax[2, 1].set_xticklabels([str((i-1500)/1000) for i in range(0, 3001, 500)])

ax[2, 2].set_xticks([i for i in range(0, 3001, 500)])
ax[2, 1].set_xticklabels([str((i-1500)/1000) for i in range(0, 3001, 500)])


ax[0,0].set_title('CS+ C ; Stimulus centered')
ax[0,1].set_title('Time Frequency plot for one channel ; RAT: '+str(RAT)+'\n\nCS- C ; Stimulus centered')
ax[0,2].set_title('CS- I ; Stimulus centered')

ax[1,0].set_title('CS+ C ; Reaction centered')
ax[1,1].set_title('CS- C ; Reaction centered')
ax[1,2].set_title('CS- I ; Reaction centered')

ax[2,0].set_title('CS+ C ; Movement centered')
ax[2,1].set_title('CS- C ; Movement centered')
ax[2,2].set_title('CS- I ; Movement centered')



n_ticks = 6
ticks_pos = np.linspace(0, len(frex)-1, n_ticks).astype(int)
ticks_labels = np.round(frex[np.linspace(0, len(frex)-1, n_ticks).astype(int)]).astype(int)


for i in range(3):
    ax[0,i].set_yticks(ticks_pos)
    ax[0,i].set_yticklabels(ticks_labels[::-1])
    ax[i,0].set_ylabel('Frequency (Hz)')
    ax[2,i].set_xlabel('Time (s)')
    
    
plt.savefig('TF_plots_'+str(RAT)+'.png', dpi = 150, transparent = False, facecolor='white')


#### COLORBAR IMAGE


fig, ax = plt.subplots(3, 3, figsize = (10,10), sharex = True, sharey = True)

im = ax[0,0].imshow(np.flipud(tf_cspc[channel, :, 500:3500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)
ax[0,1].imshow(np.flipud(tf_csmc[channel, :, 500:3500]), aspect = 3000/50 ,      cmap = 'jet', vmin = -v, vmax = v)
ax[0,2].imshow(np.flipud(tf_csmi[channel, :, 500:3500]), aspect = 3000/50 ,      cmap = 'jet', vmin = -v, vmax = v)


ax[1,0].imshow(np.flipud(tf_cspc_crt[channel, :, zero_crt-1500:zero_crt+1500]),      aspect = 3000/50 ,   cmap = 'jet', vmin = -v, vmax = v)
ax[1,1].imshow(np.flipud(tf_csmc_crt[channel, :, zero_crt-1500:zero_crt+1500]),      aspect = 3000/50 ,   cmap = 'jet', vmin = -v, vmax = v)
im = ax[1,2].imshow(np.flipud(tf_csmi_crt[channel, :, zero_crt-1500:zero_crt+1500]), aspect = 3000/50 ,   cmap = 'jet', vmin = -v, vmax = v)

fig.colorbar(im, ax = ax[1,2])


ax[2,0].imshow(np.flipud(tf_cspc_cmt[channel, :, zero_cmt-1500:zero_cmt+1500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)
ax[2,1].imshow(np.flipud(tf_csmc_cmt[channel, :, zero_cmt-1500:zero_cmt+1500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)
ax[2,2].imshow(np.flipud(tf_csmi_cmt[channel, :, zero_cmt-1500:zero_cmt+1500]), aspect = 3000/50 , cmap = 'jet', vmin = -v, vmax = v)




for i in range(3):
    for j in range(3):
        ax[i,j].plot([1500, 1500], [0, 49], 'k-')
        ax[i,j].plot([0, 2999], [30,30], 'k:')
        
ax[2, 0].set_xticks([i for i in range(0, 3001, 500)])
ax[2, 0].set_xticklabels([str((i-1500)/1000) for i in range(0, 3001, 500)])

ax[2, 1].set_xticks([i for i in range(0, 3001, 500)])
ax[2, 1].set_xticklabels([str((i-1500)/1000) for i in range(0, 3001, 500)])

ax[2, 2].set_xticks([i for i in range(0, 3001, 500)])
ax[2, 1].set_xticklabels([str((i-1500)/1000) for i in range(0, 3001, 500)])


ax[0,0].set_title('CS+ C ; Stimulus centered')
ax[0,1].set_title('Time Frequency plot for one channel\n\nCS- C ; Stimulus centered')
ax[0,2].set_title('CS- I ; Stimulus centered')

ax[1,0].set_title('CS+ C ; Reaction centered')
ax[1,1].set_title('CS- C ; Reaction centered')
#ax[1,2].set_title('CS- I ; Reaction centered')

ax[2,0].set_title('CS+ C ; Movement centered')
ax[2,1].set_title('CS- C ; Movement centered')
ax[2,2].set_title('CS- I ; Movement centered')



n_ticks = 6
ticks_pos = np.linspace(0, len(frex)-1, n_ticks).astype(int)
ticks_labels = np.round(frex[np.linspace(0, len(frex)-1, n_ticks).astype(int)]).astype(int)


for i in range(3):
    ax[0,i].set_yticks(ticks_pos)
    ax[0,i].set_yticklabels(ticks_labels[::-1])
    ax[i,0].set_ylabel('Frequency (Hz)')
    ax[2,i].set_xlabel('Time (s)')
    
    
plt.savefig('colorbar_'+str(RAT)+'.png', dpi = 150, transparent = False, facecolor='white')




power = np.zeros([3, 3, 4, int(len(freq_range)/2)]) # Centering, condition, region, freq



for ch_i, ch in enumerate(regions):
    for freq_i, freq in enumerate(np.array(pos_freq).reshape(-1, 2)):
        power[0,0,ch_i,freq_i] = np.nanmean(tf_cspc[ch[0]:ch[1], freq[0]:freq[1], time_range_CST[0]:time_range_CST[1]])
        power[0,1,ch_i,freq_i] = np.nanmean(tf_csmc[ch[0]:ch[1], freq[0]:freq[1], time_range_CST[0]:time_range_CST[1]])
        power[0,2,ch_i,freq_i] = np.nanmean(tf_csmi[ch[0]:ch[1], freq[0]:freq[1], time_range_CST[0]:time_range_CST[1]])
        
        power[1,0,ch_i,freq_i] = np.nanmean(tf_cspc_crt[ch[0]:ch[1], freq[0]:freq[1], time_range_CRT[0]:time_range_CRT[1]])
        power[1,1,ch_i,freq_i] = np.nanmean(tf_csmc_crt[ch[0]:ch[1], freq[0]:freq[1], time_range_CRT[0]:time_range_CRT[1]])
        power[1,2,ch_i,freq_i] = np.nanmean(tf_csmi_crt[ch[0]:ch[1], freq[0]:freq[1], time_range_CRT[0]:time_range_CRT[1]])
        
        power[2,0,ch_i,freq_i] = np.nanmean(tf_cspc_cmt[ch[0]:ch[1], freq[0]:freq[1], time_range_CMT[0]:time_range_CMT[1]])
        power[2,1,ch_i,freq_i] = np.nanmean(tf_csmc_cmt[ch[0]:ch[1], freq[0]:freq[1], time_range_CMT[0]:time_range_CMT[1]])
        power[2,2,ch_i,freq_i] = np.nanmean(tf_csmi_cmt[ch[0]:ch[1], freq[0]:freq[1], time_range_CMT[0]:time_range_CMT[1]])
        
        
        
        
fig, ax = plt.subplots(3, 4, figsize = (18, 10))



barWidth = 0.2

for centering_i in range(3):
    for region_i in range(4):
        f1 = ax[centering_i, region_i].bar(np.subtract([0,1,2,3], .2), power[centering_i,0,region_i,:], width = barWidth, color = 'lime',   label = 'CS+ C')#label = str(fq[0,0]) + '-' + str(fq[0,1]) + ' Hz')
        f2 = ax[centering_i, region_i].bar(np.subtract([0,1,2,3],  0), power[centering_i,1,region_i,:], width = barWidth, color = 'purple', label = 'CS- C')#label = str(fq[1,0]) + '-' + str(fq[1,1]) + ' Hz')
        f3 = ax[centering_i, region_i].bar(np.subtract([0,1,2,3],-.2), power[centering_i,2,region_i,:], width = barWidth, color = 'red',    label = 'CS- I')#label = str(fq[2,0]) + '-' + str(fq[2,1]) + ' Hz')
        #f4 = ax[centering_i, region_i].bar(np.subtract([0,1,2,3],-.2), power[centering_i,:,region_i,3], width = barWidth, color = 'red',    label = 'CS- I')#label = str(fq[2,0]) + '-' + str(fq[2,1]) + ' Hz')
        
        ax[centering_i, region_i].plot([-.5, 3.5], [0,0], 'k-', linewidth = 1)
        ax[centering_i, region_i].set_xlim([-.5, 3.5])
        ax[centering_i, region_i].set_xticks([0, 1, 2, 3])
        ax[centering_i, region_i].set_xticklabels([str(fq[0,0]) + '-' + str(fq[0,1]) + 'Hz', str(fq[1,0]) + '-' + str(fq[1,1]) + 'Hz', str(fq[2,0]) + '-' + str(fq[2,1]) + 'Hz', str(fq[3,0]) + '-' + str(fq[3,1]) + 'Hz'])
        

ax[0,0].set_title('OFC 1 \n\n Stimulus centered')
ax[0,1].set_title('OFC 2 \n\n Stimulus centered')
ax[0,2].set_title('BLA 1 \n\n Stimulus centered')
ax[0,3].set_title('BLA 2 \n\n Stimulus centered')

ax[1,0].set_title('Reaction centered')
ax[1,1].set_title('Reaction centered')
ax[1,2].set_title('Reaction centered')
ax[1,3].set_title('Reaction centered')

ax[2,0].set_title('Movement centered')
ax[2,1].set_title('Movement centered')
ax[2,2].set_title('Movement centered')
ax[2,3].set_title('Movement centered')


plt.subplots_adjust(left=0.1,
                    bottom=0.1, 
                    right=0.9, 
                    top=0.9, 
                    wspace=0.4, 
                    hspace=0.4)


ax[0,0].legend()

plt.savefig('power_bars_'+str(RAT)+'.png', dpi = 150, transparent = False, facecolor='white')





tf_img = plt.imread('TF_plots_'+str(RAT)+'.png')
pb_img = plt.imread('power_bars_'+str(RAT)+'.png')
cb_img = plt.imread('colorbar_'+str(RAT)+'.png')
colorbar = np.vstack([np.ones([560, 100, 4]), cb_img[560:950, 1290:1390], np.ones([1500-950, 100, 4])])


img = np.hstack([tf_img[:,0:1370], colorbar, pb_img])
#plt.imsave('image_combined_'+str(RAT)+'.png', img)

plt.figure(figsize = (20,20))
plt.imshow(img)


plt.imsave('../Discrimination_397550/image_combined_'+str(RAT)+'.png', img)

os.remove('TF_plots_'+str(RAT)+'.png')
os.remove('power_bars_'+str(RAT)+'.png')
os.remove('colorbar_'+str(RAT)+'.png')