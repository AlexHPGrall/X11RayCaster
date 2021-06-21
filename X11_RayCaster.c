#include <X11/Xlib.h>
#include <X11/Xutil.h> 
#include <X11/Xos.h> 
#include <X11/keysym.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include <math.h>
#include <assert.h>

#define Assert(e) assert(e)

#include "./RayCaster.h"

#define NIL (0)
#define PI M_PI
#define PI2 M_PI_2
//TODO: define a bitmap struct with a width, height and a pointer to a buffer for our XImage
static i32 width = 1280; 
static i32 height =720;

typedef struct KeyboardInput
{
	Bool w, a, s, d, q, e;
}KeyboardInput;

typedef struct FrameBuffer
{
	i32 width;
	i32 height;
	i32 *buffer;
}FrameBuffer;

#include "./2DUtils.c"
#include "./2DRenderer.c"
#include "./RayCaster.c"

/*Platform layer of the RayTracer*/  
i32 main(i32 argc, char** argv)
{
	//setup time counter
	struct timespec time={};
	clock_gettime(CLOCK_MONOTONIC_RAW, &time);
	long prevtime = time.tv_nsec;
	long currenttime; 
	f64 elapsedtime, fps;
	
	//Create a connection with the X server
	Display* display = XOpenDisplay(NULL);
	if(display == NULL)
	{

		fprintf(stderr, "Cannot open display\n");
		exit(1);
	}

	i32 screen = DefaultScreen(display);
	u32 white = WhitePixel(display, screen);
	u32 black = BlackPixel(display, screen);

	Window win = XCreateSimpleWindow(display, 
			RootWindow(display, screen), 
			10, 10, width, height, 10, white, black);

	/*Select events to be notified of
	  we use a lot of event mask to be notified of a variety of different event types
	  might add or remove some later */
	XSelectInput(display, win,
			StructureNotifyMask|ResizeRedirectMask|ExposureMask|KeyPressMask|KeyReleaseMask);

	XMapWindow(display, win); 
	//Default graphics context
	GC gc =XCreateGC(display, win, 0, NIL);

	//Set drawing color
	XSetForeground(display, gc, white);

	//Necessary to be able to close the window
	Atom WM_DELETE_WINDOW = XInternAtom(display,
			"WM_DELETE_WINDOW", False);
	XSetWMProtocols(display, win, &WM_DELETE_WINDOW, 1);

	/*XImage buffer that we will manipulate directly in our renderer
	  pixels are 32 bits wide, the format is 0xXXRRGGBB
NOTE: malloc might not deliver optimal performande, should try to allocate the buffer in the server shared memory*/
	u8 *ImageBuffer = (u8 *) 
		malloc(width * height* 4 * sizeof(u8)); 

	i32 *p = (i32 *) ImageBuffer;
	for(i32 i=0; i<width*height; ++i)
	{
		*p++ = 0x333333;
	}
	/*24-bit depth but 32-bit per pixel
	  last byte might be useful for alpha channel*/
	XImage *Image =
		XCreateImage(display, CopyFromParent, 24, ZPixmap,
				0, ImageBuffer, width, height, 32, 0);
	FrameBuffer ImageFrameBuffer = {width, height,(i32 *)ImageBuffer};
	KeyboardInput KbInput = {0};
	//NOTE: XEvent are defined as a union over all the event types
	XEvent event = {};

	EntityState state = {width/2-10, height/2,	PI/4, 200, 1.6};  

	//It might be smart to have way to fetch the texture size
	//for now it'll be 64x64
	BMP_Texture WallTexture = {};
	WallTexture.Pixels = (u32 *)malloc(64*64*sizeof(u32));
	LoadBMP("colorstone.bmp", &WallTexture);
	Assert(WallTexture.Height == 64 && WallTexture.Width == 64);
	GameMemory Mem = {};
	Mem.WallDist = (f32 *)malloc(width*sizeof(f32));
	//Main Loop
	for(;;)
	{
		/*Even Handling Loop
		  XPending checks how many events are in the input queue
		  Thus we're not subjected to XNextEvent blocking behavior
		  and are free to compute our next frame once we're done
		  with event handling*/ 
		while(XPending(display))
		{
			XNextEvent(display, &event); //blocks if no event in the queue

			if(event.type == MapNotify)
			{}
			else if(event.type == Expose)
			{
			}

			else if(event.type == ClientMessage)
			{
				XCloseDisplay(display);
				return 0;
			}
			else if(event.type == KeyPress)
			{
				/*NOTE: Proper way to handle input would involve sending 
				 *the input to the platform independant layer 
				 *and only then do a case analysis over the input*/
				KeySym keysym = XLookupKeysym(&event.xkey , 0);
				switch(keysym)
				{
					case(XK_w):
						KbInput.w = True;
						break;

					case(XK_a):
						KbInput.a = True;
						break;
					case(XK_s):
						KbInput.s = True;
						break;
					case(XK_d):
						KbInput.d = True;
						break;
					case(XK_q):
						KbInput.q = True;
						break;
					case(XK_e):
						KbInput.e = True;
						break;

					default:
						break;
				}

			}
			else if(event.type == KeyRelease)
			{
				KeySym keysym = XLookupKeysym(&event.xkey , 0);
				if( keysym == XK_w) {
				}

				switch(keysym)
				{
					case(XK_w):
						//XClearWindow(display, win);
						KbInput.w = False;
						break;
					case(XK_a):
						KbInput.a = False;
						break;
					case(XK_s):
						KbInput.s = False;
						break;
					case(XK_d):
						KbInput.d = False;
						break;
					case(XK_q):
						KbInput.q = False;
						break;
					case(XK_e):
						KbInput.e = False;
						break;

					default:
						break;
				}
			}
		}
		
		//FillBuffer(ImageFrameBuffer);
		//BresenLine(width/2, height/2, rand() % width, rand() % height, rand() % 0xffffff, ImageFrameBuffer);

		//Performance counter
		//get time in nanoseconds
		//!!! to fix the timer: tv_nsec wraps around when it reaches 1 sec or 1000 million nsec = 1000e6
		clock_gettime(CLOCK_REALTIME , &time);
		currenttime = time.tv_nsec;
		//elapsed time converted in milliseconds
		if(currenttime >= prevtime)
			elapsedtime = (currenttime - prevtime)/1000000.0f;
		else
			elapsedtime = (currenttime + (1000e6 - prevtime))/1000000.0f;
		//frames per second
		fps = 1000 / elapsedtime;

//		fprintf(stdout, "%0.2fms / %0.2ffps\n", elapsedtime, fps);
		prevtime = currenttime;

		GameUpdate(KbInput, ImageFrameBuffer, &state, elapsedtime/1000, WallTexture, Mem);
		/*
		i32 *Pixel = ImageFrameBuffer.buffer;
		i32 *bm = WallTexture.Pixels;

				color=*(bm+(j%64)*3+(i%64)*3*64);
				color += *(bm+(j%64)*3+(i%64)*3*64 + 1)<<8;
				color += *(bm+(j%64)*3+(i%64)*3*64 + 2)<<16;
				*Pixel++ = color;
		*/	
		

		XPutImage(display, win, gc, 
				Image, 0, 0, 0, 0, width, height);
	}

	XCloseDisplay(display);
	return 0;
}
