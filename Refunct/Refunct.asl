state("Refunct-Win32-Shipping")
{
    int   cubes               : 0x1FBF9FC, 0xC0, 0x9C;
    int   level               : 0x1FBF9FC, 0xC0, 0xA8;
    int   resets              : 0x1FBF9FC, 0xC0, 0xAC;
    int   startSeconds        : 0x1FBF9FC, 0xC0, 0xB0;
    float startPartialSeconds : 0x1FBF9FC, 0xC0, 0xB4;
    int   endSeconds          : 0x1FBF9FC, 0xC0, 0xB8;
    float endPartialSeconds   : 0x1FBF9FC, 0xC0, 0xBC;
}

startup
{
    settings.Add("levelsplits", true, "Split on level rise");
    settings.Add("cubesplits", false, "Split on cube collect");
}

start
{
    return current.resets > old.resets;
}

split
{
    return
        current.level > old.level && settings["levelsplits"] ||
        current.cubes > old.cubes && settings["cubesplits"] ||
        current.resets > old.resets;
}

reset
{
    return current.resets > old.resets && current.level == 0;
}

gameTime
{
    if (current.endSeconds > current.startSeconds)
        return TimeSpan.FromSeconds(
            Convert.ToDouble(current.endSeconds - current.startSeconds) +
            Convert.ToDouble(current.endPartialSeconds - current.startPartialSeconds)
        );
}
