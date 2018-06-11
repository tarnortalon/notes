#include <iostream>

struct DateStruct
{
  int year;
  int month;
  int day;
};

void print(DateStruct &ds) {
  std::cout << ds.year << "/" << ds.month << "/" << ds.day << std::endl;
}

int main()
{
  DateStruct today { 2018, 5, 30 };
  print(today);
  return 0;
}
