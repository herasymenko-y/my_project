#include <stdio.h>
#include <time.h>
#include <sys/utsname.h>
#include <string.h>


int main(int argc, char *argv[]) {

struct utsname info;

  if (uname(&info) != 0) {
  printf("Error");
  return 1;
  }

time_t curr_time = time(NULL);
struct tm *local_time = localtime (&curr_time);
char form_time[20];

strftime(form_time, sizeof(form_time), "%Y-%m-%d %H:%M:%S", local_time);

  if (argc < 2) {
  printf ("====  Information about device  ====\n");
  printf (" Hostname  : %s\n", info.nodename);
  printf ("Current time : %s\n", form_time);
  printf ("OS : %s\n", info.sysname);
  printf ("Hardware platform : %s\n", info.machine);
  printf("=============================================\n");
  } else {
  FILE *check_file = fopen(argv[1], "r");
    if (check_file != NULL) {
        printf("Warning : The file already exists, new information will be        appended to the end.\n");
        fclose(check_file); 
      }
 
check_file = fopen(argv[1], "a");
        if (check_file == NULL) {
        return 0;
        }
  fprintf (check_file, "====  Information about device  ====\n");
  fprintf (check_file," Hostname  : %s\n", info.nodename);
  fprintf (check_file,"Current time : %s\n", form_time);
  fprintf (check_file,"OS : %s\n", info.sysname);
  fprintf (check_file,"Hardware platform : %s\n", info.machine);
  fprintf(check_file,"=============================================\n");
  fclose(check_file);
  }
}


