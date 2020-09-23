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
            IExpAddressList3 stationList = navi.GetStationListFromCoordinates(35, 32, 26, 7800, 139, 46, 4, 8400);

            // Print result
            Console.WriteLine("{0}", stationList.Name[1]);
            // => station traffic type is highwaybus

            // ========== ========== ========== ========== ==========

            // Set traffic
            IExpAddressNavi3_A1 exNavi = (IExpAddressNavi3_A1)navi;
            exNavi.Traffic = 1;

            // Search Point
            IExpAddressList3 exStationList = navi.GetStationListFromCoordinates(35, 32, 26, 7800, 139, 46, 4, 8400);

            // Print result
            Console.WriteLine("{0}", exStationList.Name[1]);
            // => station traffic type is rail

            Console.ReadLine();
        }
    }
}
