clear;
clc;

// STAR + RING + BUS HYBRID TOPOLOGY

NameOfNetwork = "Star-Ring-Bus Hybrid Topology";
NumberOfNodes = 25;

// EDGE CONNECTIONS

Star_Start = [1 1 1 1 1 1 1 1];
Star_End   = [2 3 4 5 6 7 8 9];

Ring_Start = [10 11 12 13 14 15 16 17 18];
Ring_End   = [11 12 13 14 15 16 17 18 10];

Bus_Start = [19 20 21 22 23 24];
Bus_End   = [20 21 22 23 24 25];

Hybrid_Start = [5 14 22];
Hybrid_End   = [10 19 15];

StartNodes = [Star_Start Ring_Start Bus_Start Hybrid_Start];
EndNodes   = [Star_End   Ring_End   Bus_End   Hybrid_End];
// NODE COORDINATES

Star_X = [300 200 300 400 200 400 250 350 300];
Star_Y = [600 650 700 650 550 550 700 700 500];

Ring_X = [600 650 700 750 700 650 600 550 600];
Ring_Y = [600 650 600 650 700 750 700 650 550];

Bus_X = [200 250 300 350 400 450 500];
Bus_Y = [300 300 300 300 300 300 300];

X = [Star_X Ring_X Bus_X];
Y = [Star_Y Ring_Y Bus_Y];


// CREATE GRAPH

g = NL_G_MakeGraph(NameOfNetwork, NumberOfNodes, ...
    StartNodes, EndNodes, X, Y);

// GRAPH 1: NUMBERED TOPOLOGY

NL_G_ShowGraphNE(g, 1);
xtitle("Hybrid Topology with Node & Edge Numbers", "X", "Y");


// GRAPH 2: NODE COLOURING

NodeColor = 5;        
BorderThickness = 8;
NodeDiameter = 28;
NodesList = 1:25;

[go1, f1] = NL_G_HighlightNodes(g, NodesList, ...
    NodeColor, BorderThickness, NodeDiameter, 2);

xtitle("Hybrid Topology - Node Coloring", "X", "Y");


// GRAPH 3: EDGE COLOURING

EdgeColor = 3;        // Green
EdgeWidth = 4;
EdgesList = 1:length(StartNodes);

[go2, f2] = NL_G_HighlightEdges(g, EdgesList, ...
    EdgeColor, EdgeWidth, 3);

xtitle("Hybrid Topology - Edge Coloring", "X", "Y");


// CONSOLE OUTPUTS

disp("------ EDGES PER NODE ------");

maxEdges = 0;
maxNode = 0;

for i = 1:NumberOfNodes
    e = NL_G_EdgesOfNode(g, i);
    cnt = length(e);
    disp("Node " + string(i) + " -> " + string(cnt) + " edges");

    if cnt > maxEdges then
        maxEdges = cnt;
        maxNode = i;
    end
end

disp("--------------------------------");
disp("Node with maximum edges:");
disp("Node " + string(maxNode) + ...
     " with " + string(maxEdges) + " edges");

[nNodes, nEdges] = NL_G_GraphSize(g);

disp("--------------------------------");
disp("Total number of nodes:");
disp(nNodes);

disp("Total number of edges:");
disp(nEdges);
