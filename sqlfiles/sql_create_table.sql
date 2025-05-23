drop database mbta
create database mbta

use mbta

-- DROP TABLES IF EXIST
DROP TABLE IF EXISTS vehicles_data;
DROP TABLE IF EXISTS vehicles_data_history;
DROP TABLE IF EXISTS statuses;
DROP TABLE IF EXISTS destinations_routes_bridge;
DROP TABLE IF EXISTS direction_names_routes_bridge;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS direction_names;
DROP TABLE IF EXISTS directions;
DROP TABLE IF EXISTS destinations;
DROP TABLE IF EXISTS lines;
DROP TABLE IF EXISTS colors;
DROP TABLE IF EXISTS stops;
DROP TABLE IF EXISTS streets;
DROP TABLE IF EXISTS municipalities;

-- CREATE TABLES

CREATE TABLE statuses (
    status_id INT IDENTITY(1,1) PRIMARY KEY,
    status VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE streets (
    street_id INT IDENTITY(1,1) PRIMARY KEY,
    street VARCHAR(128) UNIQUE NOT NULL
);

CREATE TABLE directions (
    direction_id INT IDENTITY(1,1) PRIMARY KEY,
    direction VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE direction_names (
    direction_name_id INT IDENTITY(1,1) PRIMARY KEY,
    direction_name VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE municipalities (
    municipality_id INT IDENTITY(1,1) PRIMARY KEY,
    municipality VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE destinations (
    destination_id INT IDENTITY(1,1) PRIMARY KEY,
    destination VARCHAR(128) UNIQUE NOT NULL
);

CREATE TABLE colors (
    color_id INT IDENTITY(1,1) PRIMARY KEY,
    color VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE lines (
    line_id VARCHAR(128) PRIMARY KEY,
    long_name VARCHAR(128),
    short_name VARCHAR(128),
    color INT,
    text_color INT,
    FOREIGN KEY (color) REFERENCES colors(color_id),
    FOREIGN KEY (text_color) REFERENCES colors(color_id)
);

CREATE TABLE stops (
    stop_id VARCHAR(128) PRIMARY KEY,
    name VARCHAR(256),
    address VARCHAR(256),
    description VARCHAR(256),
    latitude FLOAT,
    longitude FLOAT,
    municipality_id INT,
    at_street INT,
    on_street INT,
    FOREIGN KEY (municipality_id) REFERENCES municipalities(municipality_id),
    FOREIGN KEY (at_street) REFERENCES streets(street_id),
    FOREIGN KEY (on_street) REFERENCES streets(street_id)
);

CREATE TABLE routes (
    route_id VARCHAR(32) PRIMARY KEY,
    description VARCHAR(32),
    fare_class VARCHAR(32),
    long_name VARCHAR(128),
    short_name VARCHAR(32),
    direction_id INT,
    destination_id INT,
    line_id VARCHAR(128),
    color INT,
    text_color INT,
    FOREIGN KEY (direction_id) REFERENCES directions(direction_id),
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id),
    FOREIGN KEY (line_id) REFERENCES lines(line_id),
    FOREIGN KEY (color) REFERENCES colors(color_id),
    FOREIGN KEY (text_color) REFERENCES colors(color_id)
);

CREATE TABLE vehicles_data (
    vehicle_data_id INT IDENTITY(1,1) PRIMARY KEY,
    vehicle_id VARCHAR(128) NOT NULL,
    bearing INT,
    current_stop_sequence INT,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    speed FLOAT,
    updated_at DATETIME NOT NULL,
    direction_id INT,
    route_id VARCHAR(32),
    label VARCHAR(128),
    current_status INT,
    stop_id VARCHAR(128),
    FOREIGN KEY (direction_id) REFERENCES directions(direction_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (current_status) REFERENCES statuses(status_id)
    -- note: foreign key to stops.stop_id skipped (can be added if needed)
);

CREATE TABLE vehicles_data_history (
    vehicle_data_history_id INT IDENTITY(1,1) PRIMARY KEY,
    vehicle_id VARCHAR(128) NOT NULL,
    vehicle_data_id INT UNIQUE,
    bearing INT,
    current_stop_sequence INT,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    speed FLOAT,
    updated_at DATETIME NOT NULL,
    direction_id INT,
    route_id VARCHAR(32),
    label VARCHAR(128),
    current_status INT,
    stop_id VARCHAR(128),
    FOREIGN KEY (direction_id) REFERENCES directions(direction_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (current_status) REFERENCES statuses(status_id)
);

CREATE TABLE destinations_routes_bridge (
    route_id VARCHAR(32) NOT NULL,
    destination_id INT NOT NULL,
    PRIMARY KEY (route_id, destination_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id)
);

CREATE TABLE direction_names_routes_bridge (
    route_id VARCHAR(32) NOT NULL,
    direction_name_id INT NOT NULL,
    PRIMARY KEY (route_id, direction_name_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (direction_name_id) REFERENCES direction_names(direction_name_id)
);
