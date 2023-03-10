classdef Inputs
    properties (Access = private)
        mesh
        boundaries
        material
        nDOFnode
        solverType
    end

    methods (Access = public)
        function obj = Inputs(cParams)
           obj = obj.init(cParams);
        end
        % Getters
        function conn = getNodesConnectivity(obj)
            conn = obj.mesh.conn;
        end
        
        function coord = getCoords(obj)
            coord = obj.mesh.coord;
        end

        function nel = getTotalNumberElements(obj)
            nel = obj.mesh.nel;
        end

        function coord = getTotalNumberNodes(obj)
            coord = obj.mesh.nnodes;
        end

        function fixNod = getDirichletBC(obj)
            fixNod = obj.boundaries.Dirichlet;
        end

        function Fdata = getNeumannBC(obj)
            Fdata = obj.boundaries.ForceData;
        end

        function mat = getMatProperties(obj)
            mat = obj.material.properties;
        end

        function Tmat = getMatConnectivity(obj)
            Tmat = obj.material.conn;
        end

        function nDOFnode = getDOFperNode(obj)
            nDOFnode = obj.nDOFnode;
        end

        function type = getType(obj)
            type = obj.solverType;
        end
    end

    methods (Access = private)
        function obj = init(obj,cParams)
            mesh.coord = cParams.coord;
            mesh.conn = cParams.Tnod;
            mesh.nel = size(mesh.conn,1); 
            mesh.nnodes = size(mesh.coord,1); 
            BC.Dirichlet = cParams.fixNod;
            BC.ForceData = cParams.Fdata;
            mat.conn = cParams.Tmat;
            mat.properties = cParams.mat;
            
            obj.mesh = mesh;
            obj.boundaries = BC;
            obj.material = mat;
            obj.nDOFnode = cParams.nDOFnode;
            obj.solverType = cParams.type;
        end
    end
end