///scr_move_state
//movement
//dash
movement= MOVE;
if (obj_input.dash_key)
{
    var xdir=lengthdir_x(8, face*90);
    var ydir=lengthdir_y(8, face*90);
    var speaker = instance_place(x+xdir,y+ydir,obj_speaker);
    if(speaker != noone)
    {
    //talk to it
                with (speaker) 
        {
            if(!instance_exists(dialogue))
                {
                    dialogue = instance_create (x+xoffset,y+yoffset, obj_dialogue);
                    dialogue.text= text;
                }
            else 
                {
                    dialogue.text_page++;
                    dialogue.text_count =0;
                    if (dialogue.text_page > array_length_1d(dialogue.text)-1)
                    {
                        with(dialogue)
                        {
                            instance_destroy();
                        }
                    }
                        
                }
        }
    }
    //or dash
        else if(obj_player_stats.stamina >=DASH_COST){
        state=scr_dash_state;
        alarm[0] = room_speed/5;
        obj_player_stats.stamina-=DASH_COST;
        obj_player_stats.alarm[0]= room_speed*3;
    }
}

if (obj_input.attack_key)
{
    image_index=0;
    state=scr_attack_state;
}

//spell cast
if(obj_input.spell_key)
{
    var p =instance_create(x,y,obj_projectile);
    var xforce= lengthdir_x(20,face*90);
    var yforce= lengthdir_y(20,face*90);
    p.creator= id;
    with (p)
    {
        physics_apply_impulse(x,y,xforce,yforce);
    }
}


//get direction
dir = point_direction(0,0, obj_input.xaxis,obj_input.yaxis)

//length
if (obj_input.xaxis == 0 && obj_input.yaxis == 0)
{
    len=0;
}
else
{
    len=spd;
    scr_get_face();
}
// speed
hspd= lengthdir_x(len,dir);
vspd= lengthdir_y(len,dir);

//move
phy_position_x += hspd;
phy_position_y += vspd;

//control sprite
image_speed = sign(len)*.2;
if (len==0) image_index=0;

