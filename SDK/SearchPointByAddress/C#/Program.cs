using System;
using EXPADNAVLib;

namespace SearchPointByAddress
{
    class Program
    {
        static void Main(string[] args)
        {
            // Initialize ekispert
            ExpAddressNavi3 navi = new ExpAddressNavi3();
            navi.SelectType = 3;
            navi.Distance = 60;

            // Search Point
            IExpAddressList3 station = navi.GetStationFromCoordinates(35, 38, 10, 9600, 139, 15, 00, 8000);

            // Print result
            Console.WriteLine("{0}", station.Name[1]);

            // Search Point
            IExpAddressList3 stationList = navi.GetStationListFromCoordinates(35, 38, 10, 9600, 139, 15, 00, 8000);

            // Print result
            Console.WriteLine("{0}", stationList.Name[1]);
            Console.ReadLine();
        }
    }
}
