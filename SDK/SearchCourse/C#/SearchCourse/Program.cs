// Search Course and Print Result Sample.
//
// ---- Route 1 ----
// 10:02 PointA
//  | Line
// 10:23 PointB
//
// ---- Route 2 ----
// 10:10 PointA
//  | Line
// 10:32 PointB
//
// ---- Route 3 ----
// 10:16 PointA
//  | LineA
// 10:37 PointB
//  | LineB
// 10:37 PointC

using System;
using EXPDENGNLib;

namespace SearchCourse
{
    class Program
    {
        static void Main(string[] args)
        {
            // Initialize ekispert
            ExpDiaDB10 db = new ExpDiaDB10();
            ExpDiaNavi6 navi = db.CreateNavi6();
            navi.RemoveAllKey();
            navi.AddKey("東京");
            navi.AddKey("高円寺");
            navi.Time = 1000;

            // Search course
            ExpDiaCourseSet10 courseSet = db.SearchCourse10(navi);

            // Print Result
            const short DEPERTURE = 1;
            const short ARRIVAL = 2;
            for (int routeIndex = 1; routeIndex <= courseSet.CourseCount; routeIndex++)
            {
                Console.WriteLine("\n---- Route {0} ----", routeIndex);
                ExpDiaCourse10 course = courseSet.GetCourse10(1, routeIndex);

                for (int i = 1; i <= course.RouteSectionCount; i++)
                {
                    ExpDiaRouteSection3 section = course.GetRouteSection3(i);
                    string depertureTime = section.TrainInfo.DisplayTime[DEPERTURE].ToString().Insert(2, ":");
                    string stationName = section.From.LongName;
                    string lineName = section.Line.LongName;
                    Console.WriteLine("{0} {1}", depertureTime, stationName);
                    Console.WriteLine(" | {0}", lineName);
                }
                ExpDiaRouteSection3 lastSection = course.GetRouteSection3(course.RouteSectionCount);
                string lastArrivalTime = lastSection.TrainInfo.DisplayTime[ARRIVAL].ToString().Insert(2, ":");
                string lastStationName = lastSection.To.LongName;
                Console.WriteLine("{0} {1}", lastArrivalTime, lastStationName);
            }
            Console.ReadLine();
        }
    }
}
