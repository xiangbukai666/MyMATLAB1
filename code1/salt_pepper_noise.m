function noisyImage=salt_pepper_noise(I)
    noiseDensity=0.1;
    saltValue=0;
    pepperValue=255;
    if size(I,3)==3    
        [rows,cols,channels]=size(I);
        noisyImage=I; 
        for i = 1:rows
            for j = 1:cols
                for k = 1:channels
                    randNum = rand();
                    if randNum < noiseDensity
                        randNum2 = rand();
                        if randNum2 < 0.5
                            noisyImage(i, j, k) = saltValue; 
                        else
                            noisyImage(i, j, k) = pepperValue; 
                        end
                    end
                end
            end
        end
    else
    end
    
    end