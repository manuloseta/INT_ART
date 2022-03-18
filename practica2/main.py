import G2351_p2_01_Hernández_LópezSerrano
from G2351_p2_01_Hernández_LópezSerrano import Solution3, Solution4, Solution5

if __name__ == '__main__':
    for i in list(range(1,9)):
        print('|', Solution3.sector(Solution3,(i,1)), '|', Solution3.sector(Solution3,(i,2)), '|', Solution3.sector(Solution3,(i,3)), '|', Solution3.sector(Solution3,(i,4)), '|', Solution3.sector(Solution3,(i,5)), '|', Solution3.sector(Solution3,(i,6)), '|', Solution3.sector(Solution3,(i,7)), '|', Solution3.sector(Solution3,(i,8)), '|')
        print('----------------------------------')
    print('#################################')
    for i in list(range(1,9)):
        print('|', Solution4.sector(Solution4,(i,1)), '|', Solution4.sector(Solution4,(i,2)), '|', Solution4.sector(Solution4,(i,3)), '|', Solution4.sector(Solution4,(i,4)), '|', Solution4.sector(Solution4,(i,5)), '|', Solution4.sector(Solution4,(i,6)), '|', Solution4.sector(Solution4,(i,7)), '|', Solution4.sector(Solution4,(i,8)), '|')
        print('----------------------------------')
    tiles=[(1,1),(8,8),(1,3),(4,5)]
    for tile in tiles:
        print(tile,Solution5.tiles_around(Solution5,tile))
