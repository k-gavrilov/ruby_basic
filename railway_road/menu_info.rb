module MenuInfo
  MAIN_MENU = {
    message: 'Выберите с чем Вы хотите работать?',
    str_arr: ['0: Станции', '1: Поезда', '2: Маршруты', '3: Вагоны'],
    methods: {0 => :manip_station, 1 => :manip_train, 2 => :manip_route,
              3 => :manip_coach},
    top_level: true
  }.freeze
  STATION_MENU = {
    message: 'Выберите действие со станциями',
    str_arr: ['0: Создать', '1: Показать список всех станций',
              '2: Посмотреть список поездов на станции'],
    methods: {0 => :create_station, 1 => :show_station_list,
              2 => :show_trains_on_station}
  }.freeze
  TRAIN_MENU = {
    message: 'Выберите действие с поездами',
    str_arr: ['0: Создать', '1: Назначить маршрут поезду', '2: Добавить вагон',
              '3: Отцепить вагон', '4: Перечислить вагоны'],
    methods: {0 => :create_train, 1 => :assigne_route, 2 => :add_coach,
              3 => :remove_coach, 4 => :show_coaches}
  }.freeze
  ROUTE_MENU = {
    message: 'Выберите действие со маршрутами',
    str_arr: ['0: Создать', '1: Удалить станцию', '2: Добавить станицию'],
    methods: {0 => :create_route, 1 => :remove_station_in_route,
              3 => :add_station}
  }.freeze
  COACH_MENU = {
    message: 'Выберите действие со вагонами',
    str_arr: ['0: Создать', '1: Добавить нагрузку', '2: Занять место'],
    methods: {0 => :create_coach, 1 => :add_volume, 2 => :add_seat}
  }.freeze
end
