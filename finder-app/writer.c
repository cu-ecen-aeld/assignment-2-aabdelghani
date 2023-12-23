#include <stdio.h>   // Include standard input/output header for file operations
#include <stdlib.h>  // Include standard library header for general utilities
#include <string.h>  // Include string header for string handling operations
#include <syslog.h>  // Include syslog header for logging system messages

int main(int argc, char *argv[]) {
    FILE *fp;          // Declare a file pointer for file operations
    const char *writefile; // Pointer to store the file path argument
    const char *writestr;  // Pointer to store the string to be written

    // Open syslog connection with specific settings
    openlog("writer", LOG_PID|LOG_CONS, LOG_USER);

    // Check if the correct number of arguments is provided (3, including the program name)
    if (argc != 3) {
        syslog(LOG_ERR, "Error: Two arguments are required.");
        fprintf(stderr, "Usage: %s <path-to-file> <text-string>\n", argv[0]);
        closelog(); // Close the syslog connection
        return 1;   // Exit with an error code
    }

    // Assigning command line arguments to variables
    writefile = argv[1]; // The file path
    writestr = argv[2];  // The string to be written

    // Log the action of writing to a file
    syslog(LOG_DEBUG, "Writing '%s' to '%s'", writestr, writefile);

    // Attempt to open the file for writing
    fp = fopen(writefile, "w");
    if (fp == NULL) {
        // If file opening fails, log an error and print it
        syslog(LOG_ERR, "Error: Failed to open file %s for writing.", writefile);
        perror("Error");
        closelog(); // Close the syslog connection
        return 1;   // Exit with an error code
    }

    // Write the string to the file
    if (fputs(writestr, fp) == EOF) {
        // If writing fails, log an error and print it
        syslog(LOG_ERR, "Error: Failed to write to file %s.", writefile);
        perror("Error");
        fclose(fp); // Close the file
        closelog(); // Close the syslog connection
        return 1;   // Exit with an error code
    }

    // Close the file and syslog connection, then exit successfully
    fclose(fp);
    closelog();
    return 0;
}

