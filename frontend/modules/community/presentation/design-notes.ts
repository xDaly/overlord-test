export type DesignNote = { title: string; text: string; reference: string }

export const DESIGN_NOTES = {
  visitor: {
    title: "Lecture libre, connexion au moment d'agir",
    text: "Tout le monde peut lire sans compte, comme sur Reddit ou Discourse : les discussions de qualité sont indexées par Google et attirent de nouveaux lecteurs. La connexion n'est demandée qu'au premier clic sur « Utile », « Répondre » ou « Publier », puis l'action reprend automatiquement.",
    reference: "Reddit, Discourse",
  },
  onboarding: {
    title: "Inscription en deux écrans",
    text: "Connexion avec le compte lerevenu.com existant (aucun nouveau mot de passe), puis choix des centres d'intérêt en un clic. Le fil « Pour vous » est personnalisé dès la première visite. Les abonnés au magazine sont reconnus et portent un label « Abonné ».",
    reference: "Reddit, Medium",
  },
  composer: {
    title: "Une seule porte d'entrée pour publier",
    text: "Le champ « Posez votre question » reste toujours visible en haut du fil. On choisit ensuite le type de publication (question, discussion, sondage) en un clic. Sur mobile, le même rôle est tenu par le bouton central de la barre basse.",
    reference: "LinkedIn, groupes Facebook",
  },
  tabs: {
    title: "Des fils pensés pour l'entraide",
    text: "« Pour vous » filtre selon les centres d'intérêt. « Tendances » classe par réponses, « Utile », vues et fraîcheur. « Sans réponse » invite à aider : c'est le levier le plus efficace pour qu'aucune question ne reste sans réponse.",
    reference: "Reddit (Hot), Stack Overflow (Unanswered)",
  },
  card: {
    title: "Statut lisible d'un coup d'œil",
    text: "La case de gauche donne le nombre de réponses. Elle passe au vert quand la question est résolue et apparaît en pointillés rouges quand personne n'a encore répondu. On repère tout de suite les discussions utiles et celles où l'on peut aider.",
    reference: "Stack Overflow",
  },
  weekly: {
    title: "Rituels éditoriaux",
    text: "Une question et un sondage chaque semaine, posés par la rédaction. Ils donnent une raison de revenir et nourrissent la newsletter et le magazine (« Vous nous avez dit… »), ce qui boucle la relation entre les lecteurs et la rédaction.",
    reference: "Médias communautaires (The Guardian, NYT Picks)",
  },
  poll: {
    title: "Le sondage : l'engagement en un clic",
    text: "Voter ne demande aucun effort, et les résultats ne s'affichent qu'après le vote. C'est souvent le premier geste d'un nouveau membre. Sur mobile, le sondage est inséré directement dans le fil.",
    reference: "Sondages LinkedIn et X",
  },
  events: {
    title: "« Le Revenu répond » : des rendez-vous en direct",
    text: "Des sessions de questions-réponses à heure fixe avec les journalistes. « Je participe » envoie un rappel la veille. Les questions peuvent être posées à l'avance, ce qui garantit un direct animé.",
    reference: "Reddit AMA (Ask Me Anything)",
  },
  progress: {
    title: "Progression visible",
    text: "Points, niveaux et séries de visites rendent la contribution visible et fixent un objectif proche (« encore 18 points pour… »). Les niveaux supérieurs peuvent débloquer des droits : modifier un titre, aider à la modération.",
    reference: "Niveaux de confiance Discourse, réputation Stack Overflow, séries Duolingo",
  },
  top: {
    title: "Reconnaissance sociale",
    text: "Le classement est mensuel : il repart de zéro chaque mois pour que les nouveaux membres aient une chance d'y figurer. Les comptes de la rédaction en sont exclus.",
    reference: "Stack Overflow, Strava",
  },
  bestanswer: {
    title: "Meilleure réponse en tête",
    text: "L'auteur de la question (ou la rédaction) choisit la meilleure réponse, rappelée juste sous la question. Le lecteur qui arrive depuis Google trouve sa réponse sans tout lire. Le membre qui l'a écrite gagne 20 points.",
    reference: "Stack Overflow",
  },
  redaction: {
    title: "La rédaction, présente et identifiée",
    text: "Les réponses des journalistes portent un label et un fond distinct. C'est ce qui différencie la communauté du Revenu d'un forum généraliste : une parole experte au milieu des échanges entre lecteurs.",
    reference: "Spécifique au Revenu",
  },
  useful: {
    title: "Un seul bouton positif : « Utile »",
    text: "Pas de vote négatif : on valorise ce qui aide plutôt que de sanctionner, ce qui garde un ton bienveillant. Chaque « Utile » rapporte 5 points à l'auteur. On ne peut pas marquer son propre message.",
    reference: "Le « J'aime » de Discourse",
  },
  follow: {
    title: "Suivi automatique et notifications",
    text: "On suit automatiquement les discussions qu'on lance ou auxquelles on répond. Chaque nouvelle réponse déclenche une notification, complétée par un récapitulatif e-mail hebdomadaire : c'est le principal moteur de retour.",
    reference: "Discourse",
  },
  replybox: {
    title: "Répondre sans chercher",
    text: "La zone de réponse est toujours ouverte en bas de la discussion, avec une invitation personnalisée. Les @mentions notifient le membre cité. Le brouillon est conservé si l'on quitte la page.",
    reference: "Discourse, Slack",
  },
  related: {
    title: "Prolonger la visite",
    text: "Des discussions du même espace sont proposées en fin de page pour inciter à poursuivre la lecture.",
    reference: "Sujets suggérés de Discourse",
  },
  similar: {
    title: "Doublons détectés pendant la saisie",
    text: "Dès que l'on tape le titre, les discussions proches s'affichent. Le membre trouve souvent sa réponse tout de suite, et le forum évite les doublons. Essayez de taper « PEA » ou « assurance-vie ».",
    reference: "Stack Overflow, Discourse",
  },
  compliance: {
    title: "Cadre réglementaire",
    text: "Un rappel discret de la charte : partage d'expérience, pas de conseil personnalisé ni de sollicitation. Côté modération, un filtre signale les messages qui associent le nom d'une valeur à un vocabulaire de recommandation (« achetez », « objectif de cours »).",
    reference: "Exigences AMF",
  },
  rewards: {
    title: "Récompense immédiate",
    text: "Chaque action rapporte des points et peut débloquer un badge, annoncé par une notification discrète. Les badges non obtenus restent visibles en grisé : ils indiquent ce qu'on peut faire ensuite.",
    reference: "Discourse, Duolingo",
  },
  article: {
    title: "Pont entre articles et forum",
    text: "Chaque article de lerevenu.com propose un bouton « En discuter avec la communauté » qui ouvre ou crée la discussion liée. La discussion renvoie à son tour vers l'article.",
    reference: "Commentaires reliés au forum (Discourse)",
  },
  mobile: {
    title: "Pensé pour le mobile",
    text: "Barre de navigation en bas de l'écran, bouton central pour publier, zones tactiles larges, une seule colonne.",
    reference: "Applications sociales mobiles",
  },
  site: {
    title: "Le Revenu toujours à un clic",
    text: "Une barre fine en haut de chaque page ramène vers lerevenu.com, ses rubriques et le magazine. Chaque espace renvoie vers la rubrique correspondante du site, chaque discussion vers l'article qui l'a inspirée, et l'accueil affiche les articles à la une. La communauté nourrit l'audience du site au lieu de la capter.",
    reference: "Barres de liaison des sites de presse (Le Monde, The Guardian)",
  },
  mention: {
    title: "Mentionner sans connaître le pseudo",
    text: "On tape @ ou on clique sur « Mentionner » : la liste propose d'abord les participants de la discussion, puis la rédaction. On filtre en tapant le prénom ou le pseudo, accents compris, et on choisit au clavier ou à la souris. Le membre mentionné reçoit une notification.",
    reference: "Slack, Discourse, LinkedIn",
  },
  blog: {
    title: "Un blog sur chaque profil",
    text: "Au-delà des questions-réponses, chaque membre peut publier des billets : retours d'expérience, bilans, méthodes. Les billets sont commentables, rapportent des points et sont mis en avant sur l'accueil. La charte s'applique : récit d'expérience, pas de conseil personnalisé.",
    reference: "Medium, articles LinkedIn",
  },
  photo: {
    title: "Une photo en deux clics",
    text: "On change sa photo depuis son profil, sans quitter la page : l'image est recadrée automatiquement. À défaut, un monogramme coloré s'affiche. Une photo rend les échanges plus personnels et renforce la confiance entre membres.",
    reference: "Réglages du compte macOS, Slack",
  },
  density: {
    title: "Deux densités d'affichage",
    text: "La vue détaillée met en avant l'extrait et les participants pour donner envie de lire. La vue compacte affiche une discussion par ligne, avec réponses, vues et dernière activité en colonnes : idéale pour les habitués qui veulent balayer beaucoup de sujets. Le choix est mémorisé sur l'appareil.",
    reference: "Discourse, vue compacte de Reddit, Mail sur macOS",
  },
  pro: {
    title: "Des membres faciles à situer",
    text: "Chaque membre se connecte avec son compte lerevenu.com : Le Revenu sait toujours qui écrit, même si les membres participent sous pseudonyme, ce qui est la règle. Pour les autres membres, les étiquettes et la fiche qui s'ouvre au survol d'un nom donnent l'ancienneté et la fiabilité de chacun. Les professionnels (conseillers en patrimoine, notaires…) portent l'étiquette « Expertise vérifiée » après contrôle de leur titre : ils s'expriment sous leur nom, à visage découvert et sans démarchage.",
    reference: "Profils vérifiés de LinkedIn, fiches au survol de Slack",
  },
  links: {
    title: "Des liens sous contrôle",
    text: "Seuls les liens vers lerevenu.com et les sources officielles (sites publics, AMF, Banque de France, Insee, Cour des comptes) sont acceptés et cliquables. Les autres sont refusés aux nouveaux membres et vérifiés par la modération pour les membres confirmés. Tous portent l'attribut rel=\"ugc nofollow\" : ils ne transmettent aucune valeur de référencement, ce qui retire l'intérêt d'y glisser des liens publicitaires.",
    reference: "Niveaux de confiance de Discourse, consignes de Google sur les contenus d'utilisateurs",
  },
  seo: {
    title: "Indexation sélective",
    text: "Seules les discussions utiles sont proposées à Google : meilleure réponse choisie, contribution de la rédaction ou d'un expert vérifié, ou au moins 25 « Utile ». Les autres restent lisibles par tous mais portent la balise noindex, comme tout le Café du Revenu. La décision porte sur la page entière, jamais sur une partie des réponses. Les pages indexées sont balisées en QAPage ou DiscussionForumPosting pour les moteurs et les assistants d'IA. Cet indicateur n'est visible que de la rédaction et de la modération.",
    reference: "Stack Overflow, consignes de Google pour les forums",
  },
  report: {
    title: "Modération en deux clics",
    text: "Chaque message peut être signalé avec un motif. Au-delà d'un seuil de signalements, le message est masqué en attendant l'avis de l'équipe.",
    reference: "Discourse",
  },
} satisfies Record<string, DesignNote>

export type NoteKey = keyof typeof DESIGN_NOTES

export const NOTE_KEYS = Object.keys(DESIGN_NOTES) as NoteKey[]
