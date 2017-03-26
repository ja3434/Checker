#include <iostream>
#include <cstdlib>
#include <iomanip>
#include <Windows.h>
using namespace std;
const int L=100;

int main()
{
    long long Srednia=0;
    cout<<fixed<<setprecision(2);
    
    bool b=0;
    for(int i=0;!b&&i<L;i++)
    {

        system("GEN.exe > test.in");
        system("BRUT.exe < test.in > brut.out");
        long long start=GetTickCount();
        system("WZOR.exe < test.in > wzor.out");
        long long end=GetTickCount();

        if(system("fc brut.out wzor.out > ruzn.txt"))
        {
            cout<<" BLAD\n";
            b=1;

        }
        else
        {
            Srednia+=(end-start);
            cout<<" TEST "<<i+1;
            if(i+1<1000)
                cout<<' ';
            if(i+1<100)
                cout<<' ';
            if(i+1<10)
                cout<<' ';
            cout<<" OK  | Czas: "<<(double)((end-start)/10)/(double)100<<"   |\n";
        }
    }
    if(!b)
    {
    cout<<"\n///////////////////////////////\n";
    cout<<" WSZYSTKO  OK  | Srednia: "<<(double)((int)((double)(Srednia)/(L))/10)/(double)100<<'\n';
    }
    system("pause");
    return 0;
}
