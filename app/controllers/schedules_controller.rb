class SchedulesController < ApplicationController
    def index
        @schedules = Schedule.all
        @schedule_count = @schedules.count
        @today = Date.today
    end

    # 新規作成フォームの表示
    def new
        @schedule = Schedule.new
    end

    def show
        @schedule = Schedule.find(params[:id])
    end

    # 新規スケジュールの作成
    def create
        @schedule = Schedule.new(schedule_params)
        if @schedule.save
            flash[:notice] = 'スケジュールが作成されました。'
            redirect_to schedules_path
        else
            flash.now[:alert] = 'スケジュールの作成に失敗しました。'
            render :new
        end
    end

    def edit
        @schedule = Schedule.find(params[:id])
    end
    
    def update
       @schedule = Schedule.find(params[:id])
        if @schedule.update(schedule_params)
            flash[:notice] = 'スケジュールが更新されました。'
            redirect_to schedule_path(@schedule)
        else
            flash.now[:alert] = 'スケジュールの更新に失敗しました。'
            render :edit
        end
    end

    def destroy
        @schedule = Schedule.find(params[:id])
        @schedule.destroy
        flash[:notice] = 'スケジュールが削除されました。'
        redirect_to schedules_path
    end

    private

    # Strong Parametersの設定
    def schedule_params
        params.require(:schedule).permit(:title, :start_date, :end_date, :all_day, :schedule_memo)
    end
end
