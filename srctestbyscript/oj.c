#include <stdio.h>

#include "run.h"

int main()
{
	const char *name_program = "./program";
	const char *name_in = "./in.txt";
	const char *name_out = "./out.txt";
	const char *name_right = "./right.txt";
	run(name_program, name_in, name_out);
	FILE *fpright = fopen(name_right, "r");
	FILE *fpout = fopen(name_out, "r");

	// Input your code here.
    char c_right, c_out, c_tmp;
    int ret_right, ret_out, ret_tmp;
    int flag = 1;
    while (flag) {
        ret_right = fscanf(fpright, "%c", &c_right);
        ret_out = fscanf(fpout, "%c", &c_out);
        if (ret_right == EOF || ret_out == EOF) break;
        if (c_right != c_out) flag = 0;
    }
    
    if (flag == 1) {
        if (ret_right != EOF || ret_out != EOF) {
            if ((ret_right != EOF && c_right == '\n') || (ret_out != EOF && c_out == '\n')) {
                ret_tmp = fscanf(ret_out != EOF ? fpout : fpright, "%c", &c_tmp);
                flag = (ret_tmp == EOF ? 1 : 0);
            } else {
                flag = 0;
            }
        }
    }
    
    if (flag) {
        printf("Accept");
    } else {
        printf("Wrong Answer");
    }

	fclose(fpout);
	fclose(fpright);
	return 0;
}
