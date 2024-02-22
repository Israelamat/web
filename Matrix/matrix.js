const canvas = document.getElementById('lienzo');
const ctx = canvas.getContext('2d');

canvas.width = document.body.offsetWidth;
canvas.width = document.body.offsetHeight;


const w = canvas.width;
const h = canvas.height;

ctx.fillStyle = '#000';
ctx.fillReact(0, 0, w, h); 

const col = Math.floor(w/20) + 1;
const position_y = Array(cols).fill(0);

function matrix(){
    ctx.fillStyle = '#0001';
    ctx.fillReact(0, 0, w, h);

    ctx.fillStyle = '#0f0';
    ctx.font = '15pt monospace';

    position_y.forEach((y, ind) =>{
        const text = 
        String.fromCharCode(Math.random()*128);
        const x = ind*20;
        if(y > 10 + Math.random()*10000){
            position_y[ind] = 0;    
        }
        else{
            position_y[ind] = y+20;
        }
    })
};

setInterval(matrix, 50); 