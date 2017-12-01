input_file= '54m.mat'
output_file='54m.nc'
status=system(['rm ',' ',output_file])
nx=1243
ny=866
data=load(input_file)
nccreate(output_file,'depth','Dimensions',{'r',ny,'c',nx},'Format','classic')
depth=data.data.Val;
ncwrite(output_file,'depth',depth)
X=data.data.X;
lon1=(X(1:ny,:)+X(2:ny+1,:))/2;
lon=(lon1(:,1:nx)+lon1(:,2:nx+1))/2;
Y=data.data.Y;
lat1=(Y(1:ny,:)+Y(2:ny+1,:))/2;
lat=(lat1(:,1:nx)+lat1(:,2:nx+1))/2;
nccreate(output_file,'lat','Dimensions',{'r',ny,'c',nx},'Format','classic')
nccreate(output_file,'lon','Dimensions',{'r',ny,'c',nx},'Format','classic')
ncwrite(output_file,'lat',lat)
ncwrite(output_file,'lon',lon)
