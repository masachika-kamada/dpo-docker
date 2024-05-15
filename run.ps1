$NAME = "cuda118"

docker run -it `
    --name $NAME `
    --gpus all `
    $NAME /bin/bash
