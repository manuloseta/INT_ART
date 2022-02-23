from node import Node

if __name__ == '__main__':

    def lowest(list):
        i,j,k = 0,1,len(list)
        while(j < k):
            if(list[i] > list[j]):
                i = j
            j += 1
        return i

    a = Node((1,1), None, None)
    b = Node((1,2), a, 9)
    c = Node((1,3), ['s','w','e'], 3)
    d = [1,1,1]
    e = [2,3,4,1,0,9,8,7]
    
    print(Node.getState(c))
    # print(Node.getParent(c))
    print(Node.getOperators(c))
    # print(Node.getCost(c))
    # print(Node.getCumulative(c))
    print(lowest(e))
