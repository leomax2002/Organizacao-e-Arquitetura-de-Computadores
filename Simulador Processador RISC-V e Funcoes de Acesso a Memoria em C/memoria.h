#ifndef MEMORIA_H_INCLUDED
#define MEMORIA_H_INCLUDED

#include <stdint.h>
#include <stdio.h>

#define MEM_SIZE 4096

int32_t mem[MEM_SIZE];

int32_t lw(uint32_t address, int32_t kte) {
  int32_t endereco = address + kte;
  if (endereco % 4 == 0) {
    int32_t indice_mem = endereco / 4;
    return mem[indice_mem];
  }
  else {
    return 0;
  }
}

int32_t lb(uint32_t address, int32_t kte) {
  int8_t *byte = (int8_t *)mem + (address + kte);
  int32_t byte_expandido = (int32_t)*byte;

  return byte_expandido;
}

int32_t lbu(uint32_t address, int32_t kte) {
  uint8_t *byte = (uint8_t *)mem + (address + kte);
  int32_t byte_expandido = (int32_t)*byte & 0x000000FF;
  return byte_expandido;
}

void sw(uint32_t address, int32_t kte, int32_t dado) {
  if ((address + kte) % 4 == 0) {
    int32_t endereco = (address + kte) / 4;
    mem[endereco] = dado;
  }
  else {
    printf("Address nao e multiplo de 4\n");
  }
}

void sb(uint32_t address, int32_t kte, int8_t dado) {

  int8_t *byte = (int8_t *)mem + (address + kte);
  *byte = dado;
}

#endif // MEMORIA_H_INCLUDED
