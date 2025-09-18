#include <stdio.h>
#include <stdint.h>
#include "type.h"

typedef struct node {
    void* data;
    struct node* previous;
    struct node* next;
} node_t;
typedef struct list {
    type_t type;
    uint8_t size;
    node_t* first;
    node_t* last;
} list_t;

list_t* listNew(type_t t);
void listAddFirst(list_t* l, void* data); //copia el dato
void listAddLast(list_t* l, void* data);
void* listGet(list_t* l, uint8_t i); //se asume: i < l->size
void* listRemove(list_t* l, uint8_t i); //se asume: i < l->size
void listDelete(list_t* l);
void listSwap(list_t* l, node_t* node1, node_t* node2);