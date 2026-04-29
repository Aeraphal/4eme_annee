#include <stdio.h>

int factorielle (int num)
{
    if (num ==0)
    {
        return 1;
    }
    else
    {
        return (num * factorielle(num-1));
    }
}

int main()
{
    printf("%d\n",factorielle(5));
}