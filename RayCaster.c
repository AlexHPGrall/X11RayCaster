
//the offset is just a debug thing
//it'll go away when we integrate the minimap
static size_t
GetMapIndex(i32 x, i32 y, Map *level, FrameBuffer buf)
{
	i32 xoffset = buf.width/2 - (CellSize*level->columns)/2;
	i32 yoffset = buf.height/2 - (CellSize*level->rows)/2;
	size_t j = (x - xoffset)/CellSize;
	size_t i = (y - yoffset )/CellSize;
	return (i*level->columns + j);
	
}
static i32
GetYOffset(i32 y, Map *level, FrameBuffer buf)
{
	i32 offset = buf.height/2 - (CellSize*level->columns)/2;
	return (y-offset) - (((i32)y-offset)/CellSize)*CellSize;
}
static i32 
GetXOffset(i32 x, Map *level, FrameBuffer buf)
{
	i32 offset = buf.width/2 - (CellSize*level->columns)/2;
	return (x-offset) - (((i32)x-offset)/CellSize)*CellSize;
}

static RayInfo 
CastRay(i32 x, i32 y,i32 stepX, i32 stepY, f32 tanAngle, Map *level, FrameBuffer buf)
{
	f32 xIntersect, yIntersect, dx, dy;
	size_t currentCell = GetMapIndex(x, y , level, buf);
	i32  xoffset, yoffset;
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
		dx = ABS(1/ tanAngle);
		dy = ABS(1* tanAngle);
	if(stepX == 1)
		xIntersect= (CellSize-xoffset)*dy;
	else
		xIntersect =(xoffset)*dy;
	if(stepY ==1)
		yIntersect = (CellSize-yoffset)*dx;
	else
		yIntersect = yoffset*dx;

	i32 rx = (x-xoffset), ry = (y-yoffset), side;
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
		ray.dist=ABS(rx-x);	
		ray.side = side;
		ray.offset = ABS((i32)floor(y + (stepY*xIntersect))%CellSize);
		//BresenLine(x, y, rx, y+stepY*xIntersect, 0xff00ff, buf);
		return ray;
	}
	else{
		
		RayInfo ray ={};
		ray.dist = yIntersect;
		ray.side = side;
		ray.offset =ABS( (i32)floor(x+(stepX*yIntersect))%CellSize);
		//BresenLine(x, y,x+stepX*yIntersect, ry, 0xff00ff, buf);
		return ray;
	}
	
	
}

//this function is Naive
static Bool 
CheckCollision(EntityState *player, Map *level, FrameBuffer buf, f32 xDisp, f32 yDisp)
{
	i32 xIndex = player->xpos + (i32)roundf(xDisp);
	i32 yIndex = player->ypos + (i32)roundf(yDisp);
	size_t mapIndex = GetMapIndex(xIndex, yIndex, level, buf);
	Assert(mapIndex <level->rows*level->columns &&  mapIndex>=0);
	
	
	return level->layout[mapIndex]; 
}

static void
DrawMap(Map *level, FrameBuffer buf)
{
	i32 xoffset = buf.width/2 - (CellSize*level->columns)/2;
	i32 yoffset = buf.height/2 - (CellSize*level->rows)/2;
	for(i32 i = 0; i<level->rows; ++i)
	{
		for(i32 j= 0; j<level->columns; ++j)
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
	i32 x= player.xpos;
	i32 y= player.ypos;
	FillRect(x-5, y-5, 11, 11, 0xf5e942, buf);
	BresenLine(x, y,
		(i32)((25*player.cosAngle) + player.xpos+0.5f), 
		(i32)((25*player.sinAngle) +player.ypos+0.5f), 
		0xf54242, buf);
}

//This is actually broken
//it's seems to rely on the fact that textures and Cells are the same size
void 
DrawFloor(EntityState *player, FrameBuffer buf, BMP_Texture Floor,BMP_Texture Ceiling,  Map *level)
{	i32 z =CellSize/2;
	//we still need that stupid offset for correctness
	//should get rid of it asap
	i32 xoffset = buf.width/2 - (CellSize*level->columns)/2;
	i32 yoffset = buf.height/2 - (CellSize*level->rows)/2;

	f32 playerCos = (player->cosAngle);
	f32 playerSin = (player->sinAngle);
	for(i32 h =0; h<buf.height/2;++h)
	{
		//height of screen is 9/16*width of screen
		//should have a variable for screen dim
		//right now a width of 2(from -1 to 1) is hard coded
		//
		//we're only considering half the screen hence the 9/16
		f32 pixY= (2.0f*h/(buf.height))*(9.0f/16.0f);
		f32 FloorDist =focalDepth*0.5f*CellSize/pixY;
		//FloorHalfWidth is actually FloorDist divided by half screen width
		f32 FloorHalfWidth = FloorDist;  
		f32 xEnd= player->xpos + FloorDist*playerCos - FloorHalfWidth*playerSin;
		f32 xStart = player->xpos + FloorDist*playerCos + FloorHalfWidth*playerSin;
		f32 yEnd = player->ypos + FloorDist*playerSin + FloorHalfWidth*playerCos;
		f32 yStart= player->ypos + FloorDist*playerSin - FloorHalfWidth*playerCos;
		f32 uStep =((f32) (xEnd -xStart)/buf.width);
		f32 vStep = ((f32)(yEnd-yStart)/buf.width);

		i32 color =0;
		u32 *bm = Floor.Pixels;
		u32 *cm = Ceiling.Pixels;
		for(i32 i=0; i<buf.width; ++i)
		{
			i32 u = xStart +i*uStep - xoffset;
			i32 v = yStart +i*vStep - yoffset;
			{
				//NOTE(Alex): I bet the issue is in the next 4 lines
				u=ABS(u%CellSize);
				u=u*((f32)Floor.Width/(f32)CellSize);
				v=ABS(v%CellSize);
				v=v*((f32)Floor.Height/(f32)CellSize);
				color=*(bm+u+v*Floor.Width);

				DrawPixel(i, (buf.height/2)+h, color, buf);
				color=*(cm+u+v*Ceiling.Width);
				DrawPixel(i, (buf.height/2)-h, color, buf);

			}
		}
		
	}

}
static void
GameUpdate(KeyboardInput input, FrameBuffer buf, EntityState *playerState, f32 dtime,
	       	BMP_Texture WallTexture,BMP_Texture FloorTexture,BMP_Texture CeilingTexture, GameMemory Memory)
{
	if(input.q)
		playerState->angle -= dtime*playerState->rotspeed;
	else if(input.e)
		playerState->angle += dtime*playerState->rotspeed;

	//Keep our angle in the range [0,2PI[
	if(playerState->angle >= 2*PI)
		playerState->angle -= 2*PI;
	else if (playerState->angle <0)
		playerState->angle += 2*PI;
	playerState->cosAngle = cosf(playerState->angle);
	playerState->sinAngle = sinf(playerState->angle);
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
	f32 xDisp=0, yDisp=0;
	if(input.w)
	{	
		xDisp = (dtime*playerState->velocity*(playerState->cosAngle));

		yDisp = (dtime*playerState->velocity*(playerState->sinAngle));
	}
	else if(input.s)
	{
		xDisp = - (dtime*playerState->velocity*(playerState->cosAngle));
		yDisp = - (dtime*playerState->velocity*(playerState->sinAngle));
	}


	//Check for wall colision with some padding to avoid getting too close to walls
	if(!CheckCollision(playerState, &gameMap, buf, xDisp+4.0f*SIGN(xDisp), yDisp+4.0f*SIGN(yDisp)))
	{
		playerState->xpos += (i32)roundf(xDisp);
		playerState->ypos += (i32)roundf(yDisp); 
	}


	FillBuffer(buf, 0x33333333);
	//DrawMap(&gameMap, buf); 
	//DrawPlayer(*playerState, buf);
	
	DrawFloor(playerState, buf, FloorTexture,CeilingTexture, &gameMap);
		
	f32 PlayerTan = playerState->sinAngle / playerState->cosAngle;
	for(i32 i = 0; i<buf.width; ++i)
	{
		f32 pixX = -1.0f+2.0f*((f32)i/(f32)(buf.width));
		//compute ray direcetion relative to main axis 
		f32 RayX =focalDepth*playerState->cosAngle - pixX*playerState->sinAngle; 
		f32 RayY =focalDepth*playerState->sinAngle + pixX*playerState->cosAngle;
		i32 StepX = SIGN(RayX);	
		i32 StepY = SIGN(RayY);	
		f32 tanRay = (ABS(pixX)/focalDepth);
		tanRay = (PlayerTan + SIGN(pixX)*tanRay)/(1-SIGN(pixX)*tanRay*PlayerTan);

		RayInfo Ray ={};
		Ray= CastRay(playerState->xpos, playerState->ypos, StepX,StepY, 
				tanRay,
				&gameMap, buf);
		//i32 color = 0xff00ff;
		
		//we really are after a ratio of similar triangle side length
		if(Ray.dist<epsilon)
			Ray.dist=epsilon;
		Ray.dist =(f32)ABS(RayX)/Ray.dist; 
		//Perp Wall Distance
		Memory.WallDist[i] = 1.0f/Ray.dist;
		DrawWallCol(i, Ray, WallTexture, buf);
	}
	EntityState SpriteTest ={};
	SpriteTest.xpos =768;
	SpriteTest.ypos=309;

	DrawSprite(CeilingTexture, SpriteTest, *playerState,Memory.WallDist,buf); 
}
