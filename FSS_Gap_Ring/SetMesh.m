function []=SetMesh(MWS)
MESH = invoke(MWS, 'Mesh');
invoke(MESH, 'MeshType', 'Tetrahedral');
invoke(MESH, 'SetCreator', 'High Frequency');
release(MESH);
end