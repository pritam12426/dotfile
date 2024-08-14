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
        currentDate->tm_mon -= 1;
        mktime(currentDate);  // Normalize the date
        days += currentDate->tm_mday;
    }
    if (months < 0) {
        years -= 1;
        months += 12;
    }

    // Print the calculated age
    printf("Your Age from April 12, 2007:\n");
    printf("Years    %2d\n", years);
    printf("Months   %2d\n", months);
    printf("Days     %2d\n", days);
    printf("- - - - - -\n");

    // Calculate the time remaining until BCA completion (Assuming August 1, 2028)
    struct tm bcaCompletionDate = { 0, 0, 0, 1, 8 - 1, 2028 - 1900 }; // 1 August 2028
    double seconds_until_bca = difftime(mktime(&bcaCompletionDate), now);

    // Convert seconds to years, months, days
    int days_until_bca = (int)(seconds_until_bca / (60 * 60 * 24));
    int years_until_bca = days_until_bca / 365;
    days_until_bca %= 365;
    int months_until_bca = days_until_bca / 30;
    days_until_bca %= 30;

    // Print the time remaining until BCA completion
    printf("Days are left\n");
    printf("Years    %2d\n", years_until_bca);
    printf("Months   %2d\n", months_until_bca);
    printf("Days     %2d\n", days_until_bca);

    return 0;
}
