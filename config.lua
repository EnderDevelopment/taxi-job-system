Config = {}

-- Taxi Job Configuration
Config.TaxiJobName = 'taxi'
Config.TaxiJobLabel = 'Taxi Driver'
Config.TaxiJobGrade = 'driver'

-- Taxi Vehicle Configuration
Config.TaxiVehicleModel = 'taxi'
Config.TaxiVehicleSpawn = vector3(904.74, -173.26, 74.07)
Config.TaxiVehicleHeading = 225.0

-- Taxi Fare Configuration
Config.BaseFare = 50
Config.PerMileRate = 2.5
Config.MinimumFare = 100

-- Taxi Job Blip Configuration
Config.TaxiJobBlip = {
    sprite = 198,
    color = 5,
    scale = 1.0,
    label = 'Taxi Job'
}

-- Taxi Job Marker Configuration
Config.TaxiJobMarker = {
    type = 1,
    color = { r = 0, g = 255, b = 0, a = 100 },
    scale = { x = 1.5, y = 1.5, z = 1.0 },
    position = vector3(904.74, -173.26, 74.07)
}