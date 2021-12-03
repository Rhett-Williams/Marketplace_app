class PaymentController < ApplicationController

    def success
        @request = Request.find(params[:id])
    end

    def cancel
        @request = Request.find(params[:id])
    end

end