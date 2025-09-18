#include <stdio.h>
#include <stdlib.h>
#include "type.h"

fat32_t* new_fat32() {
    fat32_t *data = malloc(sizeof(fat32_t));
    return data;
}

ext4_t* new_ext4() {
    ext4_t *data = malloc(sizeof(ext4_t));
    return data;
}

ntfs_t* new_ntfs() {
    ntfs_t *data = malloc(sizeof(ntfs_t));
    return data;
}

fat32_t* copy_fat32(fat32_t* file) {
    fat32_t *data = malloc(sizeof(fat32_t));
    *data = *file;
    return data;
}

ext4_t* copy_ext4(ext4_t* file) {
    ext4_t *data = malloc(sizeof(ext4_t));
    *data = *file;
    return data;
}

ntfs_t* copy_ntfs(ntfs_t* file) {
    ntfs_t *data = malloc(sizeof(ntfs_t));
    *data = *file;
    return data;
}

void rm_fat32(fat32_t* file) {
    free(file);
}

void rm_ext4(ext4_t* file) {
    free(file);
}

void rm_ntfs(ntfs_t* file) {
    free(file);
}