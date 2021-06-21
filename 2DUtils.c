#pragma pack(push, 1)
typedef struct BMP_Header
{
    //Header
    u16 Signature;//'BM'
    u32 FileSize;
    u16 Reserved1;
    u16 Reserved2;
    u32 DataOffset;
    //InfoHeader
    //we're using the 40 bytes BITMAPINFOHEADER for compatibilty purposes.
    u32 InfoHeaderSize; //allows us to infer the info header type
    //Sign of Width/Height should indicate directionality
    i32 Width;
    i32 Height;
    u16 Planes; //should be 1
    u16 BitsPerPixel; //i.e. Color depth
    u32 CompressionType; //0 for no compression (most common)
    u32 ImageSize;//can be 0 if no compression
    u32 XPixelsPerMeter;//Resolution of the targer device
    u32 YPixelPerMeter;
    u32 TotalColors; //if 0 defaults to 2^BitsPerPixel
    u32 ImportantColors;//0 => all colors are important
}BMP_Header;

#pragma pack(pop)

typedef struct BMP_Texture
{
    u32 Width;
    u32 Height;
    u32 *Pixels;
}BMP_Texture, image_u32;

//loads a 24-bit color bmp
//still not sure about when the memory allocation should happen
//for know it's on the caller
static void
LoadBMP(char *file, BMP_Texture *texture)
{
    FILE *fp=fopen(file,"rb");
    BMP_Header Header;
    if(fp)
    {
        fread(&Header, sizeof(BMP_Header), 1,fp);
        texture->Width = Header.Width;
        texture->Height = Header.Height;
        u32 Pitch = (Header.Width * Header.BitsPerPixel)/8;
        //account for 4-bytes boundary padding
        u32 offset=(Pitch)%4;
        if(offset != 0)
        {
            offset =4-offset;
        }

        //Loading the Pixels data
        //Note: the Pixels is stored BottomToTop
        //But we're loading it Top to Bottom
        for(i32 h =0; h<Header.Height; ++h)
        {
            u32 *Pixel=  (u32*)texture->Pixels +((Header.Height -1 - h)*Header.Width);
            fseek(fp, Header.DataOffset + h*(Pitch+offset), SEEK_SET);
            for(i32 w=0; w<Header.Width; ++w)
            {
                fread(Pixel++, Header.BitsPerPixel/8, 1, fp);
            }
        }
        

        fclose(fp);
    }
    else
    {
        fprintf(stdout, "Couldn't open %s\n", file);
    }


}
