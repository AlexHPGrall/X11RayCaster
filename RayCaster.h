#ifndef RAYCASTER_H
#define RAYCASTER_H
#define CellSize 64

typedef struct{
	int rows;
	int columns;
	//Debug hack
	uint8_t layout[8*16];
}Map;

Map gameMap = {8,16,
		   {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		    1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,
		    1,0,0,1,0,0,1,1,1,0,0,1,0,0,0,1,
		    1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,
		    1,0,0,0,1,1,1,0,1,0,0,0,0,1,0,1,
		    1,0,1,1,0,0,0,0,0,0,1,1,0,0,0,1,
		    1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
		    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};

typedef struct{
	float xpos, ypos, angle, velocity, rotspeed;
}EntityState;
typedef struct RayInfo
{
	float dist;
	int offset;
	int side;
}RayInfo;


#endif
