#include <iostream>

class DateClass
{
private:
  int m_year;
  int m_month;
  int m_day;

public:
  DateClass(int year, int month, int day = 1)
    : m_year(year), m_month(month), m_day(day) // directly initialize private member variables using constructor arguments
  {
    // No need for assignment here
  }

  void print()
  {
    std::cout << m_year << "/" << m_month << "/" << m_day << std::endl;
  }
};

int main()
{
  DateClass today(2018, 5);
  today.print();
  return 0;
}
