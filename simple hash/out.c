#include <stdio.h>

enum {amount=8};

int main(void) {
	char *passwords[amount] = {"Get_it_done","Count_money","Paperwork","Hello_there","Lot_smell","Too_dark","Pack_it","Fine_touch"};
	for (int i = 0; i < amount; ++i) {
		printf("%s\n", passwords[i]);	
	}
	return 0;
}
