# CREATE DATABASE
CREATE DATABASE IF NOT EXISTS `twitter`;

DROP DATABASE IF EXISTS `twitter`;

USE twitter;

# BUILD SCHEMA

	# Create Table
	CREATE TABLE `users` (
		id INTEGER AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50),
        created_at TIMESTAMP DEFAULT NOW()
    );
    
    # Drop Table
    DROP TABLE IF EXISTS `users`;
    
    
    # Create Tweets
    CREATE TABLE `tweets` (
		id INTEGER AUTO_INCREMENT PRIMARY KEY,
        body TEXT NOT NULL,
        user_id INTEGER,
        created_at TIMESTAMP DEFAULT NOW(),
		FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
    
    # Drop Table Tweets
    DROP TABLE IF EXISTS `tweets`;
    
    # Create Replies
	CREATE TABLE IF NOT EXISTS `replies` (
		id INTEGER AUTO_INCREMENT PRIMARY KEY,
        body TEXT NOT NULL,
        user_id INT,
        tweet_id INT,
        created_at TIMESTAMP DEFAULT NOW(),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (tweet_id) REFERENCES tweets(id) ON DELETE CASCADE
    );
    
     # Drop Replies
    DROP TABLE IF EXISTS `replies`;
    


# INSERT DATA

	# Users
	INSERT INTO `users` (username) 
				VALUES ('Bilal'),('Alex'),('John'),('Jany');
                
	# Tweeets
    INSERT INTO `tweets` (body, user_id) 
				VALUES  ('Nice Weather', 1),('CSS is Hard?..', 1),
						('PHP is better?', 2),('Nice read on SQL', 2),
                        ('Writing good codes', 4),('How to store', 4),
                        ('Lets make some screen casts', 4);
                        
	# Replies
    INSERT INTO `replies` (body, user_id, tweet_id)
				VALUES ('Agree!!', 4, 2), ('Yes it is hard', 1, 2),
                ('Not hard..!!', 1, 1), ('Off it is better', 2, 3),
                ('Nice read too good!!', 3, 4), ('Nice article..', 2,5),
                ('Looking forward!!', 4, 7), ('On which topic?', 3, 7);



# SHOW

	# User -> Tweets
    SELECT 
			tweets.id AS TweetID,
			tweets.body As Tweet,
			users.username AS 'User',
            tweets.created_at AS TweetDate
        FROM `tweets`
        JOIN users ON tweets.user_id = users.id ORDER BY tweets.created_at DESC;
    
    
    # Tweets -> Replies -> User
    SELECT 
			tweets.body AS 'Tweet',
			replies.body AS 'Reply',
            users.username AS 'User'
		FROM `tweets`
        JOIN replies ON replies.tweet_id = tweets.id
        JOIN users ON replies.user_id = users.id;
    
		
    # User -> Replies
    SELECT 
			users.username 'UserName',
			replies.body 'Reply',
			replies.created_at 'Tweeted At'
        FROM replies
		JOIN users on replies.user_id = users.id
        JOIN tweets on replies.tweet_id = tweets.id;
    