classdef q2eApp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        ForceEditFieldLabel  matlab.ui.control.Label
        Force                matlab.ui.control.NumericEditField
        L12EditFieldLabel    matlab.ui.control.Label
        L12                  matlab.ui.control.NumericEditField
        L23EditFieldLabel    matlab.ui.control.Label
        L23                  matlab.ui.control.NumericEditField
        L13EditFieldLabel    matlab.ui.control.Label
        L13                  matlab.ui.control.NumericEditField
        UITable              matlab.ui.control.Table
        FindForcesButton     matlab.ui.control.Button
        betaGaugeLabel       matlab.ui.control.Label
        betaGauge            matlab.ui.control.NinetyDegreeGauge
        alphaGaugeLabel      matlab.ui.control.Label
        alphaGauge           matlab.ui.control.NinetyDegreeGauge
        ProgrammetocalculateforcesLabel  matlab.ui.control.Label
        UITable2             matlab.ui.control.Table
        Label                matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %initialise table
            ATable = ["-cos(alpha)" "0" "cos(beta)" "0" "0" "0";
                "-sin(alpha)" "0" "-sin(beta)" "0" "0" "0";
                "cos(alpha)" "1" "0" "1" "0" "0";
                "sin(alpha)" "0" "0" "0" "1" "0";
                "0" "-1" "-cos(beta)" "0" "0" "0";
                "0" "0" "sin(beta)" "0" "0" "1"];
            %display table and assign table properties
            set(app.UITable2, 'Visible', 'on');
            set(app.UITable2, 'Data', ATable, 'ColumnFormat',{'char'});
            set(app.UITable2,'ColumnEditable',true(1,6))
        end

        % Button pushed function: FindForcesButton
        function FindForcesButtonPushed(app, event)
            %calculate alpha and beta
            alpha = acos((app.L12.Value^2 + app.L23.Value^2 - app.L13.Value^2)/(2*app.L12.Value*app.L23.Value));
            beta = acos((app.L13.Value^2 + app.L23.Value^2 - app.L12.Value^2)/(2*app.L13.Value*app.L23.Value));
            
            %conversion for display gauges
            app.alphaGauge.Value = rad2deg(alpha);
            app.betaGauge.Value = rad2deg(beta);
            
            %matrix maths
            A = get(app.UITable2, 'Data');
            %convert user inputs into expressions and evaluate
            c = size(A);
            c = c(1)*c(2);
            for i = 1:c
                A(i) = eval(A(i));
            end
            A = str2double(A);
            B = [0; app.Force.Value; 0; 0; 0; 0];
            sol = A\B;
            namesForces = ["L12";"L23";"L13";"R2x";"R2y";"R3y"];
            vars = [namesForces sol];
            
            %output to table
            set(app.UITable, 'Visible', 'on');
            set(app.UITable, 'Data', vars, 'ColumnFormat',{'numeric'});
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 762 598];
            app.UIFigure.Name = 'MATLAB App';

            % Create ForceEditFieldLabel
            app.ForceEditFieldLabel = uilabel(app.UIFigure);
            app.ForceEditFieldLabel.HorizontalAlignment = 'right';
            app.ForceEditFieldLabel.Position = [62 403 36 22];
            app.ForceEditFieldLabel.Text = 'Force';

            % Create Force
            app.Force = uieditfield(app.UIFigure, 'numeric');
            app.Force.Position = [103 403 100 22];

            % Create L12EditFieldLabel
            app.L12EditFieldLabel = uilabel(app.UIFigure);
            app.L12EditFieldLabel.HorizontalAlignment = 'right';
            app.L12EditFieldLabel.Position = [62 370 26 22];
            app.L12EditFieldLabel.Text = 'L12';

            % Create L12
            app.L12 = uieditfield(app.UIFigure, 'numeric');
            app.L12.Position = [103 370 100 22];

            % Create L23EditFieldLabel
            app.L23EditFieldLabel = uilabel(app.UIFigure);
            app.L23EditFieldLabel.HorizontalAlignment = 'right';
            app.L23EditFieldLabel.Position = [62 349 26 22];
            app.L23EditFieldLabel.Text = 'L23';

            % Create L23
            app.L23 = uieditfield(app.UIFigure, 'numeric');
            app.L23.Position = [103 349 100 22];

            % Create L13EditFieldLabel
            app.L13EditFieldLabel = uilabel(app.UIFigure);
            app.L13EditFieldLabel.HorizontalAlignment = 'right';
            app.L13EditFieldLabel.Position = [62 328 26 22];
            app.L13EditFieldLabel.Text = 'L13';

            % Create L13
            app.L13 = uieditfield(app.UIFigure, 'numeric');
            app.L13.Position = [103 328 100 22];

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Force'; 'Value'};
            app.UITable.RowName = {};
            app.UITable.Position = [272 59 479 185];

            % Create FindForcesButton
            app.FindForcesButton = uibutton(app.UIFigure, 'push');
            app.FindForcesButton.ButtonPushedFcn = createCallbackFcn(app, @FindForcesButtonPushed, true);
            app.FindForcesButton.Position = [103 292 100 22];
            app.FindForcesButton.Text = 'Find Forces';

            % Create betaGaugeLabel
            app.betaGaugeLabel = uilabel(app.UIFigure);
            app.betaGaugeLabel.HorizontalAlignment = 'center';
            app.betaGaugeLabel.Position = [186 117 29 22];
            app.betaGaugeLabel.Text = 'beta';

            % Create betaGauge
            app.betaGauge = uigauge(app.UIFigure, 'ninetydegree');
            app.betaGauge.Limits = [0 90];
            app.betaGauge.Position = [154 154 90 90];

            % Create alphaGaugeLabel
            app.alphaGaugeLabel = uilabel(app.UIFigure);
            app.alphaGaugeLabel.HorizontalAlignment = 'center';
            app.alphaGaugeLabel.Position = [62 117 35 22];
            app.alphaGaugeLabel.Text = 'alpha';

            % Create alphaGauge
            app.alphaGauge = uigauge(app.UIFigure, 'ninetydegree');
            app.alphaGauge.Limits = [0 90];
            app.alphaGauge.Orientation = 'northeast';
            app.alphaGauge.ScaleDirection = 'counterclockwise';
            app.alphaGauge.Position = [34 154 90 90];

            % Create ProgrammetocalculateforcesLabel
            app.ProgrammetocalculateforcesLabel = uilabel(app.UIFigure);
            app.ProgrammetocalculateforcesLabel.HorizontalAlignment = 'right';
            app.ProgrammetocalculateforcesLabel.FontSize = 20;
            app.ProgrammetocalculateforcesLabel.FontWeight = 'bold';
            app.ProgrammetocalculateforcesLabel.Position = [441 534 306 56];
            app.ProgrammetocalculateforcesLabel.Text = 'Programme to calculate forces';

            % Create UITable2
            app.UITable2 = uitable(app.UIFigure);
            app.UITable2.ColumnName = {'Column 1'; 'Column 2'; 'Column 3'; 'Column 4'; 'Colum 5'; 'Colum 6'};
            app.UITable2.RowName = {};
            app.UITable2.ColumnEditable = true;
            app.UITable2.Position = [272 264 479 193];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [202 479 545 56];
            app.Label.Text = {'Please input the force F, the lengths of the members L12, L23 and L13. '; 'The programme will then calculate the values of alpha and beta and display them to you.'; 'If you would like to change the coeffcient matrix, look to the table on the right and adjust as you like.'; 'Click "Find Forces" to calculate the values of the internal bar forces and the reaction forces.'};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = q2eApp_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end