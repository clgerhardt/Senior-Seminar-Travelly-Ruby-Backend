require 'test_helper'

class ExpenseCoveragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expense_coverage = expense_coverages(:one)
  end

  test "should get index" do
    get expense_coverages_url, as: :json
    assert_response :success
  end

  test "should create expense_coverage" do
    assert_difference('ExpenseCoverage.count') do
      post expense_coverages_url, params: { expense_coverage: {  amount: @expense_coverage. amount } }, as: :json
    end

    assert_response 201
  end

  test "should show expense_coverage" do
    get expense_coverage_url(@expense_coverage), as: :json
    assert_response :success
  end

  test "should update expense_coverage" do
    patch expense_coverage_url(@expense_coverage), params: { expense_coverage: {  amount: @expense_coverage. amount } }, as: :json
    assert_response 200
  end

  test "should destroy expense_coverage" do
    assert_difference('ExpenseCoverage.count', -1) do
      delete expense_coverage_url(@expense_coverage), as: :json
    end

    assert_response 204
  end
end
