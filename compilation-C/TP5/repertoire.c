#include <stdio.h>
#include "repertoire.h"
#include <sys/types.h>
#include <dirent.h>
#include <unistd.h>
#include <stdlib.h>









void lire_dossier()
{
    DIR *dirp = opendir(argv[1]);
    if (dirp == NULL) 
        {
        perror("opendir");
        return(EXIT_FAILURE);
        }
    struct dirent * ent;
    while(1) 
        {
        ent = readdir(dirp);
        if (ent == NULL) 
            {
            break;
            }
        printf("%s\n", ent->d_name);
        }
    closedir(dirp);
}