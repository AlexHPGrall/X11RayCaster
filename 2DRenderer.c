#define ABS(a) (((a) > 0) ? (a) : -(a)) 
#define SIGN(x) (((x) < 0) ? -1 : 1)
#define MAX(a, b) ((((a)-(b)) > 0) ? (a) : (b)) 
#define MIN(a, b) ((((a)-(b)) > 0) ? (b) : (a)) 
#define SQUARE(X) ((X)*(X))
#define epsilon 0.0001f

//NOTE: !!! Clipping MUST be implemented from the calling side !!!

static void
FillBuffer(FrameBuffer buf, i32 color)
{	
	i32 *p = buf.buffer;
	for(i32 i = 0; i < buf.width * buf.height; i++)
			*p++ = color;
}

static inline void
DrawPixel(i32 x, i32 y, i32 color, FrameBuffer buf)
{
	*(buf.buffer + (buf.width * y) + x) = color;
}
//basic Bresenham Algorithm
static void
BresenLine(i32 x0, i32 y0, i32 x1, i32 y1, i32 color, FrameBuffer buf)
{
	Bool swapped = False;
	i32 x = x0;
	i32 y = y0;

	i32 dx = ABS(x1-x0);
	i32 dy = ABS(y1-y0);
	//check if the line goes up down left or right for incrementation
	i32 signx = SIGN(x1- x0);
	i32 signy = SIGN(y1 - y0);

	if(dy > dx)
	{
		dx = dx + dy;
		dy = dx - dy;
		dx = dx - dy;

		swapped = True;
	}

	f32 err = (2*dy) -dx;

	for(i32 i = 1; i<= dx; i++)
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
DrawLine(i32 x0, i32 y0, i32 x1, i32 y1, i32 color, FrameBuffer buf)
{ BresenLine(x0, y0, x1, y1, color ,buf);}

static void
DrawQuad(i32 x[4], i32 y[4], i32 color, FrameBuffer buf)
{
	for(i32 i=0; i < 4; ++i)
	{
		DrawLine(x[i], y[i], x[i+1], y[i+1], color, buf);
	}
	DrawLine(x[3], y[3], x[0], y[0], color, buf);
}

static void
DrawCol(i32 x, i32 y, i32 h, i32 color, FrameBuffer buf)
{
	for(i32 i=0; i<h; ++i)
		DrawPixel(x, y-i, color, buf);
}

static void
DrawColTexture(i32 x, RayInfo Ray , BMP_Texture Texture, FrameBuffer buf)
{
	f32 lineHeight= CellSize*Ray.dist*buf.height*((f32)8/(f32)9);
	i32 vStart =0;
	if(lineHeight >= buf.height)
	{
		vStart = ((f32)(lineHeight-buf.height)/(f32)lineHeight) * Texture.Height;
		vStart = vStart/2;
		lineHeight = buf.height -1;
	}
	
	i32 vEnd = Texture.Height - vStart;
	f32 vStep = ((f32)(vEnd-vStart)/lineHeight);
	f32 drawStart = buf.height/2 + lineHeight/2;
	u32 *bm = Texture.Pixels;
	i32 u = Ray.offset*((f32)Texture.Width/(f32)CellSize);
	for(i32 i=0; i<=lineHeight; ++i)
	{
		i32 color =0;
		i32 v = vStart+ i*vStep;  	
		color=*(bm+u+v*Texture.Width);
		DrawPixel(x, drawStart-i, color, buf);
	}
}
static void
FillRect(i32 xorigin, i32 yorigin, i32 width, i32 height, i32 color, FrameBuffer buf)
{
	for(i32 y = yorigin; y < yorigin + height  ; ++y)
	{

		for(i32 x = xorigin ; x  < xorigin + width; ++x)
		{
			DrawPixel(x, y, color, buf);
		}
	}
}
