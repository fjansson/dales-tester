#!/usr/bin/python

import matplotlib.pyplot as plt
from netCDF4 import Dataset
import numpy as np
import glob
import os

# data is expected to be organized as case_dir/run_id/tmser.001.nc 

experiment_dir = './'     # base directory for the dales data
case_dirs = ['rico-4.2.1-gnu-fast', 'rico-4.3-rc.1-gnu-fast']
colors = ['r', 'b']

# tmser variables to plot
variables = ['cfrac', 'zb', 'zi', 'lwp_bar', 'vtke', 'obukh', 'wtheta', 'wthetav', 'wq', 'ustar']

# time cfrac zb zc_av zc_max zi we lwp_bar lwp_max wmax vtke lmax ustar tstr
# qtstr obukh thlskin z0 wtheta wthetav wq

# thlskin, z0 are constant over time in RICO


unit = {
    'cfrac'   : '',
    'zb'      : 'm',
    'zi'      : 'm',
    'lwp_bar' : 'kg/m^2',
    'vtke'    : 'kg/s',
    'obukh'   : 'm',
    'z0'      : 'm',
    'wtheta'  : 'K m/s',
    'wq'      : 'kg/kg m/s',
    'ustar'   : 'm/s',
    'thlskin' : 'K',
    'wthetav' : 'K m/s',
}


mplparams = {"figure.figsize" : [6, 6],  # figure size in inches
             "figure.dpi"     :  150,      # figure dots per inch
             "font.size"      :  8,        # this one acutally changes tick labels
             'svg.fonttype'   : 'none',   # plot text as text - not paths or clones or other nonsense
             'axes.linewidth' : 1, 
             'xtick.major.width' : 1,
             'ytick.major.width' : 1,
             'font.family' : 'sans-serif',
             'font.sans-serif' : ['PT Sans'],
             # mathmode font not yet set !
             }
plt.rcParams.update(mplparams)


# Open tmser netCDF files
tmser = {} # tmser[case][run_id] is a netcdf object
for d in case_dirs:
    run_dirs = sorted(glob.glob(os.path.join(experiment_dir, d, '[0-9]*')))
    tmser[d] = {}
    for r in run_dirs:
        ri = int(os.path.split(r)[-1]) # extract run number from path
        tmser[d][ri] = Dataset(os.path.join(r,'tmser.001.nc'), 'r') 

# returns a numpy array of all runs in a case
def load_runs(case, var):
    runs = []
    for run in case:
        nc = case[run]
        data = nc[var][:]
        runs.append(data)
    runs = np.array(runs)
    runs[runs==-999.0] = 0   # hack: set missing values to 0
    return runs

var = 'obukh'

def plot_var(ax, var):
    for case,col in zip(tmser, colors):
        time = load_runs(tmser[case], 'time')
        cfrac = load_runs(tmser[case], var)
        #for t,c in zip(time,cfrac): # individual runs
        #    plt.plot(t, c, col)
        low   = np.amin(cfrac, axis=0)
        high  = np.amax(cfrac, axis=0)
        mean  = np.mean(cfrac, axis=0)
        std   = np.std(cfrac, axis=0)
        low2  = mean-std
        high2 = mean+std
        t = time[0] / 3600
        ax.fill_between(t, low, high, color=col, alpha=.1, lw=0)
        ax.fill_between(t, low2, high2, color=col, alpha=.3, lw=0)
        ax.plot(t, mean, col, label=case)
        u = unit.get(var,'')
        u = f'({u})' if u else ''
        ax.set(ylabel=f'{var} {u}')
        
        ax.spines['top'].set_visible(False)
        ax.spines['right'].set_visible(False)
        ax.patch.set_visible(False) # remove background rectangle?
        #if not ax.is_last_row():
        plt.xlabel('time (h)')
        
fig, axes = plt.subplots(nrows=5, ncols=2, sharex=True)
for ax,var in zip(axes.flatten(), variables):
    plot_var(ax, var)
plt.legend(bbox_to_anchor=(1, 1),
           bbox_transform=plt.gcf().transFigure)

plt.subplots_adjust(left=.1, top=.99, bottom=.08, right=.99, wspace=.2, hspace=.15)
plt.savefig('rico.png')
plt.show()


# TODO
# extract run time - save it in the run directory, in a file?
# extract precip
# plot profiles too - averaged over last x hours?
# DALES: why is cfrac a missing value when 0 ?
#
# ruisdael testcase doesn't work with < 4.3 due to nudge and uv tendencies
# no standard case uses rrtmg
#
# rico case now has iadv_sv = 7 - meaning 7,2 !
