/*
You have a graph of n nodes labeled from 0 to n - 1. You are given an integer n and a list of edges where edges[i] = [ai, bi] indicates that there is an undirected edge between nodes ai and bi in the graph.

Return true if the edges of the given graph make up a valid tree, and false otherwise.

Valid Tree Properties
- Single connected component
- Acyclic
*/

enum NodeState {
    case unprocessed
    case processing
    case processed
}

func validTree(_ n: Int, _ edges: [[Int]]) -> Bool {
    var adjList: [[Int]] = Array(repeating: [], count: n)
    var visited: Set<Int> = []
    var state: [NodeState] = Array(repeating: .unprocessed, count: n)
    var parent: [Int] = Array(repeating: -1, count: n)
    var numberOfComponents = 0

    for edge in edges {
        let v = edge[0], u = edge[1]
        adjList[v].append(u)
        adjList[u].append(v)
    }

    func dfs(_ root: Int) -> Bool {
        visited.insert(root)
        state[root] = .processing

        for neighbor in adjList[root] {
            if !visited.contains(neighbor) {
                parent[neighbor] = root
                dfs(neighbor)
            } else if state[neighbor] == .processing, neighbor != parent[root] {
                return false
            }
        }

        state[root] = .processed

        return true
    }

    for v in 0..<n {
        if !visited.contains(v) {
            if !dfs(v) { return false }
            numberOfComponents += 1
            if numberOfComponents > 1 {
                return false
            }
        }
    }
    
    return true
}