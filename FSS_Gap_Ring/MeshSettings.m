function []=MeshSettings(MWS)
MESHSETTINGS = invoke(MWS, 'MeshSettings');
invoke(MESHSETTINGS,'SetMeshType','Tet');
invoke(MESHSETTINGS,'Set','version','1%');
release(MESHSETTINGS);
end