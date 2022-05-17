classdef MinHeap
    
    properties
        U
        r
        c
        heap_size
        capacity
    end
    
    methods
        function obj = MinHeap(mx_cnt)
            if(nargin > 0)
                obj.heap_size = 0;
                obj.capacity = mx_cnt;
                obj.U = zeros(mx_cnt, 1);
                obj.r = zeros(mx_cnt, 1);
                obj.c = zeros(mx_cnt, 1);            
            end
            
        end
        
        function rlt = parent(obj, i)
            rlt = uint32(floor(i / 2));
        end
        
        function rlt = left(obj, i)
            rlt = i * 2;
            rlt = uint32(rlt);
        end
        
        function rlt = right(obj, i)
            rlt = i * 2 + 1;
            rlt = uint32(rlt);
        end
        
        function rlt = getSize(obj)
            rlt = obj.heap_size;
        end
        
        function rlt = insertKey(obj, iu, ir, ic)
            rlt = obj;
            if(obj.heap_size == obj.capacity)
                return
            end
            
            obj.heap_size = obj.heap_size + 1;            
            obj.U(uint32(obj.heap_size)) = iu;
            obj.r(uint32(obj.heap_size)) = ir;
            obj.c(uint32(obj.heap_size)) = ic;
            i = uint32(obj.heap_size);
            
            while(i > 1 && obj.U(obj.parent(i)) > obj.U(i))
                [obj.U(i), obj.U(obj.parent(i))] = swap(obj.U(obj.parent(i)), obj.U(i));
                [obj.r(i), obj.r(obj.parent(i))] = swap(obj.r(obj.parent(i)), obj.r(i));
                [obj.c(i), obj.c(obj.parent(i))] = swap(obj.c(obj.parent(i)), obj.c(i));
                i = obj.parent(i);                 
            end
            
            rlt = obj;
        end
        
        function rlt = MinHeapify(obj, i)
            l = obj.left(i);
            r = obj.right(i);
%             obj.heap_size
            smallest = i;
            if(l < obj.heap_size && obj.U(l) < obj.U(i))
                smallest = l;
            end
            
            if(r < obj.heap_size && obj.U(r) < obj.U(smallest))
                smallest = r;
            end 
            
            if (smallest ~= i)
                [obj.U(smallest), obj.U(i)] = swap(obj.U(i), obj.U(smallest));
                [obj.r(smallest), obj.r(i)] = swap(obj.r(i), obj.r(smallest));
                [obj.c(smallest), obj.c(i)] = swap(obj.c(i), obj.c(smallest));
                obj = MinHeapify(obj, smallest);
            end
            
            rlt = obj;
            
        end
        
        function [rlt, iu, ir, ic] = extractMin(obj, i)            
            iu = -1;
            ir = -1;
            ic = -1;
            
            if(obj.heap_size <= 0)
                rlt = obj;
                return
            end
            
            iu = obj.U(1);
            ir = obj.r(1);
            ic = obj.c(1);
%             obj.heap_size
            if(obj.heap_size == 1)
                rlt = obj;
                return
            end
            
            obj.U(1) = obj.U(obj.heap_size);
            obj.r(1) = obj.r(obj.heap_size);
            obj.c(1) = obj.c(obj.heap_size);
            obj.heap_size = obj.heap_size - 1;
            rlt = obj.MinHeapify(1);
            
        end
    end
    
end

