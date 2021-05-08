classdef q2eApp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        ForceNLabel       matlab.ui.control.Label
        Force             matlab.ui.control.NumericEditField
        L12mLabel         matlab.ui.control.Label
        L12               matlab.ui.control.NumericEditField
        L23mLabel         matlab.ui.control.Label
        L23               matlab.ui.control.NumericEditField
        L13mLabel         matlab.ui.control.Label
        L13               matlab.ui.control.NumericEditField
        UITable           matlab.ui.control.Table
        FindForcesButton  matlab.ui.control.Button
        betaGaugeLabel    matlab.ui.control.Label
        betaGauge         matlab.ui.control.NinetyDegreeGauge
        alphaGaugeLabel   matlab.ui.control.Label
        alphaGauge        matlab.ui.control.NinetyDegreeGauge
        ProgrammetocalculateforcesLabel  matlab.ui.control.Label
        UITable2          matlab.ui.control.Table
        Label             matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %initialise table
            ATable = ["-cos(alpha)" "cos(beta)" "0" "0" "0" "0";
                "-sin(alpha)" "-sin(beta)" "0" "0" "0" "0";
                "cos(alpha)" "0" "1" "1" "0" "0";
                "sin(alpha)" "0" "0" "0" "1" "0";
                "0" "-cos(beta)" "-1" "0" "0" "0";
                "0" "sin(beta)" "0" "0" "0" "1"];
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
            for i = 1:length(B)
                if sol(i) < 0.01 && sol(i) > -0.01
                    sol(i) = 0;
                end
            end
            namesForces = ["L12";"L13";"L23";"R2x";"R2y";"R3y"];
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

            % Create ForceNLabel
            app.ForceNLabel = uilabel(app.UIFigure);
            app.ForceNLabel.HorizontalAlignment = 'right';
            app.ForceNLabel.Position = [32 403 56 22];
            app.ForceNLabel.Text = 'Force (N)';

            % Create Force
            app.Force = uieditfield(app.UIFigure, 'numeric');
            app.Force.Position = [103 403 100 22];

            % Create L12mLabel
            app.L12mLabel = uilabel(app.UIFigure);
            app.L12mLabel.HorizontalAlignment = 'right';
            app.L12mLabel.Position = [41 370 47 22];
            app.L12mLabel.Text = 'L12 (m)';

            % Create L12
            app.L12 = uieditfield(app.UIFigure, 'numeric');
            app.L12.Position = [103 370 100 22];

            % Create L23mLabel
            app.L23mLabel = uilabel(app.UIFigure);
            app.L23mLabel.HorizontalAlignment = 'right';
            app.L23mLabel.Position = [41 349 47 22];
            app.L23mLabel.Text = 'L23 (m)';

            % Create L23
            app.L23 = uieditfield(app.UIFigure, 'numeric');
            app.L23.Position = [103 349 100 22];

            % Create L13mLabel
            app.L13mLabel = uilabel(app.UIFigure);
            app.L13mLabel.HorizontalAlignment = 'right';
            app.L13mLabel.Position = [41 328 47 22];
            app.L13mLabel.Text = 'L13 (m)';

            % Create L13
            app.L13 = uieditfield(app.UIFigure, 'numeric');
            app.L13.Position = [103 328 100 22];

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Force'; 'Value (N)'};
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
            app.UITable2.ColumnName = {'L12'; 'L13'; 'L23'; 'R2x'; 'R2y'; 'R3y'};
            app.UITable2.RowName = {};
            app.UITable2.ColumnEditable = true;
            app.UITable2.Position = [272 264 479 193];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [202 479 545 56];
            app.Label.Text = {'Please input the force F, the lengths of the members L12, L23 and L13.'; 'The programme will then calculate the values of alpha and beta and display them to you.'; 'If you would like to change the coeffcient matrix, look to the table on the right and adjust as you like.'; 'Click "Find Forces" to calculate the values of the internal bar forces and the reaction forces.'};

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