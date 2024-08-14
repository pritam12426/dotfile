#include <stdio.h>
#include <time.h>

int main() {
  // Initialize birthDate with Pritam's date of birth: April 12, 2007
  struct tm birthDate = { 0, 0, 0, 12, 4 - 1, 2007 - 1900 };  // 12 April 2007
  time_t now          = time(NULL);          // Get current time
  struct tm *currentDate = localtime(&now);  // Convert to local time structure

  // Initialize variables for the age calculation
  int years  = currentDate->tm_year - birthDate.tm_year;
  int months = currentDate->tm_mon - birthDate.tm_mon;
  int days   = currentDate->tm_mday - birthDate.tm_mday;

  // Adjust for negative values in days and months
  if (days < 0) {
    months -= 1;
    // Adjust days based on the number of days in the previous month
    currentDate->tm_mon -= 1;
    mktime(currentDate);  // Normalize the date
    days += currentDate->tm_mday;
  }
  if (months < 0) {
    years -= 1;
    months += 12;
  }

  // Calculate hours, minutes, and seconds
  int hours   = currentDate->tm_hour;
  int minutes = currentDate->tm_min;
  int seconds = currentDate->tm_sec;

  // Print the calculated age
  printf("Your Age from April 12, 2007:\n");
  printf("Years    %2d\n", years);
  printf("Months   %2d\n", months);
  printf("Days     %2d\n", days);
  printf("- - - - - -\n");
  printf("Hours    %2d\n", hours);
  printf("Minutes  %2d\n", minutes);
  printf("Seconds  %2d\n", seconds);

  return 0;
}
