; Script to plot Delft3D Bathymetry using NCL. Before running this script, some pre-processing of Delft3D outputs needed to be done.
; a)Extract data i.e. water depth in .mat format for a single timestep and convert that to .nc using mat2nc.m script.
; b)Then execute the NCL script and you'll get the desired output.
; Delft3D outputs are usually in NEFIS format (a type of binary file) 
; This processes helps to process those NEFIS in to NCL readable NC file.
; Thanks to Professor Shaowu Bao for helping me with this. 
; Any question can be forwarded to Mansur Ali Jisan <mjisan@g.coastal.edu> 
; Good Luck!

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin

  wks = gsn_open_wks("png","pdaysl1")  ; Open graphics file
  gsn_define_colormap(wks,"GMT_topo")

  f = addfile("depth_ini.nc", "r")
;  g = addfile("flatslope.nc","r")

  var1 =f->depth
  lat1 =f->lat
  lon1 =f->lon

  depth1d=ndtooned(var1)
  lat1d=ndtooned(lat1)
  lon1d=ndtooned(lon1)

  
  lat=fspan(20.5,24.0,300)
  lon=fspan(87.0,92.0,500)
  lat2d=new((/300,500/),"float")
  lon2d=new((/300,500/),"float")
  
  do i=0,299
    lon2d(i,:)=lon
  end do
  do i=0,499
    lat2d(:,i)=lat
  end do
  depth=triple2grid(lon1d,lat1d,depth1d,lon,lat,False)
  depth@lat2d=lat2d
  depth@lon2d=lon2d


  res                 = True

plt_res=res
plt_res=True
plt_res@cnFillOn        = True
plt_res@cnLinesOn       = False
plt_res@gsnMaximize  = True               ; Maximize size of plot
plt_res@tiMainString    = "Topography and Bathymetry"
plt_res@gsnSpreadColors = True
plt_res@lbLabelBarOn =True;
plt_res@lbLabelFontHeightF =.015                 ; make labels larger
plt_res@pmLabelBarSide = "Bottom"
plt_res@lbOrientation  = "Horizontal"
plt_res@lbLabelAutoStride = True 
plt_res@lbTitleOn        = True    

plt_res@pmTickMarkDisplayMode = "Always"
plt_res@lbTitlePosition = "Bottom"


plt_res@lbTitleString="depth (meter)"
plt_res@cnLevelSelectionMode        = "ManualLevels"   ; set manual contour levels
plt_res@cnMinLevelValF              = -100
plt_res@cnMaxLevelValF              = 100               ; set max contour level
plt_res@cnLevelSpacingF             = 5             ; contour spacing
plt_res@mpMinLatF = min(lat2d)
plt_res@mpMaxLatF = max(lat2d)
plt_res@mpMinLonF = min(lon2d)
plt_res@mpMaxLonF = max(lon2d)
plt_res@mpDataBaseVersion    = "HighRes"


plot2 = gsn_csm_contour_map_ce(wks,depth,plt_res)



draw(plot)
frame(wks)

end 