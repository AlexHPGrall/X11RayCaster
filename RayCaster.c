static int focalDepth =1;
//Obviously the map struct is completely broken but sufficient to get us 
//up and running for the ray caster part

static size_t
GetMapIndex(float x, float y, Map *level, FrameBuffer buf)
{
	int xoffset = buf.width/2 - (CellSize*level->columns)/2;
	int yoffset = buf.height/2 - (CellSize*level->rows)/2;
	size_t j = ((size_t) roundf(x) - xoffset )/CellSize;
	size_t i = ((size_t) roundf(y) - yoffset )/CellSize;
	return (i*level->columns + j);
	
}
static int
GetYOffset(int y, Map *level, FrameBuffer buf)
{
	int offset = buf.height/2 - (CellSize*level->columns)/2;
	return (y-offset) - (((int)y-offset)/CellSize)*CellSize;
}
static int 
GetXOffset(int x, Map *level, FrameBuffer buf)
{
	int offset = buf.width/2 - (CellSize*level->columns)/2;
	return (x-offset) - (((int)x-offset)/CellSize)*CellSize;
}

static RayInfo 
CastRay(int x, int y, float angle,float theta, Map *level, FrameBuffer buf)
{
	float xIntersect, yIntersect, dx, dy;
	size_t currentCell = GetMapIndex(x, y , level, buf);
	int stepX, stepY,xoffset, yoffset;
	Bool hit=False;
	xoffset = GetXOffset(x, level, buf); 
	yoffset = GetYOffset(y, level, buf); 
	/*
	if(ABS(angle) < epsilon || ABS(angle -PI) < epsilon)
	{
		dx =1;dy=0;
	}
	else if(ABS(angle - PI2) <epsilon ||ABS(angle-3*PI2) <epsilon)
	{
		dx = 0; dy=1;
	}
	else
	{
		dx = ABS(1/ tanf(angle));
		dy = ABS(1* tanf(angle));
	}
*/
		dx = ABS(1/ tanf(angle));
		dy = ABS(1* tanf(angle));
	if(angle<PI2 || angle > 3*PI2)
	{
		stepX =1;
	}
	else
	{
		stepX =-1;
	}
	if(angle > PI)
	{
		stepY = -1;
	}
	else
	{
		stepY = 1;
	}
	if(stepX == 1)
		xIntersect= (CellSize-xoffset)*dy;
	else
		xIntersect =(xoffset)*dy;
	if(stepY ==1)
		yIntersect = (CellSize-yoffset)*dx;
	else
		yIntersect = yoffset*dx;

	int rx = (x-xoffset), ry = (y-yoffset), side;
	if(stepX ==1)
		rx+=CellSize;
	if(stepY == 1)
		ry+=CellSize;
	while(!hit)
	{
		
		if(stepY*(y+(stepY*xIntersect)) < stepY*ry)
		{
			side =0;
			currentCell += stepX;
			hit = level->layout[currentCell];
			if(!hit)
			{
				rx+=stepX*CellSize;
				xIntersect +=dy*CellSize;
			}
		}
		else
		{
			side =1;
			currentCell +=stepY*level->columns;
			hit = level->layout[currentCell];
			if(!hit)
			{
				ry+=stepY*CellSize;
				yIntersect +=dx*CellSize;
			}
		}
		
	}
	
	if(side ==0)
	{
		RayInfo ray ={};
		float DeltaX =ABS(rx-x);
		float DeltaY = xIntersect;
		float d = sqrt(DeltaX*DeltaX + DeltaY*DeltaY);
		//ray.dist =  d*cos(ABS(theta-angle));
		ray.dist = sqrtf(SQUARE(rx-x) + SQUARE(stepY*xIntersect));
		ray.side = side;
		ray.offset = ((int)floor(y + (stepY*xIntersect))%CellSize);
		//BresenLine(x, y, rx, y+stepY*xIntersect, 0xff00ff, buf);
		return ray;
	}
	else{
		
		RayInfo ray ={};
		float DeltaX =yIntersect;
		float DeltaY = ABS(ry-y);
		float d = sqrt(DeltaX*DeltaX + DeltaY*DeltaY);
		//ray.dist = d*cos(ABS(theta-angle));
		ray.dist = sqrtf(SQUARE(stepX*yIntersect) + SQUARE(ry-y));
		ray.side = side;
		ray.offset = (int)floor(x+(stepX*yIntersect))%CellSize;
		//BresenLine(x, y,x+stepX*yIntersect, ry, 0xff00ff, buf);
		return ray;
	}
	
	
}

//this function is stupid 
static void
CheckCollision(EntityState *player, Map *level, int direction, FrameBuffer buf)
{
	float xp = player->xpos, yp = player->ypos;
	float xl = xp-5, xr= xp + 5 ;
	float yu = yp -5, yd = yp +5;
	float x[4]={xl, xl, xr, xr};
	float y[4]= {yu, yd, yu, yd};
	
	for(int i = 0; i<4; ++i)
	{
		if(level->layout[GetMapIndex(x[i], y[i], level, buf)])
		{ 

			player->xpos += direction*0.5f*(cosf(player->angle));
			player->ypos += direction*0.5f*(sinf(player->angle));
			CheckCollision(player, level, direction, buf);
			break;
		}
	}
}

static void
DrawMap(Map *level, FrameBuffer buf)
{
	int xoffset = buf.width/2 - (CellSize*level->columns)/2;
	int yoffset = buf.height/2 - (CellSize*level->rows)/2;
	for(int i = 0; i<level->rows; ++i)
	{
		for(int j= 0; j<level->columns; ++j)
		{
			if(level->layout[i*level->columns + j])
			{
				FillRect(j*CellSize + xoffset, 
				  	 i*CellSize + yoffset,
					 CellSize-1, CellSize-1, 0xffffff, buf);
			}
			/*else{
				
				FillRect(j*CellSize + xoffset, 
				  	 i*CellSize + yoffset,
					 CellSize-1, CellSize-1, 0x000000, buf);
			}*/
		}
	}
}
static void
DrawPlayer(EntityState player, FrameBuffer buf)
{
	int x= (int) roundf(player.xpos);
	int y= (int) roundf(player.ypos);
	FillRect(x-5, y-5, 11, 11, 0xf5e942, buf);
	BresenLine(x, y,
		roundf((25*cosf(player.angle)) + player.xpos), 
		roundf((25*sinf(player.angle)) +player.ypos), 
		0xf54242, buf);
}

void 
DrawFloor(EntityState *player, float FOVangle, FrameBuffer buf, BMP_Texture Floor, Map *level)
{	int z =CellSize/2;
	//we need half the vertical FOV
	//
	float playerCos = cosf(player->angle);
	float playerSin = sinf(player->angle);
	float FOVTan = ABS(tanf(FOVangle/2));
	float HalfvFOV = atanf(tanf(FOVangle/2)*((float)buf.height/buf.width));
	for(int h =0; h<buf.height/2;++h)
	{
		//height of screen is 9/16*width of screen
		//should have a variable for screen dim
		//right now a widht of 2(frome -1 to 1) is hard coded
		//
		//we're only considering half the screen hence the 9/16
		float pixY= (2.0f*h/(buf.height))*(9.0f/16.0f);
		float FloorDist =focalDepth*0.5f*CellSize/pixY;
		//FloorHalfWidth is actually FloorDist divided by half screen width
		float FloorHalfWidth = FloorDist;  
		float xEnd= player->xpos + FloorDist*playerCos - FloorHalfWidth*playerSin;
		float xStart = player->xpos + FloorDist*playerCos + FloorHalfWidth*playerSin;
		float yEnd = player->ypos + FloorDist*playerSin + FloorHalfWidth*playerCos;
		float yStart= player->ypos + FloorDist*playerSin - FloorHalfWidth*playerCos;
		float uStep =((float) (xEnd -xStart)/buf.width);
		float vStep = ((float)(yEnd-yStart)/buf.width);
/*
		int uStart = ((float)(((int)(xStart)%CellSize)*Floor.Width))/(float)CellSize;
		int vStart = ((float)(((int)(yStart)%CellSize)*Floor.Height))/(float)CellSize;
		int uEnd= ((float)(((int)(xEnd)%CellSize)*Floor.Width))/(float)CellSize;
		int vEnd = ((float)(((int)(yEnd)%CellSize)*Floor.Height))/(float)CellSize;

	*/	

		int color =0;
		uint8_t *bm = Floor.BitMap;
		for(int i=0; i<buf.width; ++i)
		{
			int u = xStart +i*uStep;
			int v = yStart +i*vStep;
			
			/*
			size_t currentCell = GetMapIndex(u, v, level, buf);
			if(u<0 || u>= buf.width|| v<0 || v>=buf.height
			|| currentCell<0 || currentCell >=8*16 || !level->layout[currentCell])
			{
				DrawPixel(i, buf.height -1 -h, 0, buf);
			}
			else
			*/
			{
			u=u%CellSize;
			u=u*(Floor.Width/CellSize);
			v=v%CellSize;
			v=v*(Floor.Height/CellSize);
			color=*(bm+(u)*3+(v)*3*Floor.Width);
			color += *(bm+(u)*3+(v)*3*Floor.Width + 1)<<8;
			color += *(bm+(u)*3+(v)*3*Floor.Width + 2)<<16;
			/*
			if(u==0 || u ==63 || v==0|| v==63)
				color =0xffffff;
				*/
			DrawPixel(i, (buf.height/2)+h, color, buf);
			DrawPixel(i, (buf.height/2)-h, color, buf);
			//DrawPixel(i, buf.height-h, z, buf);

			}
		}

		
	}

}
static void
GameUpdate(KeyboardInput input, FrameBuffer buf, EntityState *playerState, float dtime, BMP_Texture Texture)
{
	int opositdir=1;
	if(input.q)
		playerState->angle -= dtime*playerState->rotspeed;
	else if(input.e)
		playerState->angle += dtime*playerState->rotspeed;

	/*
	 * NOTE: Debug controls
	if(input.w)
	{
		playerState->ypos-=dtime*playerState->velocity;
	}
	if(input.a)
	{
		playerState->xpos-=dtime*playerState->velocity;
	}
	if(input.s)
	{
		playerState->ypos+=dtime*playerState->velocity;
	}
	if(input.d)
	{
		playerState->xpos+=dtime*playerState->velocity;
	}
	*/
	 // Note: Tank controls
	if(input.w)
	{	
		opositdir= -1;
		playerState->xpos += dtime*playerState->velocity*(cosf(playerState->angle));
		playerState->ypos += dtime*playerState->velocity*(sinf(playerState->angle));
	}
	else if(input.s)
	{
		opositdir =1;
		playerState->xpos -= dtime*playerState->velocity*(cosf(playerState->angle));
		playerState->ypos -= dtime*playerState->velocity*(sinf(playerState->angle));
	}
	//Keep our angle in the range [0,2PI[
	if(playerState->angle >= 2*PI)
		playerState->angle -= 2*PI;
	else if (playerState->angle <0)
		playerState->angle += 2*PI;

	CheckCollision(playerState, &gameMap, opositdir, buf);

	FillBuffer(buf, 0x333333);
	//DrawMap(&gameMap, buf); 
	//DrawPlayer(*playerState, buf);
	
	DrawFloor(playerState, PI/3, buf, Texture, &gameMap);
		
	for(int i = 0; i<buf.width; ++i)
	{
		float pixX = -1.0f+2.0f*((float)i/(float)(buf.width));
		float angle = atanf(ABS(pixX)/focalDepth);
		angle = playerState->angle + (SIGN(pixX)*angle);
	//	float angle =(playerState->angle+ (PI/6))-(buf.width-i)*((PI/3)/buf.width);

		if(angle >= 2*PI)
			angle -= 2*PI;
		else if (angle <0)
			angle += 2*PI;
		RayInfo Ray ={};
		Ray= CastRay(floor(playerState->xpos), floor(playerState->ypos), 
				angle,playerState->angle,
				&gameMap, buf);
		//int color = 0xff00ff;
		Ray.dist = sqrtf(1.0f+ (pixX*pixX))/Ray.dist;
		DrawColTexture(i, Ray, Texture, buf);
		//DrawCol(i, drawStart, lineHeight, color, buf);
	}
	
	
}
