#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <uv.h>

uv_loop_t *loop;

void socket_accept_cb(uv_stream_t *server, int status) {
  fprintf(stdout, "New connection\n");  
  uv_tcp_t *client = (uv_tcp_t*)malloc(sizeof(uv_tcp_t));
  uv_tcp_init(loop, client);
  uv_accept(server, (uv_stream_t*)client);
  uv_close((uv_handle_t*) client, NULL);
}

int main () {
  loop = uv_default_loop();
  uv_tcp_t server;
  uv_tcp_init(loop, &server);
  struct sockaddr_in addr;
  uv_ip4_addr("0.0.0.0", 4334, &addr);
  uv_tcp_bind(&server, (const struct sockaddr*)&addr, 0);
  int r = uv_listen((uv_stream_t*)&server, 128, socket_accept_cb);
  fprintf(stdout, "R: %s\n", uv_strerror(r));
  return uv_run(loop, UV_RUN_DEFAULT);
}

