# Knights & Goblins: Realm Defense - Game Design Document

## 1. Game Overview
### 1.1 Concept
"Knight's Last Stand" is a dynamic, arcade-style tower defense game set within a medieval environment besieged by goblins. 
Players assume control of a single, upgradeable knight tower whose primary objective is to safeguard the realm against relentless waves of goblin invaders.

The gameplay emphasizes rapid decision-making and strategic enhancements as players strive to endure as many rounds as possible. 
The solitary knight tower can be upgraded in various aspects—such as attack power, speed, range, or the unlocking of specialized abilities—resulting in a comprehensive yet accessible upgrade system.

As the rounds progress, the goblin hordes increase in both number and difficulty, presenting a diverse array of enemy types ranging from basic grunts to formidable bosses. 
The challenge lies in selecting appropriate upgrades that correspond with the evolving threats while effectively managing resources between rounds.

With its straightforward premise coupled with engaging gameplay, "Knight's Last Stand" provides players with an opportunity to hone their skills, either by striving to surpass their own high scores or competing with friends for dominance in goblin-slaying. 
The streamlined design facilitates swift, action-oriented sessions that are well-suited for mobile devices or casual gaming experiences. 

### 1.2 Genre
Tower Defense

### 1.3 Target Audience
Primary: Casual Mobile Gamers
- Age Range: 25-40 years old
- Gaming Experience: Casual to mid-core
- Lifestyle: Busy professionals, parents, or students
- Preferences: Quick gaming sessions, personal challenge, progression

Audience Characteristics:
- Time-conscious: Appreciate short, engaging play sessions
- Challenge-seekers: Enjoy testing and improving skills
- Progression-oriented: Value clear upgrade paths and visible progress
- Casually competitive: Like comparing scores with friends/leaderboards
- Value-driven: Willing to spend on games they enjoy, but cautious about expenses

### 1.4 Game Flow Summary
1. Game Start:
   - Player launches the game
   - Brief tutorial introduces core mechanics (if first time playing)
   - Option to view high scores or start a new game

2. Wave Preparation:
   - Player starts with a basic knight tower
   - Brief overview of incoming goblin types for the first wave
   - Timer counts down to wave start

3. Wave Combat:
   - Goblins advance along the path towards the castle
   - Knight tower automatically attacks nearby goblins
   - Player can tap to activate any unlocked special abilities

4. Wave Completion:
   - Players earn gold based on performance
   - Experience points gained, potentially leveling up the player
   - Display of wave statistics (goblins defeated, gold earned, etc.)

5. Upgrade Phase:
   - Player presented with upgrade options for the knight tower
   - Options include attack power, speed, range, or special abilities
   - Limited time to make upgrade decisions before next wave

6. Subsequent Waves:
   - Steps 2-5 repeat with increasing difficulty
   - New goblin types introduced as waves progress
   - Periodic boss waves for increased challenge

7. Game Over:
   - Occurs when goblins overwhelm defenses and reach the castle
   - Final score displayed along with waves survived
   - Option to share score, return to main menu, or start a new game

## 2. Gameplay and Mechanics
### 2.1 Gameplay
#### 2.1.1 Game Progression
- Players start with a basic knight tower
- Survive increasingly difficult waves of goblins
- Earn gold and experience with each defeated goblin
- Use gold to upgrade tower between waves
- Game continues until the player is overwhelmed
- Meta-progression: Unlock permanent upgrades with meta-currency earned across multiple playthroughs


#### 2.1.2 Mission/Challenge Structure
- Endless mode: Survive as many waves as possible
- Waves increase in difficulty over time
- Boss waves occur every 10 rounds
- Daily challenges offer unique scenarios for bonus rewards

#### 2.1.3 Puzzle Structure
[Not applicable for this game]

### 2.2 Mechanics
#### 2.2.1 Tower Placement
- Single, fixed knight tower position
- No additional tower placement mechanics

#### 2.2.2 Resource Management
- Gold: Earned by defeating goblins, used for in-game upgrades
- Experience: Gained each wave, determines player level

#### 2.2.3 Wave Spawning
- Waves consist of various goblin types
- Enemy mix changes each wave
- Difficulty increases progressively
- Boss goblin appears every 10 waves

#### 2.2.4 Combat System
- Tower auto-attacks nearest goblin in range
- Upgradeable attack speed, damage, and range

#### 2.2.5 Upgrade System
- In-game upgrades available between waves
- Upgrade options: damage, speed, range, special abilities

#### 2.2.6 Scoring
- Points awarded for each goblin defeated
- Bonus points for completing waves
- High score tracking

## 3. Game Elements
### 3.1 Towers
#### 1 Basic Tower

1.1 Base statistics:
- Initial attack speed ( x1 )
- Damage ( 2 )
- Range ( 1.5u )

1.2 Visual description
Basic medieval, thick and high stone tower.

1.3 Visual changes with upgrades.
The tower not have visual changes. May be it could change it's color, scale or some basic proporty.

1.4 Possible upgrades and effects.
- Attack speed: Increse attack speed by 1.2. The tower throw arrows more quickly.
- Damage: Increase damage by 1. This upgrade will be more expensive. The tower deals more damage to enemies.
- Range: Increase range by 0.5u until it reach 5u. The tower attacks earlier.

### 3.2 Enemies
#### 1 Barrel

#### 2 TNT

#### 3 Torch

### 3.3 Items and Powerups
1. **Berserker Rage**: Dramatically increases attack speed for a short duration.

2. **Dragon's Breath**: Imbues attacks with fire, dealing area damage to groups of goblins.

3. **Frost Armor**: Temporarily freezes goblins that come in contact with the tower.

4. **Golden Touch**: Doubles gold earned from defeated goblins for a limited time.

5. **Healing Aura**: Slowly restores the tower's health over time.

6. **Thunderbolt**: Calls down lightning strikes on random goblins periodically.

7. **Time Warp**: Slows down all goblins on the screen for a short period.

8. **Reinforcements**: Summons temporary allied units to assist in defense.

9. **Multishot**: Allows the tower to attack multiple targets simultaneously.

10. **Goblin Bane**: Significantly increases damage against all goblin types.

11. **Midas Tower**: Converts defeated goblins into extra gold for a limited time.

12. **Arcane Barrier**: Creates a temporary forcefield that damages goblins that touch it.

13. **Whirlwind**: Pushes back all goblins on the screen and deals damage.

14. **Experience Boost**: Increases experience gained from defeating goblins for a duration.

15. **Chaos Orb**: Randomly applies different effects (stun, slow, damage) to goblins.

## 4. Story and Setting
### 4.1 Story
[Brief overview of the game's story, if any]

### 4.2 Game World
[Describe the setting and atmosphere of the game]

## 5. Interface
### 5.1 Visual System
[Describe the game's visual style and UI]

### 5.2 Control System
[Explain how the player controls the game]

### 5.3 Audio
[Describe the game's audio elements]

## 6. Technical Specifications
### 6.1 Target Hardware
[List the platforms the game will run on]

### 6.2 Development Software
[List the software used to create the game]

## 7. Game Art
[Describe the artistic style of the game, include concept art if available]
