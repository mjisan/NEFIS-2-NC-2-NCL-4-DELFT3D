# NEFIS-2-NC-2-NCL-4-DELFT3D
; Script to plot Delft3D Bathymetry using NCL. Before running this script, some pre-processing of Delft3D outputs needed to be done.
; a)Extract data i.e. water depth in .mat format for a single timestep and convert that to .nc using mat2nc.m script.
; b)Then execute the NCL script and you'll get the desired output.
; Delft3D outputs are usually in NEFIS format (a type of binary file)
; This processes helps to process those NEFIS in to NCL readable NC file.
; Thanks to Professor Shaowu Bao for helping me with this.
; Any question can be forwarded to Mansur Ali Jisan <mjisan@g.coastal.edu>
; Good Luck!
