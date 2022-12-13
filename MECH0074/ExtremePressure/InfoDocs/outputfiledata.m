function outputfiledata(filename,dataoutput)

fid = fopen(filename, 'wt');
[rows, columns] = size(dataoutput);
for row = 1 : size(dataoutput,1) 	
    for col = 1 : (size(dataoutput,2)-1)
        fprintf(fid, '%f ', ...
            dataoutput(row, col));
        fprintf(fid, ' , ');  
    end
fprintf(fid, '%f ', dataoutput(row, columns)); 
fprintf(fid, '\n'); end
fclose(fid)
end