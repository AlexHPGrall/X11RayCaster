typedef struct BMP_Texture
{
    int Width;
    int Height;
    void *BitMap;
}BMP_Texture;

//loads a 24-bit color bmp
//width of image needs to be a multiple of 4
//because we don't account for padding
//store the bitmap as BBGGRR(reversed)
void LoadBMP(char *file, BMP_Texture *texture)
{
    FILE *fp;
    uint32_t loc;  

    if(fp=fopen(file,"rb"))
    {
        fseek(fp, 10, SEEK_SET);
        fread(&loc, 4,1,fp);
        fseek(fp, 18, SEEK_SET);
        fread(&texture->Width, 4,1,fp);
        fseek(fp, 22, SEEK_SET);
        fread(&texture->Height, 4,1,fp);

        if(texture->BitMap=malloc(3*sizeof(char)*texture->Width*texture->Height))
        {
            fseek(fp, loc, SEEK_SET);
            fread(texture->BitMap, 1,3*texture->Width*texture->Height, fp);
        }
        else
        {
            fprintf(stdout, "malloc fail\n");
        }

        fclose(fp);
    }
    else
    {
        fprintf(stdout, "Couldn't open %s\n", file);
    }


}
