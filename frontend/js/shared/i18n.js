/**
 * Simple i18n translation manager
 * Supports: en (English), fr (French), es (Spanish)
 */
class I18nManager {
    constructor() {
        this.currentLanguage = 'en';
        this.translations = {
            en: {
                nav: {
                    albumOfDay: 'Album of the Day',
                    randomAlbum: 'Random album',
                    coverGuess: 'Cover Guess',
                    ranking: 'Daily Album Ranking',
                    coverGuessRanking: 'Cover Guess Ranking',
                    archives: 'All albums',
                    profile: 'Profile',
                    myStatistics: 'My statistics',
                    reportBug: 'Report a Bug'
                },
                auth: {
                    login: 'Connection / Sign up',
                    logout: 'Log out',
                    viewProfile: 'View Profile'
                },
                genreFilter: {
                    title: 'Filter by Genre',
                    allGenres: 'All Genres',
                    confirmReset: 'Changing the genre filter will start a new game. Continue?'
                },
                game: {
                    searchPlaceholder: 'Search an album or an artist...',
                    makeGuess: 'To find the album of the day, make a first guess in the search bar<br>to start revealing the first clues.',
                    guessCounter: 'guesses',
                    guessCounterSingle: 'guess',
                    cluesRevealed: 'clue(s)',
                    cluesDiscovered: 'Clues discovered:',
                    newMystery: 'To find the mystery album, make a first guess in the search bar<br>to start revealing the first clues.',
                    unknownArtist: 'Unknown artist',
                    guessesNeeded: 'Guesses needed:',
                    challengeLink: 'Challenge link copied to clipboard!',
                    subtitle: 'Mystery Album - New album on each refresh',
                    albumQuestion: 'What is the album of the day?',
                    shareResult: 'Share your result',
                    victoryMessage: 'You found the album of the day! Come back tomorrow for a new mystery album!',
                    instructions: {
                        title: 'How to play',
                        search: {
                            title: 'Search and submit',
                            text: 'Type the name of an album or a song and submit it as a guess'
                        },
                        reveal: {
                            title: 'Reveal clues',
                            text: 'Each guess reveals attributes shared with the mystery album: artist, genre, year, label...'
                        },
                        narrow: {
                            title: 'Narrow it down',
                            text: 'Use accumulated clues to eliminate possibilities and get closer to the mystery album'
                        },
                        find: {
                            title: 'Find the mystery album',
                            text: 'When you identify the right album, you win! A new mystery awaits every day',
                            textRandom: 'When you identify the right album, you win! A new mystery awaits on each refresh'
                        },
                        rules: 'Game rules',
                        rule1: 'No limit on guesses — explore as much as you like',
                        rule2: 'Clues only show similarities, never differences',
                        rule3: 'One mystery album per day',
                        rule3Random: 'A new mystery album on every refresh',
                        rule4: 'Free game open to everyone'
                    },
                    victory: {
                        title: 'Congratulations!',
                        titleDaily: 'Congratulations! You found the album of the day!',
                        message: 'Come back tomorrow for a new mystery album!',
                        messageRandom: 'Refresh the page and find another one!',
                        showRankings: 'Show Rankings',
                        challengeFriend: 'Challenge a friend',
                        playAgain: 'Play Again',
                        playPastDailies: 'Play more past daily albums'
                    },
                    noClues: 'Make a first guess to reveal clues...',
                    loading: 'Loading the album of the day...',
                    loadingRandom: 'Loading mystery album...',
                    albumOfDayLabel: 'Album of the day',
                    gameModeDaily: 'Daily',
                    gameModeRandom: 'Random',
                    gameModeCoverGuess: 'Cover Guess',
                    gameModeDailyTitle: 'Album of the day',
                    gameModeRandomTitle: 'Random album',
                    gameModeCoverGuessTitle: 'Cover Guess',
                    coverGuess: {
                        nextHint: 'Reveal next square',
                        loading: 'Loading the mystery album...',
                        victoryMessage: 'You found the album!',
                        defeatMessage: 'You didn\'t find it, it was:',
                        points: 'Points:',
                        rankingLine1: 'You are <strong>#{position}</strong> in the ranking',
                        rankingLine2: 'with <strong>{points} points</strong>',
                        rankingLine1Loading: 'You are <strong>#-</strong> in the ranking',
                        rankingLine2Loading: 'with <strong>- points</strong>',
                        playAgain: 'Play again',
                        viewRanking: 'View ranking'
                    },
                    clueCategories: {
                        artists: 'Artists',
                        artist_type: 'Type',
                        genres: 'Genres',
                        release_year: 'Year',
                        total_length_seconds: 'Length',
                        countries: 'Countries',
                        continents: 'Continents',
                        contributors: 'Contributors',
                        instruments: 'Instruments',
                        label: 'Label'
                    },
                    artistTypes: {
                        solo: 'solo artist',
                        group: 'group'
                    },
                    guessLabels: {
                        before: 'before',
                        after: 'after',
                        shorter: 'shorter',
                        longer: 'longer',
                        shorterThan: 'shorter than',
                        longerThan: 'longer than',
                        beforeYear: 'before',
                        afterYear: 'after',
                        between: 'between',
                        and: 'and'
                    },
                    chipLabels: {
                        hit: 'Match',
                        miss: 'No match'
                    },
                    continents: {
                        'Africa': 'Africa',
                        'Europe': 'Europe',
                        'Asia': 'Asia',
                        'North America': 'North America',
                        'South America': 'South America',
                        'Oceania': 'Oceania',
                        'Antarctica': 'Antarctica'
                    },
                    instruments: {
                        'Guitar': 'Guitar',
                        'Electric Guitar': 'Electric Guitar',
                        'Acoustic Guitar': 'Acoustic Guitar',
                        'Bass': 'Bass',
                        'Bass Guitar': 'Bass Guitar',
                        'Double Bass': 'Double Bass',
                        'Upright Bass': 'Upright Bass',
                        'Drums': 'Drums',
                        'Drum Kit': 'Drum Kit',
                        'Piano': 'Piano',
                        'Vocals': 'Vocals',
                        'Synthesizer': 'Synthesizer',
                        'Violin': 'Violin',
                        'Viola': 'Viola',
                        'Trumpet': 'Trumpet',
                        'Saxophone': 'Saxophone',
                        'Alto Saxophone': 'Alto Saxophone',
                        'Tenor Saxophone': 'Tenor Saxophone',
                        'Flute': 'Flute',
                        'Cello': 'Cello',
                        'Organ': 'Organ',
                        'Keyboards': 'Keyboards',
                        'Percussion': 'Percussion',
                        'Harp': 'Harp',
                        'Clarinet': 'Clarinet',
                        'Trombone': 'Trombone',
                        'Tuba': 'Tuba',
                        'French Horn': 'French Horn',
                        'Oboe': 'Oboe',
                        'Bassoon': 'Bassoon',
                        'Harmonica': 'Harmonica',
                        'Accordion': 'Accordion',
                        'Banjo': 'Banjo',
                        'Mandolin': 'Mandolin',
                        'Ukulele': 'Ukulele',
                        'Xylophone': 'Xylophone',
                        'Marimba': 'Marimba',
                        'Congas': 'Congas',
                        'Bongos': 'Bongos',
                        'Tambourine': 'Tambourine',
                        'Triangle': 'Triangle',
                        'Cymbals': 'Cymbals'
                    }
                },
                profile: {
                    title: 'Profile Settings',
                    subtitle: 'Manage your account information',
                    subtitleOverview: 'Manage your profile and view your statistics',
                    subtitleHistory: 'Your saved wins and recent history',
                    currentUsername: 'Current username:',
                    changeUsername: 'Change username',
                    placeholder: 'Enter new username',
                    saveButton: 'Save Username',
                    foundAlbums: 'Your found albums',
                    historySubtitle: 'Log in to save and see your history',
                    historySubtitleAuthed: 'Recent wins saved to your account',
                    yourStats: 'Your statistics',
                    statsSubtitle: 'Log in to see your stats',
                    statsSubtitleAuthed: 'Your personal game stats',
                    noHistory: 'No wins saved yet. Find a mystery album!',
                    historyError: 'Unable to load history. Try again later.'
                },
                stats: {
                    totalWins: 'Total Wins',
                    averageAttempts: 'Avg Attempts',
                    bestPerformance: 'Best Performance',
                    favoriteGenre: 'Favorite Genre',
                    recentWins: 'Recent Wins',
                    albumsFound: 'Albums found',
                    fastestWin: 'Fastest win',
                    slowestWin: 'Slowest win',
                    averageGuesses: 'Average guesses',
                    bestStreak: 'Best streak',
                    currentStreak: 'Current streak',
                    oldestWinYear: 'Oldest win year',
                    newestWinYear: 'Newest win year',
                    averageYear: 'Average year',
                    guess: 'guess',
                    guesses: 'guesses',
                    day: 'day',
                    days: 'days'
                },
                ranking: {
                    title: 'Daily Album Ranking',
                    subtitle: 'Top players of the day',
                    subtitleDetail: 'Here are the players who found the daily album the fastest.',
                    rank: 'Rank',
                    username: 'Username',
                    attempts: 'Attempts',
                    duration: 'Duration',
                    time: 'Time',
                    empty: 'No rankings yet for today.',
                    emptyAction: 'Be the first to find the album!',
                    loading: 'Loading ranking...',
                    error: 'Failed to load ranking'
                },
                bug: {
                    title: 'Report a Bug',
                    subtitle: 'Help us improve by reporting bugs you encounter',
                    subtitleDetail: 'Fill in the details below and we\'ll investigate',
                    formTitle: 'Title',
                    formDescription: 'Description',
                    formEmail: 'Your Email',
                    formSubmit: 'Submit Bug Report',
                    placeholderTitle: 'Brief description of the bug',
                    placeholderDescription: 'Please describe the bug in detail: what you were doing, what happened, and what you expected to happen',
                    placeholderEmail: 'your.email@example.com',
                    submitting: 'Submitting bug report...',
                    success: 'Thank you! Your bug report has been submitted successfully. We will investigate and get back to you if needed.',
                    error: 'Failed to submit bug report. Please try again later.'
                },
                admin: {
                    title: 'Add/Update Mystery Album',
                    subtitle: 'Schedule an album for the daily challenge',
                    subtitleOverview: 'Manage mystery album schedule',
                    scheduleListTitle: 'Mystery Album Schedule',
                    scheduleSubtitle: 'All scheduled mystery albums',
                    date: 'Date',
                    search: 'Search for an album',
                    placeholder: 'Type album or artist name...',
                    selectedAlbum: 'Selected Album',
                    submit: 'Save',
                    loading: 'Loading schedule...',
                    success: 'Album scheduled successfully!',
                    error: 'Failed to schedule album'
                },
                archive: {
                    title: 'Album Archives',
                    subtitle: 'Play past daily albums you haven\'t completed',
                    loginWarning: 'Connect to save your history.',
                    empty: 'No past daily albums available yet.',
                    completed: 'Completed',
                    play: 'Play',
                    future: 'Coming soon'
                },
                common: {
                    submit: 'Submit',
                    cancel: 'Cancel',
                    loading: 'Loading...',
                    error: 'Error',
                    success: 'Success',
                    close: 'Close',
                    save: 'Save',
                    delete: 'Delete',
                    edit: 'Edit',
                    back: 'Back',
                    next: 'Next',
                    previous: 'Previous'
                },
                footer: {
                    howToPlay: 'How to play',
                    tagline: 'A musical deduction game • Inspired by'
                },
                howToPlay: {
                    title: 'How to Play',
                    dailyGame: {
                        title: 'Album of the Day / Random Album',
                        search: {
                            title: 'Search and submit',
                            text: 'Type the name of an album or an artist or group in the search field. Select a result from the list and submit it as a guess.'
                        },
                        reveal: {
                            title: 'Reveal clues',
                            text: 'Each guess reveals attributes shared with the mystery album: artist(s), genre(s), year, label, country, duration, etc. Clues only show similarities, never differences.'
                        },
                        narrow: {
                            title: 'Narrow it down',
                            text: 'Use accumulated clues to eliminate possibilities and get closer to the mystery album. The more guesses you make, the more clues you accumulate!'
                        },
                        find: {
                            title: 'Find the mystery album',
                            text: 'When you identify the right album, you win! A new mystery awaits every day (album of the day) or on each refresh (random album).'
                        },
                        rules: 'Game rules',
                        rule1: 'No limit on guesses — explore as much as you like',
                        rule2: 'Clues only show similarities, never differences',
                        rule3: 'One mystery album per day (album of the day) or on each refresh (random album)',
                        rule5: 'Progress is only saved if you are logged in'
                    },
                    coverGuess: {
                        title: 'Cover Guess',
                        grid: {
                            title: '4x4 Grid',
                            text: 'The mystery album cover is hidden in a 16-square grid (4x4). At the start, one square is revealed.'
                        },
                        reveal: {
                            title: 'Reveal squares',
                            text: 'Each guess reveals a new square of the cover in random order. Use the "Reveal next square" button to get an additional clue. Note: each revealed square deducts 1 point from your starting total of 15 points.'
                        },
                        search: {
                            title: 'Search for the album',
                            text: 'Type the name of an album or an artist in the search field and submit your guess. The more squares you reveal, the more visual clues you have!'
                        },
                        points: {
                            title: 'Points system',
                            text: 'You start with a total of 15 points. The faster you find the album, the more points you earn! Each discovered square deducts 1 point from your total, so fewer guesses and fewer revealed squares = more points. A ranking is available to see your position.'
                        },
                        rules: 'Game rules',
                        rule1: 'No daily limit, play as much as you want',
                        rule2: 'You can reveal up to 16 squares (the entire cover)',
                        rule3: 'Points are calculated based on the number of guesses and revealed squares',
                        rule4: 'A new mystery on each refresh',
                        rule5: 'You must be logged in to participate in the ranking'
                    }
                },
                pageTitles: {
                    albumOfDay: 'AlbumGuessr - Album of the Day',
                    randomAlbum: 'AlbumGuessr - Discover the mystery album',
                    coverGuess: 'AlbumGuessr - Cover Guess',
                    howToPlay: 'AlbumGuessr - How to Play',
                    profile: 'AlbumGuessr - Profile',
                    ranking: 'AlbumGuessr - Daily Album Ranking',
                    statistics: 'AlbumGuessr - Statistics',
                    admin: 'AlbumGuessr - Admin Dashboard',
                    reportBug: 'AlbumGuessr - Report a Bug'
                }
            },
            fr: {
                nav: {
                    albumOfDay: 'Album du jour',
                    randomAlbum: 'Album aléatoire',
                    coverGuess: 'Devine la Pochette',
                    ranking: 'Classement album du jour',
                    coverGuessRanking: 'Classement Cover guess',
                    archives: 'Les anciens albums du jour',
                    profile: 'Profil',
                    myStatistics: 'Mes statistiques',
                    reportBug: 'Signaler un bug'
                },
                auth: {
                    login: 'Connexion / Inscription',
                    logout: 'Se déconnecter',
                    viewProfile: 'Voir le profil'
                },
                genreFilter: {
                    title: 'Filtrer par genre',
                    allGenres: 'Tous les genres',
                    confirmReset: 'Changer le filtre de genre démarrera une nouvelle partie. Continuer ?'
                },
                game: {
                    searchPlaceholder: 'Rechercher un album ou un artiste...',
                    makeGuess: 'Pour trouver l\'album du jour, faites une première proposition dans la barre de recherche<br>pour commencer à révéler les premiers indices.',
                    guessCounter: 'tentatives',
                    guessCounterSingle: 'tentative',
                    cluesRevealed: 'indice(s)',
                    cluesDiscovered: 'Indices découverts :',
                    newMystery: 'Pour trouver l\'album mystère, faites une première proposition dans la barre de recherche<br>pour commencer à révéler les premiers indices.',
                    unknownArtist: 'Artiste inconnu',
                    guessesNeeded: 'Tentatives nécessaires :',
                    challengeLink: 'Lien de défi copié dans le presse-papiers !',
                    subtitle: 'Album Mystère - Nouvel album à chaque actualisation',
                    albumQuestion: 'Quel est l\'album du jour ?',
                    shareResult: 'Partager votre résultat',
                    victoryMessage: 'Vous avez trouvé l\'album du jour ! Revenez demain pour un nouvel album mystère !',
                    instructions: {
                        title: 'Comment jouer',
                        search: {
                            title: 'Rechercher et soumettre',
                            text: 'Tapez le nom d\'un album ou d\'une chanson et soumettez-le comme tentative'
                        },
                        reveal: {
                            title: 'Révéler les indices',
                            text: 'Chaque tentative révèle les attributs partagés avec l\'album mystère : artiste, genre, année, label...'
                        },
                        narrow: {
                            title: 'Affiner la recherche',
                            text: 'Utilisez les indices accumulés pour éliminer les possibilités et vous rapprocher de l\'album mystère'
                        },
                        find: {
                            title: 'Trouver l\'album mystère',
                            text: 'Quand vous identifiez le bon album, vous gagnez ! Un nouveau mystère vous attend chaque jour',
                            textRandom: 'Quand vous identifiez le bon album, vous gagnez ! Un nouveau mystère vous attend à chaque actualisation'
                        },
                        rules: 'Règles du jeu',
                        rule1: 'Aucune limite de tentatives — explorez autant que vous le souhaitez',
                        rule2: 'Les indices montrent uniquement les similitudes, jamais les différences',
                        rule3: 'Un album mystère par jour',
                        rule3Random: 'Un nouvel album mystère à chaque actualisation',
                        rule4: 'Jeu gratuit ouvert à tous'
                    },
                    victory: {
                        title: 'Félicitations !',
                        titleDaily: 'Félicitations ! Vous avez trouvé l\'album du jour !',
                        message: 'Revenez demain pour un nouvel album mystère !',
                        messageRandom: 'Rafraîchissez la page et trouvez-en un autre !',
                        showRankings: 'Voir le classement',
                        challengeFriend: 'Défier un ami',
                        playAgain: 'Rejouer',
                        playPastDailies: 'Rejouer aux anciens albums du jour'
                    },
                    noClues: 'Faites une première tentative pour révéler les indices...',
                    loading: 'Chargement de l\'album du jour...',
                    loadingRandom: 'Chargement de l\'album mystère...',
                    albumOfDayLabel: 'Album du jour',
                    gameModeDaily: 'Quotidien',
                    gameModeRandom: 'Aléatoire',
                    gameModeCoverGuess: 'Cover Guess',
                    gameModeDailyTitle: 'Album du jour',
                    gameModeRandomTitle: 'Album aléatoire',
                    gameModeCoverGuessTitle: 'Cover Guess',
                    coverGuess: {
                        nextHint: 'Révéler le carré suivant',
                        loading: 'Chargement de l\'album mystère...',
                        victoryMessage: 'Vous avez trouvé l\'album !',
                        defeatMessage: 'Vous n\'avez pas trouvé, c\'était :',
                        points: 'Points :',
                        rankingLine1: 'Vous êtes <strong>#{position}</strong> au classement',
                        rankingLine2: 'avec <strong>{points} points</strong>',
                        rankingLine1Loading: 'Vous êtes <strong>#-</strong> au classement',
                        rankingLine2Loading: 'avec <strong>- points</strong>',
                        playAgain: 'Rejouer',
                        viewRanking: 'Voir le classement'
                    },
                    clueCategories: {
                        artists: 'Artistes',
                        artist_type: 'Type',
                        genres: 'Genres',
                        release_year: 'Année',
                        total_length_seconds: 'Durée',
                        countries: 'Pays',
                        continents: 'Continents',
                        contributors: 'Contributeurs',
                        instruments: 'Instruments',
                        label: 'Label'
                    },
                    artistTypes: {
                        solo: 'artiste solo',
                        group: 'groupe'
                    },
                    guessLabels: {
                        before: 'avant',
                        after: 'après',
                        shorter: 'plus court',
                        longer: 'plus long',
                        shorterThan: 'plus court que',
                        longerThan: 'plus long que',
                        beforeYear: 'avant',
                        afterYear: 'après',
                        between: 'entre',
                        and: 'et'
                    },
                    chipLabels: {
                        hit: 'Correspond',
                        miss: 'Ne correspond pas'
                    },
                    continents: {
                        'Africa': 'Afrique',
                        'Europe': 'Europe',
                        'Asia': 'Asie',
                        'North America': 'Amérique du Nord',
                        'South America': 'Amérique du Sud',
                        'Oceania': 'Océanie',
                        'Antarctica': 'Antarctique'
                    },
                    instruments: {
                        'Guitar': 'Guitare',
                        'Electric Guitar': 'Guitare électrique',
                        'Acoustic Guitar': 'Guitare acoustique',
                        'Bass': 'Basse',
                        'Bass Guitar': 'Guitare basse',
                        'Double Bass': 'Contrebasse',
                        'Upright Bass': 'Contrebasse',
                        'Drums': 'Batterie',
                        'Drum Kit': 'Batterie',
                        'Piano': 'Piano',
                        'Vocals': 'Voix',
                        'Synthesizer': 'Synthétiseur',
                        'Violin': 'Violon',
                        'Viola': 'Alto',
                        'Trumpet': 'Trompette',
                        'Saxophone': 'Saxophone',
                        'Alto Saxophone': 'Saxophone alto',
                        'Tenor Saxophone': 'Saxophone ténor',
                        'Flute': 'Flûte',
                        'Cello': 'Violoncelle',
                        'Organ': 'Orgue',
                        'Keyboards': 'Claviers',
                        'Percussion': 'Percussions',
                        'Harp': 'Harpe',
                        'Clarinet': 'Clarinette',
                        'Trombone': 'Trombone',
                        'Tuba': 'Tuba',
                        'French Horn': 'Cor',
                        'Oboe': 'Hautbois',
                        'Bassoon': 'Basson',
                        'Harmonica': 'Harmonica',
                        'Accordion': 'Accordéon',
                        'Banjo': 'Banjo',
                        'Mandolin': 'Mandoline',
                        'Ukulele': 'Ukulélé',
                        'Xylophone': 'Xylophone',
                        'Marimba': 'Marimba',
                        'Congas': 'Congas',
                        'Bongos': 'Bongos',
                        'Tambourine': 'Tambourin',
                        'Triangle': 'Triangle',
                        'Cymbals': 'Cymbales'
                    }
                },
                profile: {
                    title: 'Paramètres du profil',
                    subtitle: 'Gérer les informations de votre compte',
                    subtitleOverview: 'Gérer votre profil et voir vos statistiques',
                    subtitleHistory: 'Vos victoires sauvegardées et historique récent',
                    currentUsername: 'Nom d\'utilisateur actuel :',
                    changeUsername: 'Changer le nom d\'utilisateur',
                    placeholder: 'Entrer un nouveau nom d\'utilisateur',
                    saveButton: 'Enregistrer',
                    foundAlbums: 'Vos albums trouvés',
                    historySubtitle: 'Connectez-vous pour enregistrer et voir votre historique',
                    historySubtitleAuthed: 'Victoires récentes enregistrées sur votre compte',
                    yourStats: 'Vos statistiques',
                    statsSubtitle: 'Connectez-vous pour voir vos statistiques',
                    statsSubtitleAuthed: 'Vos statistiques personnelles',
                    noHistory: 'Aucune victoire enregistrée. Trouvez un album mystère !',
                    historyError: 'Impossible de charger l\'historique. Réessayez plus tard.'
                },
                stats: {
                    totalWins: 'Victoires totales',
                    averageAttempts: 'Tentatives moyennes',
                    bestPerformance: 'Meilleure performance',
                    favoriteGenre: 'Genre favori',
                    recentWins: 'Victoires récentes',
                    albumsFound: 'Albums trouvés',
                    fastestWin: 'Victoire la plus rapide',
                    slowestWin: 'Victoire la plus lente',
                    averageGuesses: 'Tentatives moyennes',
                    bestStreak: 'Meilleure série',
                    currentStreak: 'Série en cours',
                    oldestWinYear: 'Année la plus ancienne',
                    newestWinYear: 'Année la plus récente',
                    averageYear: 'Année moyenne',
                    guess: 'tentative',
                    guesses: 'tentatives',
                    day: 'jour',
                    days: 'jours'
                },
                ranking: {
                    title: 'Classement album du jour',
                    subtitle: 'Meilleurs joueurs du jour',
                    subtitleDetail: 'Voici les joueurs qui ont trouvé l\'album du jour le plus rapidement.',
                    rank: 'Rang',
                    username: 'Utilisateur',
                    attempts: 'Tentatives',
                    duration: 'Durée',
                    time: 'Heure',
                    empty: 'Pas encore de classement pour aujourd\'hui.',
                    emptyAction: 'Soyez le premier à trouver l\'album !',
                    loading: 'Chargement du classement...',
                    error: 'Échec du chargement du classement'
                },
                bug: {
                    title: 'Signaler un bug',
                    subtitle: 'Aidez-nous à nous améliorer en signalant les bugs que vous rencontrez',
                    subtitleDetail: 'Remplissez les détails ci-dessous et nous enquêterons',
                    formTitle: 'Titre',
                    formDescription: 'Description',
                    formEmail: 'Votre e-mail',
                    formSubmit: 'Soumettre le rapport',
                    placeholderTitle: 'Description brève du bug',
                    placeholderDescription: 'Veuillez décrire le bug en détail : ce que vous faisiez, ce qui s\'est passé et ce à quoi vous vous attendiez',
                    placeholderEmail: 'votre.email@exemple.com',
                    submitting: 'Envoi du rapport...',
                    success: 'Merci ! Votre rapport de bug a été envoyé avec succès. Nous enquêterons et vous recontacterons si nécessaire.',
                    error: 'Échec de l\'envoi du rapport de bug. Veuillez réessayer plus tard.'
                },
                admin: {
                    title: 'Ajouter/Mettre à jour l\'album mystère',
                    subtitle: 'Programmer un album pour le défi quotidien',
                    subtitleOverview: 'Gérer le programme des albums mystères',
                    scheduleListTitle: 'Programme des albums mystères',
                    scheduleSubtitle: 'Tous les albums mystères programmés',
                    date: 'Date',
                    search: 'Rechercher un album',
                    placeholder: 'Taper le nom de l\'album ou de l\'artiste...',
                    selectedAlbum: 'Album sélectionné',
                    submit: 'Enregistrer',
                    loading: 'Chargement du programme...',
                    success: 'Album programmé avec succès !',
                    error: 'Échec de la programmation de l\'album'
                },
                archive: {
                    title: 'Archives des albums',
                    subtitle: 'Jouez aux albums du jour passés que vous n\'avez pas complétés',
                    loginWarning: 'Connectez-vous pour conserver votre historique.',
                    empty: 'Aucun album du jour passé disponible pour le moment.',
                    completed: 'Complété',
                    play: 'Jouer',
                    future: 'Bientôt disponible'
                },
                common: {
                    submit: 'Soumettre',
                    cancel: 'Annuler',
                    loading: 'Chargement...',
                    error: 'Erreur',
                    success: 'Succès',
                    close: 'Fermer',
                    save: 'Enregistrer',
                    delete: 'Supprimer',
                    edit: 'Modifier',
                    back: 'Retour',
                    next: 'Suivant',
                    previous: 'Précédent'
                },
                footer: {
                    howToPlay: 'Comment jouer',
                    tagline: 'Un jeu musical de déduction • Inspiré de'
                },
                howToPlay: {
                    title: 'Comment jouer',
                    dailyGame: {
                        title: 'Album du jour / Album aléatoire',
                        search: {
                            title: 'Rechercher et soumettre',
                            text: 'Tapez le nom d\'un album ou d\'un artiste ou groupe dans le champ de recherche. Sélectionnez un résultat dans la liste et soumettez-le comme tentative.'
                        },
                        reveal: {
                            title: 'Révéler les indices',
                            text: 'Chaque tentative révèle les attributs partagés avec l\'album mystère : artiste(s), genre(s), année, label, pays, durée, etc. Les indices montrent uniquement les similitudes, jamais les différences.'
                        },
                        narrow: {
                            title: 'Affiner la recherche',
                            text: 'Utilisez les indices accumulés pour éliminer les possibilités et vous rapprocher de l\'album mystère. Plus vous faites de tentatives, plus vous accumulez d\'indices !'
                        },
                        find: {
                            title: 'Trouver l\'album mystère',
                            text: 'Quand vous identifiez le bon album, vous gagnez ! Un nouveau mystère vous attend chaque jour (album du jour) ou à chaque actualisation (album aléatoire).'
                        },
                        rules: 'Règles du jeu',
                        rule1: 'Aucune limite de tentatives — explorez autant que vous le souhaitez',
                        rule2: 'Les indices montrent uniquement les similitudes, jamais les différences',
                        rule3: 'Un album mystère par jour (album du jour) ou à chaque actualisation (album aléatoire)',
                        rule5: 'La progression est sauvegardée uniquement si vous êtes connecté'
                    },
                    coverGuess: {
                        title: 'Devine la Pochette',
                        grid: {
                            title: 'Grille 4x4',
                            text: 'La pochette de l\'album mystère est cachée dans une grille de 16 carrés (4x4). Au début, un carré est révélé.'
                        },
                        reveal: {
                            title: 'Révéler les carrés',
                            text: 'Chaque tentative révèle un nouveau carré de la pochette dans un ordre aléatoire. Utilisez le bouton "Révéler le prochain carré" pour obtenir un indice supplémentaire. Attention, chaque carré révélé retire 1 point à votre total de départ qui est de 15 points.'
                        },
                        search: {
                            title: 'Rechercher l\'album',
                            text: 'Tapez le nom d\'un album ou d\'un artiste dans le champ de recherche et soumettez votre tentative. Plus vous révélez de carrés, plus vous avez d\'indices visuels !'
                        },
                        points: {
                            title: 'Système de points',
                            text: 'Vous partez avec un total de 15 points. Plus vous trouvez rapidement l\'album, plus vous gagnez de points ! Chaque carré découvert vous retire 1 point à votre total donc moins de tentatives et moins de carrés révélés = plus de points. Un classement est disponible pour voir votre position.'
                        },
                        rules: 'Règles du jeu',
                        rule1: 'Aucune limite journalière, jouez autant que vous voulez',
                        rule2: 'Vous pouvez révéler jusqu\'à 16 carrés (toute la pochette)',
                        rule3: 'Les points sont calculés selon le nombre de tentatives et de carrés révélés',
                        rule4: 'Un nouveau mystère à chaque actualisation',
                        rule5: 'Vous devez être connecté pour participer au classement'
                    }
                },
                pageTitles: {
                    albumOfDay: 'AlbumGuessr - Album du jour',
                    randomAlbum: 'AlbumGuessr - Découvrez l\'album mystère',
                    coverGuess: 'AlbumGuessr - Devine la Pochette',
                    howToPlay: 'AlbumGuessr - Comment jouer',
                    profile: 'AlbumGuessr - Profil',
                    ranking: 'AlbumGuessr - Classement album du jour',
                    statistics: 'AlbumGuessr - Statistiques',
                    admin: 'AlbumGuessr - Administration',
                    reportBug: 'AlbumGuessr - Signaler un bug'
                }
            },
            es: {
                nav: {
                    albumOfDay: 'Álbum del día',
                    randomAlbum: 'Álbum aleatorio',
                    coverGuess: 'Adivina la Portada',
                    ranking: 'Clasificación del álbum del día',
                    coverGuessRanking: 'Clasificación Cover Guess',
                    archives: 'Todos los álbumes',
                    profile: 'Perfil',
                    myStatistics: 'Mis estadísticas',
                    reportBug: 'Reportar un error'
                },
                auth: {
                    login: 'Conexión / Registro',
                    logout: 'Cerrar sesión',
                    viewProfile: 'Ver perfil'
                },
                genreFilter: {
                    title: 'Filtrar por género',
                    allGenres: 'Todos los géneros',
                    confirmReset: 'Cambiar el filtro de género iniciará un nuevo juego. ¿Continuar?'
                },
                game: {
                    searchPlaceholder: 'Buscar un álbum o un artista...',
                    makeGuess: 'Para encontrar el álbum del día, haz una primera propuesta en la barra de búsqueda<br>para comenzar a revelar las primeras pistas.',
                    guessCounter: 'intentos',
                    guessCounterSingle: 'intento',
                    cluesRevealed: 'pista(s)',
                    cluesDiscovered: 'Pistas descubiertas:',
                    newMystery: 'Para encontrar el álbum misterioso, haz una primera propuesta en la barra de búsqueda<br>para comenzar a revelar las primeras pistas.',
                    unknownArtist: 'Artista desconocido',
                    guessesNeeded: 'Intentos necesarios:',
                    challengeLink: '¡Enlace de desafío copiado al portapapeles!',
                    subtitle: 'Álbum Misterioso - Nuevo álbum en cada actualización',
                    albumQuestion: '¿Cuál es el álbum del día?',
                    shareResult: 'Compartir tu resultado',
                    victoryMessage: '¡Encontraste el álbum del día! ¡Vuelve mañana para un nuevo álbum misterioso!',
                    instructions: {
                        title: 'Cómo jugar',
                        search: {
                            title: 'Buscar y enviar',
                            text: 'Escribe el nombre de un álbum o una canción y envíalo como intento'
                        },
                        reveal: {
                            title: 'Revelar pistas',
                            text: 'Cada intento revela atributos compartidos con el álbum misterioso: artista, género, año, sello...'
                        },
                        narrow: {
                            title: 'Reducir opciones',
                            text: 'Usa las pistas acumuladas para eliminar posibilidades y acercarte al álbum misterioso'
                        },
                        find: {
                            title: 'Encontrar el álbum misterioso',
                            text: '¡Cuando identifiques el álbum correcto, ganas! Un nuevo misterio te espera cada día',
                            textRandom: '¡Cuando identifiques el álbum correcto, ganas! Un nuevo misterio te espera en cada actualización'
                        },
                        rules: 'Reglas del juego',
                        rule1: 'Sin límite de intentos — explora tanto como quieras',
                        rule2: 'Las pistas solo muestran similitudes, nunca diferencias',
                        rule3: 'Un álbum misterioso por día',
                        rule3Random: 'Un nuevo álbum misterioso en cada actualización',
                        rule4: 'Juego gratuito abierto para todos'
                    },
                    victory: {
                        title: '¡Felicitaciones!',
                        titleDaily: '¡Felicitaciones! ¡Encontraste el álbum del día!',
                        message: '¡Vuelve mañana para un nuevo álbum misterioso!',
                        messageRandom: '¡Actualiza la página y encuentra otro!',
                        showRankings: 'Ver clasificación',
                        challengeFriend: 'Desafiar a un amigo',
                        playAgain: 'Jugar de nuevo',
                        playPastDailies: 'Jugar más álbumes diarios pasados'
                    },
                    noClues: 'Haz una primera suposición para revelar pistas...',
                    loading: 'Cargando el álbum del día...',
                    loadingRandom: 'Cargando álbum misterioso...',
                    albumOfDayLabel: 'Álbum del día',
                    gameModeDaily: 'Diario',
                    gameModeRandom: 'Aleatorio',
                    gameModeCoverGuess: 'Cover Guess',
                    gameModeDailyTitle: 'Álbum del día',
                    gameModeRandomTitle: 'Álbum aleatorio',
                    gameModeCoverGuessTitle: 'Cover Guess',
                    coverGuess: {
                        nextHint: 'Revelar el siguiente cuadrado',
                        loading: 'Cargando el álbum misterioso...',
                        victoryMessage: '¡Encontraste el álbum!',
                        defeatMessage: 'No lo encontraste, era:',
                        points: 'Puntos:',
                        rankingLine1: 'Estás en el lugar <strong>#{position}</strong> del ranking',
                        rankingLine2: 'con <strong>{points} puntos</strong>',
                        rankingLine1Loading: 'Estás en el lugar <strong>#-</strong> del ranking',
                        rankingLine2Loading: 'con <strong>- puntos</strong>',
                        playAgain: 'Jugar de nuevo',
                        viewRanking: 'Ver ranking'
                    },
                    clueCategories: {
                        artists: 'Artistas',
                        artist_type: 'Tipo',
                        genres: 'Géneros',
                        release_year: 'Año',
                        total_length_seconds: 'Duración',
                        countries: 'Países',
                        continents: 'Continentes',
                        contributors: 'Contribuidores',
                        instruments: 'Instrumentos',
                        label: 'Sello'
                    },
                    artistTypes: {
                        solo: 'artista solista',
                        group: 'grupo'
                    },
                    guessLabels: {
                        before: 'antes',
                        after: 'después',
                        shorter: 'más corto',
                        longer: 'más largo',
                        shorterThan: 'más corto que',
                        longerThan: 'más largo que',
                        beforeYear: 'antes',
                        afterYear: 'después',
                        between: 'entre',
                        and: 'y'
                    },
                    chipLabels: {
                        hit: 'Coincide',
                        miss: 'No coincide'
                    },
                    continents: {
                        'Africa': 'África',
                        'Europe': 'Europa',
                        'Asia': 'Asia',
                        'North America': 'América del Norte',
                        'South America': 'América del Sur',
                        'Oceania': 'Oceanía',
                        'Antarctica': 'Antártida'
                    },
                    instruments: {
                        'Guitar': 'Guitarra',
                        'Electric Guitar': 'Guitarra eléctrica',
                        'Acoustic Guitar': 'Guitarra acústica',
                        'Bass': 'Bajo',
                        'Bass Guitar': 'Bajo eléctrico',
                        'Double Bass': 'Contrabajo',
                        'Upright Bass': 'Contrabajo',
                        'Drums': 'Batería',
                        'Drum Kit': 'Batería',
                        'Piano': 'Piano',
                        'Vocals': 'Voces',
                        'Synthesizer': 'Sintetizador',
                        'Violin': 'Violín',
                        'Viola': 'Viola',
                        'Trumpet': 'Trompeta',
                        'Saxophone': 'Saxofón',
                        'Alto Saxophone': 'Saxofón alto',
                        'Tenor Saxophone': 'Saxofón tenor',
                        'Flute': 'Flauta',
                        'Cello': 'Violonchelo',
                        'Organ': 'Órgano',
                        'Keyboards': 'Teclados',
                        'Percussion': 'Percusión',
                        'Harp': 'Arpa',
                        'Clarinet': 'Clarinete',
                        'Trombone': 'Trombón',
                        'Tuba': 'Tuba',
                        'French Horn': 'Trompa',
                        'Oboe': 'Oboe',
                        'Bassoon': 'Fagot',
                        'Harmonica': 'Armónica',
                        'Accordion': 'Acordeón',
                        'Banjo': 'Banjo',
                        'Mandolin': 'Mándola',
                        'Ukulele': 'Ukelele',
                        'Xylophone': 'Xilófono',
                        'Marimba': 'Marimba',
                        'Congas': 'Congas',
                        'Bongos': 'Bongos',
                        'Tambourine': 'Pandereta',
                        'Triangle': 'Triángulo',
                        'Cymbals': 'Platillos'
                    }
                },
                profile: {
                    title: 'Configuración del perfil',
                    subtitle: 'Administrar la información de tu cuenta',
                    subtitleOverview: 'Administra tu perfil y ve tus estadísticas',
                    subtitleHistory: 'Tus victorias guardadas e historial reciente',
                    currentUsername: 'Nombre de usuario actual:',
                    changeUsername: 'Cambiar nombre de usuario',
                    placeholder: 'Ingresar nuevo nombre de usuario',
                    saveButton: 'Guardar nombre de usuario',
                    foundAlbums: 'Tus álbumes encontrados',
                    historySubtitle: 'Inicia sesión para guardar y ver tu historial',
                    historySubtitleAuthed: 'Victorias recientes guardadas en tu cuenta',
                    yourStats: 'Tus estadísticas',
                    statsSubtitle: 'Inicia sesión para ver tus estadísticas',
                    statsSubtitleAuthed: 'Tus estadísticas personales',
                    noHistory: 'No hay victorias guardadas todavía. ¡Encuentra un álbum misterioso!',
                    historyError: 'No se pudo cargar el historial. Inténtalo de nuevo más tarde.'
                },
                stats: {
                    totalWins: 'Victorias totales',
                    averageAttempts: 'Intentos promedio',
                    bestPerformance: 'Mejor rendimiento',
                    favoriteGenre: 'Género favorito',
                    recentWins: 'Victorias recientes',
                    albumsFound: 'Álbumes encontrados',
                    fastestWin: 'Victoria más rápida',
                    slowestWin: 'Victoria más lenta',
                    averageGuesses: 'Intentos promedio',
                    bestStreak: 'Mejor racha',
                    currentStreak: 'Racha actual',
                    oldestWinYear: 'Año más antiguo',
                    newestWinYear: 'Año más reciente',
                    averageYear: 'Año promedio',
                    guess: 'intento',
                    guesses: 'intentos',
                    day: 'día',
                    days: 'días'
                },
                ranking: {
                    title: 'Clasificación diaria',
                    subtitle: 'Mejores jugadores del día',
                    subtitleDetail: 'Aquí están los jugadores que encontraron el álbum del día más rápido.',
                    rank: 'Rango',
                    username: 'Nombre de usuario',
                    attempts: 'Intentos',
                    duration: 'Duración',
                    time: 'Hora',
                    empty: 'Aún no hay clasificaciones para hoy.',
                    emptyAction: '¡Sé el primero en encontrar el álbum!',
                    loading: 'Cargando clasificación...',
                    error: 'Error al cargar clasificación'
                },
                bug: {
                    title: 'Reportar un error',
                    subtitle: 'Ayúdanos a mejorar reportando errores que encuentres',
                    subtitleDetail: 'Completa los detalles a continuación y investigaremos',
                    formTitle: 'Título',
                    formDescription: 'Descripción',
                    formEmail: 'Tu correo electrónico',
                    formSubmit: 'Enviar reporte',
                    placeholderTitle: 'Breve descripción del error',
                    placeholderDescription: 'Por favor describe el error en detalle: qué estabas haciendo, qué pasó y qué esperabas',
                    placeholderEmail: 'tu.email@ejemplo.com',
                    submitting: 'Enviando reporte...',
                    success: '¡Gracias! Tu reporte de error se ha enviado correctamente. Investigaremos y te contactaremos si es necesario.',
                    error: 'Error al enviar reporte de error. Por favor inténtalo más tarde.'
                },
                admin: {
                    title: 'Agregar/Actualizar álbum misterioso',
                    subtitle: 'Programar un álbum para el desafío diario',
                    subtitleOverview: 'Administrar el programa de álbumes misteriosos',
                    scheduleListTitle: 'Programa de álbumes misteriosos',
                    scheduleSubtitle: 'Todos los álbumes misteriosos programados',
                    date: 'Fecha',
                    search: 'Buscar un álbum',
                    placeholder: 'Escribe el nombre del álbum o artista...',
                    selectedAlbum: 'Álbum seleccionado',
                    submit: 'Guardar',
                    loading: 'Cargando programa...',
                    success: '¡Álbum programado con éxito!',
                    error: 'Error al programar álbum'
                },
                archive: {
                    title: 'Archivos de álbumes',
                    subtitle: 'Juega a los álbumes diarios pasados que no has completado',
                    loginWarning: 'Conéctate para guardar tu historial.',
                    empty: 'Aún no hay álbumes diarios pasados disponibles.',
                    completed: 'Completado',
                    play: 'Jugar',
                    future: 'Próximamente'
                },
                common: {
                    submit: 'Enviar',
                    cancel: 'Cancelar',
                    loading: 'Cargando...',
                    error: 'Error',
                    success: 'Éxito',
                    close: 'Cerrar',
                    save: 'Guardar',
                    delete: 'Eliminar',
                    edit: 'Editar',
                    back: 'Volver',
                    next: 'Siguiente',
                    previous: 'Anterior'
                },
                footer: {
                    howToPlay: 'Cómo jugar',
                    tagline: 'Un juego musical de deducción • Inspirado en'
                },
                howToPlay: {
                    title: 'Cómo jugar',
                    dailyGame: {
                        title: 'Álbum del día / Álbum aleatorio',
                        search: {
                            title: 'Buscar y enviar',
                            text: 'Escribe el nombre de un álbum o un artista o grupo en el campo de búsqueda. Selecciona un resultado de la lista y envíalo como intento.'
                        },
                        reveal: {
                            title: 'Revelar pistas',
                            text: 'Cada intento revela los atributos compartidos con el álbum misterioso: artista(s), género(s), año, sello, país, duración, etc. Las pistas solo muestran similitudes, nunca diferencias.'
                        },
                        narrow: {
                            title: 'Reducir opciones',
                            text: 'Usa las pistas acumuladas para eliminar posibilidades y acercarte al álbum misterioso. ¡Cuántos más intentos hagas, más pistas acumularás!'
                        },
                        find: {
                            title: 'Encontrar el álbum misterioso',
                            text: '¡Cuando identifies el álbum correcto, ganas! Un nuevo misterio te espera cada día (álbum del día) o en cada actualización (álbum aleatorio).'
                        },
                        rules: 'Reglas del juego',
                        rule1: 'Sin límite de intentos — explora todo lo que quieras',
                        rule2: 'Las pistas solo muestran similitudes, nunca diferencias',
                        rule3: 'Un álbum misterioso por día (álbum del día) o en cada actualización (álbum aleatorio)',
                        rule5: 'El progreso solo se guarda si estás conectado'
                    },
                    coverGuess: {
                        title: 'Adivina la Portada',
                        grid: {
                            title: 'Cuadrícula 4x4',
                            text: 'La portada del álbum misterioso está oculta en una cuadrícula de 16 cuadrados (4x4). Al inicio, un cuadrado está revelado.'
                        },
                        reveal: {
                            title: 'Revelar cuadrados',
                            text: 'Cada intento revela un nuevo cuadrado de la portada en orden aleatorio. Usa el botón "Revelar siguiente cuadrado" para obtener una pista adicional. Atención, cada cuadrado revelado resta 1 punto de tu total inicial que es de 15 puntos.'
                        },
                        search: {
                            title: 'Buscar el álbum',
                            text: 'Escribe el nombre de un álbum o un artista en el campo de búsqueda y envía tu intento. ¡Cuántos más cuadrados reveles, más pistas visuales tendrás!'
                        },
                        points: {
                            title: 'Sistema de puntos',
                            text: 'Empiezas con un total de 15 puntos. ¡Cuanto más rápido encuentres el álbum, más puntos ganas! Cada cuadrado descubierto te resta 1 punto de tu total, por lo que menos intentos y menos cuadrados revelados = más puntos. Hay un ranking disponible para ver tu posición.'
                        },
                        rules: 'Reglas del juego',
                        rule1: 'Sin límite diario, juega cuanto quieras',
                        rule2: 'Puedes revelar hasta 16 cuadrados (toda la portada)',
                        rule3: 'Los puntos se calculan según el número de intentos y cuadrados revelados',
                        rule4: 'Un nuevo misterio en cada actualización',
                        rule5: 'Debes estar conectado para participar en el ranking'
                    }
                },
                pageTitles: {
                    albumOfDay: 'AlbumGuessr - Álbum del día',
                    randomAlbum: 'AlbumGuessr - Descubre el álbum misterioso',
                    coverGuess: 'AlbumGuessr - Adivina la Portada',
                    howToPlay: 'AlbumGuessr - Cómo jugar',
                    profile: 'AlbumGuessr - Perfil',
                    ranking: 'AlbumGuessr - Clasificación del álbum del día',
                    statistics: 'AlbumGuessr - Estadísticas',
                    admin: 'AlbumGuessr - Panel de administración',
                    reportBug: 'AlbumGuessr - Reportar un error'
                }
            }
        };
    }

    /**
     * Initialize i18n
     * Loads language from localStorage, or auto-detects from browser
     */
    init() {
        const storedLang = localStorage.getItem('albumguessr_language');
        if (storedLang && this.translations[storedLang]) {
            this.currentLanguage = storedLang;
        } else {
            // Auto-detect browser language
            const browserLang = navigator.language || navigator.userLanguage;
            const langCode = browserLang.split('-')[0].toLowerCase();
            
            // Map browser languages to supported languages
            const langMap = {
                'en': 'en',
                'fr': 'fr',
                'es': 'es'
            };
            
            this.currentLanguage = langMap[langCode] || 'en';
        }
        
        this.saveLanguage();
        this.updateHtmlLang();
        this.updatePageTitle();
    }

    /**
     * Get translation for a key
     * @param {string} key - Translation key (e.g., 'nav.albumOfDay')
     * @param {object} params - Optional parameters for interpolation
     * @returns {string} Translated text
     */
    t(key, params = {}) {
        const keys = key.split('.');
        let value = this.translations[this.currentLanguage];
        
        for (const k of keys) {
            if (value && typeof value === 'object') {
                value = value[k];
            } else {
                // Fallback to English if translation not found
                value = this.translations.en;
                for (const k2 of keys) {
                    value = value && value[k2];
                }
                break;
            }
        }
        
        if (typeof value !== 'string') {
            console.warn(`Translation missing for key: ${key}`);
            return key;
        }
        
        // Simple parameter interpolation
        if (Object.keys(params).length > 0) {
            for (const [param, val] of Object.entries(params)) {
                value = value.replace(new RegExp(`\\{\\{${param}\\}\\}`, 'g'), val);
            }
        }
        
        return value;
    }

    /**
     * Set current language
     * @param {string} lang - Language code (en, fr, es)
     */
    setLanguage(lang) {
        if (this.translations[lang]) {
            this.currentLanguage = lang;
            this.saveLanguage();
            this.updateHtmlLang();
            this.updatePageTitle();
            return true;
        }
        return false;
    }

    /**
     * Get current language code
     * @returns {string} Current language code
     */
    getCurrentLanguage() {
        return this.currentLanguage;
    }

    /**
     * Save language to localStorage
     */
    saveLanguage() {
        localStorage.setItem('albumguessr_language', this.currentLanguage);
    }

    /**
     * Update HTML lang attribute
     */
    updateHtmlLang() {
        if (document.documentElement) {
            document.documentElement.lang = this.currentLanguage;
        }
    }

    /**
     * Get supported languages
     * @returns {array} Array of supported language codes
     */
    getSupportedLanguages() {
        return ['en', 'fr', 'es'];
    }

    /**
     * Get language display name
     * @param {string} lang - Language code
     * @returns {string} Display name
     */
    getLanguageDisplayName(lang) {
        const names = {
            'en': 'English',
            'fr': 'Français',
            'es': 'Español'
        };
        return names[lang] || lang;
    }

    /**
     * Update page title based on current page
     */
    updatePageTitle() {
        if (typeof document === 'undefined' || !document.title) return;
        
        // Determine which page we're on based on the pathname
        const pathname = typeof window !== 'undefined' ? window.location.pathname : '';
        const page = pathname.split('/').pop() || 'index.html';
        
        let titleKey = null;
        if (page === 'index.html' || page === '' || page === '/') {
            titleKey = 'pageTitles.albumOfDay';
        } else if (page === 'game.html') {
            titleKey = 'pageTitles.randomAlbum';
        } else if (page === 'profile.html') {
            titleKey = 'pageTitles.profile';
        } else if (page === 'ranking.html') {
            titleKey = 'pageTitles.ranking';
        } else if (page === 'statistics.html') {
            titleKey = 'pageTitles.statistics';
        } else if (page === 'admin.html') {
            titleKey = 'pageTitles.admin';
        } else if (page === 'report-bug.html') {
            titleKey = 'pageTitles.reportBug';
        } else if (page === 'cover-guess.html') {
            titleKey = 'pageTitles.coverGuess';
        }
        
        if (titleKey) {
            try {
                document.title = this.t(titleKey);
            } catch (e) {
                console.warn('Failed to update page title:', e);
            }
        }
    }

    /**
     * Apply translations to elements with data-i18n attributes
     */
    applyTranslations() {
        const elements = document.querySelectorAll('[data-i18n]');
        elements.forEach(element => {
            const key = element.getAttribute('data-i18n');
            if (key) {
                element.innerHTML = this.t(key);
            }
        });
        
        // Also apply translations to placeholders and titles
        const placeholders = document.querySelectorAll('[data-i18n-placeholder]');
        placeholders.forEach(element => {
            const key = element.getAttribute('data-i18n-placeholder');
            if (key) {
                element.placeholder = this.t(key);
            }
        });
        
        const titles = document.querySelectorAll('[data-i18n-title]');
        titles.forEach(element => {
            const key = element.getAttribute('data-i18n-title');
            if (key) {
                element.title = this.t(key);
            }
        });
        
        // Update page title
        this.updatePageTitle();
    }
}

// Export singleton instance
export const i18n = new I18nManager();

