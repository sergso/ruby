require 'test_helper'

class RStationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @r_station = r_stations(:one)
  end

  test "should get index" do
    get r_stations_url
    assert_response :success
  end

  test "should get new" do
    get new_r_station_url
    assert_response :success
  end

  test "should create r_station" do
    assert_difference('RStation.count') do
      post r_stations_url, params: { r_station: { title: @r_station.title } }
    end

    assert_redirected_to r_station_url(RStation.last)
  end

  test "should show r_station" do
    get r_station_url(@r_station)
    assert_response :success
  end

  test "should get edit" do
    get edit_r_station_url(@r_station)
    assert_response :success
  end

  test "should update r_station" do
    patch r_station_url(@r_station), params: { r_station: { title: @r_station.title } }
    assert_redirected_to r_station_url(@r_station)
  end

  test "should destroy r_station" do
    assert_difference('RStation.count', -1) do
      delete r_station_url(@r_station)
    end

    assert_redirected_to r_stations_url
  end
end
