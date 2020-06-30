require 'test_helper'

class ExpenseReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expense_report = expense_reports(:one)
  end

  test "should get index" do
    get expense_reports_url, as: :json
    assert_response :success
  end

  test "should create expense_report" do
    assert_difference('ExpenseReport.count') do
      post expense_reports_url, params: { expense_report: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show expense_report" do
    get expense_report_url(@expense_report), as: :json
    assert_response :success
  end

  test "should update expense_report" do
    patch expense_report_url(@expense_report), params: { expense_report: {  } }, as: :json
    assert_response 200
  end

  test "should destroy expense_report" do
    assert_difference('ExpenseReport.count', -1) do
      delete expense_report_url(@expense_report), as: :json
    end

    assert_response 204
  end
end
