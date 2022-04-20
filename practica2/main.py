import G2351_p2_01_Hernández_LópezSerrano
from G2351_DRAFT import Solution3, Solution4, Solution5

if __name__ == '__main__':
    print('#################################')
    for i in list(range(1,9)):
        print('|', Solution3.sector(Solution3,(i,1)), '|', Solution3.sector(Solution3,(i,2)), '|', Solution3.sector(Solution3,(i,3)), '|', Solution3.sector(Solution3,(i,4)), '|', Solution3.sector(Solution3,(i,5)), '|', Solution3.sector(Solution3,(i,6)), '|', Solution3.sector(Solution3,(i,7)), '|', Solution3.sector(Solution3,(i,8)), '|')
        print('----------------------------------')
    print('#################################')
    for i in list(range(1,9)):
        print('|', Solution4.sector(Solution4,(i,1)), '|', Solution4.sector(Solution4,(i,2)), '|', Solution4.sector(Solution4,(i,3)), '|', Solution4.sector(Solution4,(i,4)), '|', Solution4.sector(Solution4,(i,5)), '|', Solution4.sector(Solution4,(i,6)), '|', Solution4.sector(Solution4,(i,7)), '|', Solution4.sector(Solution4,(i,8)), '|')
        print('----------------------------------')
