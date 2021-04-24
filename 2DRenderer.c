#define ABS(a) (((a) > 0) ? (a) : -(a)) 
#define SIGN(x) (((x) < 0) ? -1 : 1)
#define MAX(a, b) ((((a)-(b)) > 0) ? (a) : (b)) 
#define MIN(a, b) ((((a)-(b)) > 0) ? (b) : (a)) 

//NOTE: !!! Clipping MUST be implemented from the calling side !!!

static void
FillBuffer(FrameBuffer buf, int color)
{	
	int *p = buf.buffer;
	for(int i = 0; i < buf.width * buf.height; i++)
			*p++ = color;
}

static inline void
DrawPixel(int x, int y, int color, FrameBuffer buf)
{
	*(buf.buffer + (buf.width * y) + x) = color;
}
//basic Bresenham Algorithm
static void
BresenLine(int x0, int y0, int x1, int y1, int color, FrameBuffer buf)
{
	Bool swapped = False;
	int x = x0;
	int y = y0;

	int dx = ABS(x1-x0);
	int dy = ABS(y1-y0);
	//check if the line goes up down left or right for incrementation
	int signx = SIGN(x1- x0);
	int signy = SIGN(y1 - y0);

	if(dy > dx)
	{
		dx = dx + dy;
		dy = dx - dy;
		dx = dx - dy;

		swapped = True;
	}

	float err = (2*dy) -dx;

	for(int i = 1; i<= dx; i++)
	{
		DrawPixel(x, y, color, buf);
		while(err >= 0)
		{
			if(swapped)
				x += signx;
			else
				y += signy;
			err -= 2*dx;
		}
		if(swapped)
			y+=signy;
		else
			x+=signx;
		err += 2*dy;
	}
}	
static void
DrawLine(int x0, int y0, int x1, int y1, int color, FrameBuffer buf)
{ BresenLine(x0, y0, x1, y1, color ,buf);}

static void
DrawQuad(int x[4], int y[4], int color, FrameBuffer buf)
{
	for(int i=0; i < 4; ++i)
	{
		DrawLine(x[i], y[i], x[i+1], y[i+1], color, buf);
	}
	DrawLine(x[3], y[3], x[0], y[0], color, buf);
}


static void
FillRect(int xorigin, int yorigin, int width, int height, int color, FrameBuffer buf)
{
	for(int y = yorigin; y < yorigin + height  ; ++y)
	{

		for(int x = xorigin ; x  < xorigin + width; ++x)
		{
			DrawPixel(x, y, color, buf);
		}
	}
}
