# Taxi Job System

A complete taxi job system for FiveM servers.

## Features

- Taxi job management with duty toggle
- Fare calculation based on distance traveled
- Earnings tracking and storage in the database

## Requirements

- FiveM server
- ESX Framework
- MySQL database

## Installation

1. Download the script files.
2. Place them in your FiveM server's resources folder.
3. Add `ensure taxi_job_system` to your server.cfg file.
4. Import the database.sql file into your MySQL database.

## Usage

### Commands

| Command       | Description                     |
|---------------|---------------------------------|
| /toggletaxi   | Toggle taxi job status         |
| /toggleduty   | Toggle duty status             |
| /startfare    | Start a fare                   |
| /endfare      | End a fare and calculate fare  |

### Permissions

- Players must be assigned the taxi job in the ESX Framework.

## Configuration

The script can be configured in the `config.lua` file. Adjust the following settings:

- `TaxiJobName`: The name of the taxi job.
- `TaxiJobLabel`: The label for the taxi job.
- `TaxiJobGrade`: The grade for taxi drivers.
- `TaxiVehicleModel`: The model of the taxi vehicle.
- `TaxiVehicleSpawn`: The spawn location of the taxi vehicle.
- `TaxiVehicleHeading`: The heading of the taxi vehicle.
- `BaseFare`: The base fare for a ride.
- `PerMileRate`: The rate per mile for fare calculation.
- `MinimumFare`: The minimum fare for a ride.
- `TaxiJobBlip`: Configuration for the taxi job blip.
- `TaxiJobMarker`: Configuration for the taxi job marker.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=taxi-job-system&utm_content=bottom) — describe it in one sentence and get the full source code.