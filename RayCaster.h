#ifndef RAYCASTER_H
#define RAYCASTER_H
#define CellSize 64 

typedef int64_t i64;
typedef uint64_t u64;
typedef int32_t i32;
typedef uint32_t u32;
typedef int16_t i16;
typedef uint16_t u16;
typedef int8_t i8;
typedef uint8_t u8;
typedef float f32;
typedef double f64;


typedef struct{
	i32 rows;
	i32 columns;
	//Debug hack
	u8 layout[8*16];
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
	i32 xpos, ypos;
	f32 angle, velocity, rotspeed;
	f32 cosAngle, sinAngle;
}EntityState;
typedef struct RayInfo
{
	f32 dist;
	i32 offset;
	i32 side;
}RayInfo;

typedef struct{
	 f32 *WallDist;
}GameMemory;

#endif
