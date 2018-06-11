#include <iostream>

class DateClass
{
private:
  int year;
  int month;
  int day;

public:
  DateClass() : year(2018), month(5), day(30) // directly initialize private member variables
  {
    // No need for assignment here
  }

  void print()
  {
    std::cout << year << "/" << month << "/" << day << std::endl;
  }
};

int main()
{
  DateClass today;
  today.print();
  return 0;
}
