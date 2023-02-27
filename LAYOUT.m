% Dimensions of the warehouse
num_floors = 1;
num_aisles = 23;
num_racks = 1; % unclear parameter
num_bays = 23;

% Load the visit locations from a text file
product_locations = importdata('product_locations.txt');

% Create a figure to draw the layout
figure;
hold on;

% Draw the floors
for floor = 1:num_floors
    for aisle = 1:num_aisles
        for rack = 1:num_racks
            % Draw the aisle
            aisle_width = 2;
            aisle_height = 5;
            aisle_x = (aisle-1) * aisle_width;
            aisle_y = (floor-1) * aisle_height;
            rectangle('Position', [aisle_x aisle_y aisle_width aisle_height], 'EdgeColor', 'k', 'FaceColor', 'none');
            
            % Draw the racks
            for bay = 1:num_bays
                rack_width = 0.5;
                rack_height = aisle_height / num_bays;
                if rack == 1
                    % Draw the left side of the rack
                    rack_x = aisle_x + (rack-1) * rack_width;
                else
                    % Draw the right side of the rack
                    rack_x = aisle_x + aisle_width - rack_width * rack;
                end
                rack_y = aisle_y + (bay-1) * rack_height;
                
                % Draw the rectangle for the left side of the rack
                rectangle('Position', [rack_x rack_y rack_width/2 rack_height], 'EdgeColor', 'k', 'FaceColor', 'none');
                
                % Draw the rectangle for the right side of the rack
                rectangle('Position', [rack_x+rack_width/2 rack_y rack_width/2 rack_height], 'EdgeColor', 'k', 'FaceColor', 'none');
                
                % Check if there is a product at this location
                product_location = sprintf('P%d.%03d.%02dC%02d', floor, aisle, rack, bay);
                if any(strcmp(product_location, product_locations))
                    % Draw a dot to represent the product
                    dot_x = rack_x + rack_width / 2;
                    dot_y = rack_y + rack_height / 2;
                    plot(dot_x, dot_y, 'k.', 'MarkerSize', 20);
                end
            end
        end
    end
end

% Add labels to the aisles
aisle_labels = {'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'A10','A11', 'A12', 'A13', 'A14', 'A15', 'A16', 'A17', 'A18', 'A19', 'A20','A21','A22','A23'};
for aisle = 1:num_aisles
    aisle_x = (aisle-0.5) * aisle_width;
    aisle_y = -2;
    text(aisle_x, aisle_y, aisle_labels{aisle}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
end

% Add labels to the floors
floor_labels = {'P1', 'P2', 'P3','P4'};
for floor = 1:num_floors
    floor_x = -3;
    floor_y = (floor-0.5) * aisle_height;
    text(floor_x, floor_y, floor_labels{floor}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Rotation', 90);
end

% Set the axis limits
axis equal;
xlim([-3 (num_aisles+0.5)*aisle_width]);
ylim([-2 (num_floors+0.5)*aisle_height]);

% Add a title
title('Warehouse Layout');