#include "ej1.h"

list_t* listNew(){
  list_t* l = (list_t*) malloc(sizeof(list_t));
  l->first=NULL;
  l->last=NULL;
  return l;
}

void listAddLast(list_t* pList, pago_t* data){
    listElem_t* new_elem= (listElem_t*) malloc(sizeof(listElem_t));
    new_elem->data=data;
    new_elem->next=NULL;
    new_elem->prev=NULL;
    if(pList->first==NULL){
        pList->first=new_elem;
        pList->last=new_elem;
    } else {
        pList->last->next=new_elem;
        new_elem->prev=pList->last;
        pList->last=new_elem;
    }
}


void listDelete(list_t* pList){
    listElem_t* actual= (pList->first);
    listElem_t* next;
    while(actual != NULL){
        next=actual->next;
        free(actual);
        actual=next;
    }
    free(pList);
}

uint8_t contar_pagos_aprobados(list_t* pList, char* usuario){
    uint8_t res = 0;
    
    listElem_t* actual = pList->first;
    while(actual != pList->last->next){
        if (actual->data->aprobado == 1 && strcmp(actual->data->cobrador, usuario) == 0){
            res ++;
         }
        actual = actual->next;
    }
    return res;

}

uint8_t contar_pagos_rechazados(list_t* pList, char* usuario){
    uint8_t res = 0;
    
    listElem_t* actual = pList->first;
    while(actual != pList->last->next){
        if (actual->data->aprobado == 0 && strcmp(actual->data->cobrador, usuario) == 0){
            res ++;
         }
        actual = actual->next;
    }
    return res;
}

pagoSplitted_t* split_pagos_usuario(list_t* pList, char* usuario){
    uint8_t size_Aprobados = 0;
    uint8_t size_Rechazados = 0;

    size_Aprobados = contar_pagos_aprobados(pList, usuario);
    size_Rechazados = contar_pagos_rechazados(pList, usuario);


    pago_t** listaAprobados = malloc(8* size_Aprobados);
    pago_t** listaRechazados = malloc(8* size_Rechazados);
    
    pagoSplitted_t* res = malloc (sizeof(pagoSplitted_t));
    res->cant_aprobados = size_Aprobados;
    res->cant_rechazados = size_Rechazados;
    res->aprobados = listaAprobados;
    res->rechazados = listaRechazados;

    int i = 0;
    int j = 0;
    listElem_t* actual = pList->first;
     while(actual != pList->last->next){
        
        if (actual->data->aprobado == 1 && strcmp(actual->data->cobrador, usuario) == 0){
            listaAprobados[i] = actual->data;
            i++;
         }else if (actual->data->aprobado == 1 && strcmp(actual->data->cobrador, usuario) == 0)
         {
           listaRechazados[j] = actual->data;
            j++;
         }
         
        actual = actual->next;
    }



    return res;
}