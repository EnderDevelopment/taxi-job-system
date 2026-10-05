CREATE TABLE IF NOT EXISTS taxi_job (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    total_earnings FLOAT DEFAULT 0,
    total_rides INT DEFAULT 0,
    last_ride TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_player_id FOREIGN KEY (player_id) REFERENCES users(identifier) ON DELETE CASCADE
);

INSERT INTO taxi_job (player_id) SELECT identifier FROM users WHERE identifier NOT IN (SELECT player_id FROM taxi_job);