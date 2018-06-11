#include <iostream>

class DateClass
{
public:
  int m_year;
  int m_month;
  int m_day;
};

int main()
{
  DateClass today;
  std::cout << today.m_year << "/" << today.m_month << "/" << today.m_day << std::endl;
  return 0;
};
