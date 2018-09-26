require 'terminal-table'
require 'colorize'

require_relative 'modules/info.rb'
require_relative 'system/route.rb'
require_relative 'system/loader.rb'
require_relative 'system/keeper.rb'
require_relative 'system/session.rb'
require_relative 'system/command_errors_manage.rb'
require 'byebug'

System::Loader.set_group group: :Err, path: "#{Dir.pwd}/exceptions"
System::Loader.set_group group: :Cli, path: "#{Dir.pwd}/cli"
System::Loader.set_group group: :Model, path: "#{Dir.pwd}/models"

# Чтобы вам было легче протестировать
keeper = System::Keeper.instance
station1 = Model::Station.new('hello1')
station2 = Model::Station.new('hello2')
station3 = Model::Station.new('hello3')
station4 = Model::Station.new('hello4')
station5 = Model::Station.new('hello5')
keeper.save_list(:station, [
  station1, station2, station3, station4, station5
])

route = Model::Route.new(station1, station3)
route.take_point_station(station2)
keeper.save_list(:route, [route])

cargo_wagon = Model::CargoWagon.new(111)
keeper.save_list(:cargo_wagon, [cargo_wagon])
passenger_wagon = Model::PassengerWagon.new(222)
keeper.save_list(:passenger_wagon, [passenger_wagon])

train1 = Model::CargoTrain.new('111-11')
keeper.save_list(:cargo_train, [train1])
train2 = Model::CargoTrain.new('222-22')
keeper.save_list(:passenger_train, [train2])

r = System::Route.new
r.register cli: Cli::StationList.new,    children: :stations
  r.register cli: Cli::StationList.new,    parent:   :stations
  r.register cli: Cli::StationAdd.new,     parent:   :stations
  r.register cli: Cli::StationDestroy.new, parent:   :stations
r.register cli: Cli::RouteList.new,      children: :routes
  r.register cli: Cli::RouteList.new,      parent:   :routes
  r.register cli: Cli::RouteAdd.new,       parent:   :routes
  r.register cli: Cli::RouteDestroy.new,   parent:   :routes
  r.register(
    cli:      Cli::RouteSet.new, 
    parent:   :routes,
    children: :route
  )
    r.register cli: Cli::RouteStationList.new,    parent: :route
    r.register cli: Cli::RouteStationAdd.new,     parent: :route
    r.register cli: Cli::RouteStationDestroy.new, parent: :route

r.register cli: Cli::WagonList.new,    children: :wagons
  r.register cli: Cli::WagonList.new,    parent:   :wagons
  r.register cli: Cli::WagonDestroy.new, parent:   :wagons
  r.register(
    cli:      Cli::CargoWagonList.new, 
    parent:   :wagons,
    children: :cargo_wagons
  )
    r.register cli: Cli::CargoWagonList.new, parent: :cargo_wagons
    r.register cli: Cli::CargoWagonAdd.new,  parent: :cargo_wagons

  r.register(
    cli:      Cli::PassengerWagonList.new, 
    parent:   :wagons,
    children: :passenger_wagons
  )
    r.register cli: Cli::PassengerWagonList.new, parent: :passenger_wagons
    r.register cli: Cli::PassengerWagonAdd.new,  parent: :passenger_wagons

r.register cli: Cli::TrainList.new,    children: :trains
  r.register cli: Cli::TrainList.new,    parent:   :trains
  r.register cli: Cli::TrainDestroy.new, parent:   :trains
  r.register(
    cli:      Cli::CargoTrainList.new, 
    parent:   :trains,
    children: :cargo_trains
  )
    r.register cli: Cli::CargoTrainList.new, parent: :cargo_trains
    r.register cli: Cli::CargoTrainAdd.new,  parent: :cargo_trains
    r.register(
      cli:      Cli::TrainSet.new(:cargo), 
      parent:   :cargo_trains,
      children: :cargo_train
    )
      r.register cli: Cli::TrainRouteSet.new,        parent: :cargo_train
      r.register cli: Cli::CargoTrainWagonAdd.new,   parent: :cargo_train
      r.register cli: Cli::TrainWagonDelete.new,     parent: :cargo_train
      r.register cli: Cli::TrainNextStation.new,     parent: :cargo_train
      r.register cli: Cli::TrainPreviousStation.new, parent: :cargo_train

  r.register(
    cli:      Cli::PassengerTrainList.new, 
    parent:   :trains,
    children: :passenger_trains
  )
    r.register cli: Cli::PassengerTrainList.new, parent: :passenger_trains
    r.register cli: Cli::PassengerTrainAdd.new,  parent: :passenger_trains
    r.register(
      cli:      Cli::TrainSet.new(:passenger), 
      parent:   :passenger_trains,
      children: :passenger_train
    )
      r.register cli: Cli::TrainRouteSet.new,          parent: :passenger_train
      r.register cli: Cli::PassengerTrainWagonAdd.new, parent: :passenger_train
      r.register cli: Cli::TrainWagonDelete.new,       parent: :passenger_train
      r.register cli: Cli::TrainNextStation.new,       parent: :passenger_train
      r.register cli: Cli::TrainPreviousStation.new,   parent: :passenger_train
r.observe

