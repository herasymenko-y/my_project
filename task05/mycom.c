#include <ctype.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>

volatile sig_atomic_t run = 1;

int uart_setup(const char *port) {
  int serial_port = open(port, O_RDWR | O_NOCTTY);

  if (serial_port < 0) {
    printf("Error1");
    return -1;
  }

  struct termios tty;

  if (tcgetattr(serial_port, &tty) != 0) {
    printf("Error2");
    return -1;
  }

  tty.c_cflag &= ~PARENB;
  tty.c_cflag |= CS8;
  tty.c_cflag |= (CREAD | CLOCAL);

  tty.c_lflag &= ~(ICANON | ECHO | ECHOE | ECHONL);

  tty.c_iflag &= ~(ICRNL | INLCR | IXON | IXOFF | IXANY);

  tty.c_oflag &= ~(OPOST);

  tty.c_cc[VTIME] = 0;
  tty.c_cc[VMIN] = 1;

  cfsetispeed(&tty, B115200);
  cfsetospeed(&tty, B115200);

  tcsetattr(serial_port, TCSANOW, &tty);
  return serial_port;
}

void catch_sig(int sig) { run = 0; }

int main(int argc, char *argv[]) {

  if (argc < 2) {
    printf("Error3");
    return -1;
  }

  signal(SIGINT, catch_sig);
  signal(SIGTERM, catch_sig);

  time_t start = time(NULL);

  char file[32];
  sprintf(file, "%ld.log", start);

  FILE *log_file = fopen(file, "w");
  if (log_file == NULL) {
    printf("Error4\n");
    return -1;
  }

  int fd = uart_setup(argv[1]);

  if (fd < 0) {
    printf("Port access error %s\n", argv[1]);
    fprintf(log_file, "[%ld] Port access error %s\n", time(NULL), argv[1]);

    fclose(log_file);
    return -1;
  }

  char buff[128];
  int index = 0;
  char b;

  while (run) {
    int bytes = read(fd, &b, 1);

    if (bytes > 0) {
      buff[index] = b;
      index++;

      if (index >= sizeof(buff)) {
        index = 0;
        continue;
      }

      if (index >= 2 && buff[index - 2] == '\r' && buff[index - 1] == '\n') {
        buff[index] = '\0';
        fprintf(log_file, "[%ld] received %s", time(NULL), buff);
        fflush(log_file);

        for (int i = 0; i < index - 2; i++) {

          if (islower(buff[i])) {
            buff[i] = toupper(buff[i]);
          } else if (isupper(buff[i])) {
            buff[i] = tolower(buff[i]);
          }
        }
        write(fd, buff, index);
        index = 0;
      }
    }
  }
  close(fd);
  fclose(log_file);
  return 0;
}
