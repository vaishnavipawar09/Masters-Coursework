import pandas as pd
import networkx as nx
import pygraphviz as pgv

# Load the CSV file into a DataFrame
data = pd.read_csv("result.csv")

# Create a directed graph
G = nx.DiGraph()

# Add nodes and edges to the graph based on the hierarchical relationships
for _, row in data.iterrows():
    G.add_edge(row['str'], row['pstr'])

# Convert the NetworkX graph to a pygraphviz graph
A = nx.nx_agraph.to_agraph(G)

# Set layout options
A.layout('dot', args='-Nfontsize=10 -Nwidth=".2" -Nheight=".2" -Nmargin=0 -Gfontsize=8')

# Draw the graph and save it to a file
A.draw('alzheimers_hierarchy.png')
