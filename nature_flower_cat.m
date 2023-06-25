% This code implements a basic estate planning service in MATLAB, enabling users to protect their assets and plan for the future.

%% Defining User Data

% Defining the user data structure
userData.name = '';
userData.age = 0;
userData.assets = [];
userData.liabilities = [];
userData.dependents = [];

%% Setting Up User Interface

% Creating a graphical user interface (GUI) to interact with user
figH = figure('Name','Estate Planning Service','NumberTitle','off','Position',[100 100 500 500],'Resize','off');

% Adding name, age, assets, liabilities, and dependents fields to the GUI
nameH = uicontrol('Style','edit','String',userData.name, 'Position',[100 470 200 20],'Callback',@name_callback);
ageH = uicontrol('Style','edit','String',userData.age, 'Position',[100 440 200 20],'Callback',@age_callback);
assetsH = uicontrol('Style','edit','String',userData.assets, 'Position',[100 410 200 20],'Callback',@assets_callback);
liabilitiesH = uicontrol('Style','edit','String',userData.liabilities, 'Position',[100 380 200 20],'Callback',@liabilities_callback);
dependentsH = uicontrol('Style','edit','String',userData.dependents, 'Position',[100 350 200 20],'Callback',@dependents_callback);

% Adding labels for the fields
uicontrol('Style','text','String','Name:','Position',[50 470 90 20]);
uicontrol('Style','text','String','Age:','Position',[50 440 90 20]);
uicontrol('Style','text','String','Assets:','Position',[50 410 90 20]);
uicontrol('Style','text','String','Liabilities:','Position',[50 380 90 20]);
uicontrol('Style','text','String','Dependents:','Position',[50 350 90 20]);

% Adding exit and continue buttons to the GUI
exitH = uicontrol('Style','pushbutton','String','Exit','Position',[200 100 100 20],'Callback',@exit_callback);
continueH = uicontrol('Style','pushbutton','String','Continue','Position',[300 100 100 20],'Callback',@continue_callback);

% Defining GUI callbacks
    function name_callback(hObject,~)
        userData.name = get(hObject,'String');
        disp(userData.name);
    end

    function age_callback(hObject,~)
        try
            userData.age = str2double(get(hObject,'String'));
            if isempty(userData.age)
                userData.age = 0;
            end
            disp(userData.age);
        catch
            disp('Error: Age must be a number.');
        end
    end

    function assets_callback(hObject,~)
        try
            userData.assets = str2num(get(hObject,'String'));
            if isempty(userData.assets)
                userData.assets = [];
            end
            disp(userData.assets);
        catch
            disp('Error: Assets must be numbers.');
        end
    end

    function liabilities_callback(hObject,~)
        try
            userData.liabilities = str2num(get(hObject,'String'));
            if isempty(userData.liabilities)
                userData.liabilities = [];
            end
            disp(userData.liabilities);
        catch
            disp('Error: Liabilities must be numbers.');
        end
    end

    function dependents_callback(hObject,~)
        userData.dependents = get(hObject,'String');
        disp(userData.dependents);
    end

    function exit_callback(~,~)
        clearvars figH nameH ageH assetsH liabilitiesH dependentsH exitH continueH userData;
        close;
    end

    function continue_callback(~,~)
        % Check if user has entered valid data
        if isempty(userData.name) || userData.age == 0 || isempty(userData.assets) || isempty(userData.liabilities) || isempty(userData.dependents)
            disp('Error: Please fill out all fields before continuing.');
            return;
        end
        
        % Calculate user's net worth
        netWorth = sum(userData.assets) - sum(userData.liabilities);
        
        % Display user's data on the GUI
        set(nameH,'String',userData.name);
        set(ageH,'String',num2str(userData.age));
        set(assetsH,'String',num2str(userData.assets));
        set(liabilitiesH,'String',num2str(userData.liabilities));
        set(dependentsH,'String',userData.dependents);
        uicontrol('Style','text','String',['Net Worth: $' num2str(netWorth)], 'Position',[50 320 90 20]);
        
        % Provide recommendations
        if netWorth > 0
            disp('Recommendations: Set up a trust, create a will, and consider life insurance.');
        elseif netWorth == 0
            disp('Recommendations: Consider life insurance and draw up a will.');
        else
            disp('Recommendations: Consider life insurance and debt management strategies.');
        end
    end

%% Running the Application

% Run the application
uiwait(figH);