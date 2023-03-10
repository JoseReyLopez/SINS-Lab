import matplotlib.pyplot as plt
from scipy.io import loadmat
import scipy.io as io
import numpy as np
import itertools
import glob
import cv2
import os


def plot_tf_topographical(data, bad_channels, cut = [1500, 1500], show = 0, title = 'NO TITLE SELECTED', save = 0, save_name = '', SPREAD = 3):

    def recenter_plot(img_name):
        import cv2
        im = cv2.imread(img_name)
        im0 = im[0:4000, :, :]
        im1 = im[4000:, :,  :]
        im2 = np.hstack((im1[:, 1033:, :], np.ones((im1.shape[0], 1033, 3))))
        im3 = np.vstack((im0, im2))
        del im0, im1, im2
        im4 = im3[:,:-3000, :]
        im5 = np.hstack((255*np.ones((im4.shape[0], 500, 3)), im4,  255*np.ones((im4.shape[0], 500, 3))))
        del im4
        im6 = np.vstack( ( 255*np.ones((500, im5.shape[1], 3)), im5, 255*np.ones((500, im5.shape[1], 3))))
        cv2.imwrite(img_name, im6)

    #time0 = int(file.split('_')[-2])
    #time1 = int(file.split('_')[-1].split('.')[-2])
    
    
    #'tf_baseline_1200_1500.mat'
    
    #print('Data: ', data)
    key = [i for i in loadmat(data).keys() if '_'!=i[0]][0]

    xy_dict = {

    #%% OFC 1
    1	:   [8,	1],
    2	:   [7,	1],
    3	:   [6,	1],
    4	:	[5,	1],
    5	:	[4,	1],
    6	:	[3,	1],
    7	:	[2,	1],
    8	:	[1,	1],

    9	:	[1,	2],
    10	:	[2,	2],
    11	:	[3,	2],
    12	:	[4,	2],
    13  :	[5,	2],
    14	:	[6,	2],
    15	:	[7,	2],
    16	:	[8,	2],


    #%% OFC 2
    17	:	[11, 2],
    18	:	[12, 2],
    19	:	[13, 2],
    20	:	[14, 2],
    21	:	[15, 2],
    22	:	[16, 2],
    23	:	[17, 2],
    24	:	[18, 2],

    25	:	[18, 1],
    26	:	[17, 1],
    27	:	[16, 1],
    28	:	[15, 1],
    29	:	[14, 1],
    30	:	[13, 1],
    31	:	[12, 1],
    32	:	[11, 1],


    #%% BLA 1			
    33	:	[8,	7],
    34	:	[7,	7],
    35	:	[6,	7],
    36	:	[8,	9],
    38	:	[8,	5],
    39	:	[7,	5],
    40	:	[6,	5],
    41	:	[6,	6],
    42	:	[7,	6],
    43	:	[8,	6],
    44	:	[6,	9],
    45	:	[7,	9],
    46	:	[6,	8],
    47	:	[7,	8],
    48	:	[8,	8],


    #%% BLA 2		
    49	:	[11, 8],
    50	:	[12, 8],
    51  :	[13, 8],
    52	:	[12, 9],
    53  :	[13, 9],
    54	:	[11, 6],
    55	:	[12, 6],
    56	:	[13, 6],
    57	:	[13, 5],
    58	:	[12, 5],
    59	:	[11, 5],
    61	:	[11, 9],
    62	:	[11, 7],
    63	:	[12, 7],
    64	:   [13, 7]}
    

        
    data = loadmat(data)
    data = data[key]

    tf = data['TF_data'][0][0]
    frex = data['frex'][0][0][0]
    time = data['times']

    n_lines = tf.shape[1]

    try:
        zero_point = data['zero'][0][0][0][0]
    except:
        zero_point = 2000
    
    cut1 = 1500;
    cut2 = 1500;
    
    aspect_ratio = (np.abs(cut1) + np.abs(cut2))/n_lines;
    abs_cut = (np.abs(cut1) + np.abs(cut2));
    
    #print(cut1, cut1, aspect_ratio, abs_cut)
    
    
    tf = tf[:, :, zero_point - cut1: zero_point + cut2]


    width = 200
    aspect = 26

    # number of subplots
    s1 = 8
    s2 = 18

    for channel in range(64):  ## I leave the 64, since in principle, all experiments run here, will have all the channels
        
        if channel+1 in xy_dict:
            y_pos, x_pos = xy_dict[channel+1]
            x_pos -= 1
            y_pos -= 1
            
            if x_pos>2:
                x_pos -= 1
                
        else:
            #print(channel)
            pass
        

        if channel == 0:# or channel == 32:
            fig, ax = plt.subplots(s1,s2,figsize=(width, width/2))
            
            fig.suptitle(title, x = .45, y = .9, fontsize=100)


        if 0  <= channel <= 15:
            brain_part = 'OFC1'
        if 16 <= channel <= 31:
            brain_part = 'OFC2'
        if 32 <= channel <= 47:
            brain_part = 'BLA1'
        if 48 <= channel <= 63:
            brain_part = 'BLA2'

            
            

        ax[x_pos, y_pos].set_title(brain_part + ' Ch: ' +str(channel + 1), fontsize = 50)

        
        ### Channels that could have data, but they dont, were removed or whatever
        
        if channel in np.subtract(bad_channels, 1) and channel+1 in xy_dict.keys():
            #print('HERE, bad channel ' + str(channel))ct
            ax[x_pos, y_pos].imshow(np.flipud(np.zeros([n_lines, abs_cut])), cmap = 'Greys', aspect = aspect_ratio)
            #ax[x_pos, y_pos].set_title(brain_part + ' Ch: ' +str(channel + 1) + '   Bad channel', fontsize = 50)
            ax[x_pos, y_pos].set_title(' ', fontsize = 50)
            ax[x_pos, y_pos].set_xlabel(' ', fontsize = 30)
            ax[x_pos, y_pos].set_ylabel(' ', fontsize = 30)
            ax[x_pos, y_pos].set_yticks([])
            ax[x_pos, y_pos].set_xticks([])



        ### Putting the channels with data nice, xtick, yticks etc etc
        
        if channel not in np.subtract(bad_channels, 1):
            
            #print('Here, good channel  ' + str(channel))
            
            #SPREAD = 3
            
            if channel in list(range(31)):
                v_mean = np.nanmean(tf[0:31, :, :])
                v_std  = np.nanstd(tf[0:31, :, :])
                
                max_diff = np.max([np.abs(v_mean - SPREAD*v_std), np.abs(v_mean + SPREAD*v_std)]) 
                
            
            if channel in list(range(32, 64)):
                v_mean = np.nanmean(tf[32:, :, :])
                v_std  = np.nanstd(tf[32:, :, :])
                
                max_diff = np.max([np.abs(v_mean - SPREAD*v_std), np.abs(v_mean + SPREAD*v_std)]) 
            
            if channel == 16 or channel == 48:
                im = ax[x_pos, y_pos].imshow(np.flipud(tf[channel,:,:]), cmap = 'jet', aspect = aspect_ratio, vmin = -max_diff, vmax = max_diff)
            else:
                ax[x_pos, y_pos].imshow(np.flipud(tf[channel,:,:]), cmap = 'jet', aspect = aspect_ratio, vmin = -max_diff, vmax = max_diff)
            
            
            if channel+1 == 32:
                cbar = fig.colorbar(im, ax = ax[:2, :], pad = 0.02)
                cbar.ax.tick_params(labelsize=50)
            
            if channel+1 == 63:
                cbar = fig.colorbar(im, ax = ax[3:, 5:13], shrink = .6, pad = 0.04)
                cbar.ax.tick_params(labelsize=50)

            
            
            #pos = np.linspace(0, len(frex)-1, 8).astype(int)
            #label = [str(int(i)) for i in frex[pos]]
            
            #pos   = []
            #label = []
            #for i in [2] + list(range(10, 121, 10)):       ######    <----------------------------------------------------------------- Check here for the freqeuncies
            #    label.append(str(i))
            #    pos.append(np.argmin(np.abs(frex-i)))
                
                
            n_ticks = 6
            ticks_pos = np.linspace(0, len(frex)-1, n_ticks).astype(int)
            ticks_labels = np.round(frex[np.linspace(0, len(frex)-1, n_ticks).astype(int)]).astype(int)

            if channel in [7, 8, 31, 16, 39, 40, 34, 45, 43, 58, 53, 61, 48, 60]:
                ax[x_pos, y_pos].set_ylabel('frequency (Hz)', fontsize = 30)
            ax[x_pos, y_pos].set_yticks(ticks_pos)
            ax[x_pos, y_pos].set_yticklabels(ticks_labels[::-1], fontsize = 30)



            ax[x_pos, y_pos].hlines(tf.shape[1] - data['limit_log_lin_index'][0][0][0][0], ax[x_pos, y_pos].get_xlim()[0], ax[x_pos, y_pos].get_xlim()[1], colors = 'k', linestyles = 'dotted', lw = 3)



            xticks = []
            for i in (np.arange(0, np.abs(cut1) + np.abs(cut2)+1,500) - cut1)/1000:
                if int(i) == i:
                    xticks.append(str(int(i)))
                else:
                    xticks.append(str("{0:.1f}".format(i)))


            ax[x_pos, y_pos].set_xlabel('time (s)', fontsize = 30)
            ax[x_pos, y_pos].set_xticks(np.arange(0, np.abs(cut1) + np.abs(cut2)+1, 500))
            ax[x_pos, y_pos].set_xticklabels(xticks, fontsize = 30)


            #ax[x_pos, y_pos].plot([2000-cut1,2000 - cut1], [0,n_lines-1], color = 'k', lw=3)   ## ploting the 0 vertical line 
            
            ax[x_pos, y_pos].plot([cut1, cut1], [0, n_lines-1], color = 'k', lw=3)

            
        ### Only plotting positions with a channel connected to them
        
        plot_it = [(5,3),(6,3),(7, 3),(10,3),(11,3),(12,3)]
        
        for figure_not in list(itertools.product(list(range(0, 18)), list(range(0, 8)))):
            if figure_not not in plot_it:
        
                if list(np.add(list(figure_not),1)) not in xy_dict.values():
                #if figure_not[1]== and figure_not[1]<7:
                #    ax[figure_not[1]-1, figure_not[0]].set_axis_off()
                #else:
             
                    ax[figure_not[1], figure_not[0]].set_axis_off()

    if save:
        plt.savefig(save_name, dpi = 150, transparent = False, facecolor='white', bbox_inches='tight')
        recenter_plot(save_name)

    if show:
        plt.show()
        



RAT = 397550

print('Starting topographical plotting of tf over the rat\'s brain: ')


print('  \nStimulus centered:')
print('     CS+ correct')
plot_tf_topographical('../Discrimination_397550/TF_csp_correct.mat',     bad_channels = [16, 37], cut = [1500, 1500], title = 'CS+ correct ; '  +str(RAT)+' ; Stimulus centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_csp_correct.png',   SPREAD = 3)

print('     CS- correct')
plot_tf_topographical('../Discrimination_397550/TF_csm_correct.mat',     bad_channels = [16, 37], cut = [1500, 1500], title = 'CS- correct ; '  +str(RAT)+' ; Stimulus centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_csm_correct.png',   SPREAD = 3)

print('     CS- incorrect')
plot_tf_topographical('../Discrimination_397550/TF_csm_incorrect.mat',   bad_channels = [16, 37], cut = [1500, 1500], title = 'CS- incorrect ; '+str(RAT)+' ; Stimulus centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_csm_incorrect.png',   SPREAD = 3)


print('  \nReaction Time centered:')
print('     CS+ correct')
plot_tf_topographical('../Discrimination_397550/TF_CRT_csp_correct_baseline.mat',     bad_channels = [16, 37], cut = [1500, 1500], title = 'CS+ correct ; '  +str(RAT)+' ; Reaction Time centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_CRT_csp_correct.png',   SPREAD = 3)

print('     CS- correct')
plot_tf_topographical('../Discrimination_397550/TF_CRT_csm_correct_baseline.mat',     bad_channels = [16, 37], cut = [1500, 1500], title = 'CS- correct ; '  +str(RAT)+' ; Reaction Time centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_CRT_csm_correct.png',   SPREAD = 3)

print('     CS- incorrect')
plot_tf_topographical('../Discrimination_397550/TF_CRT_csm_incorrect_baseline.mat',   bad_channels = [16, 37], cut = [1500, 1500], title = 'CS- incorrect ; '+str(RAT)+' ; Reaction Time centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_CRT_csm_incorrect.png',   SPREAD = 3)

print('  \nMovement Time centered:')
print('     CS+ correct')
plot_tf_topographical('../Discrimination_397550/TF_CMT_csp_correct_baseline.mat',     bad_channels = [16, 37], cut = [1500, 1500], title = 'CS+ correct ; '+str(RAT)+' ; Movement Time centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_CMT_csp_correct.png',   SPREAD = 3)

print('     CS- correct')
plot_tf_topographical('../Discrimination_397550/TF_CMT_csm_correct_baseline.mat',     bad_channels = [16, 37], cut = [1500, 1500], title = 'CS- correct ; '+str(RAT)+' ; Movement Time centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_CMT_csm_correct.png',   SPREAD = 3)

print('     CS- incorrect')
plot_tf_topographical('../Discrimination_397550/TF_CMT_csm_incorrect_baseline.mat',   bad_channels = [16, 37], cut = [1500, 1500], title = 'CS- incorrect ; '+str(RAT)+' ; Movement Time centered',      show = 0, save = 1, save_name = '../Discrimination_397550/TF_'+str(RAT)+'_CMT_csm_incorrect.png',   SPREAD = 3)