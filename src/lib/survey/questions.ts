// MIRA Workshop Post-Event Survey — question definitions.
// This is the source of truth for the survey: the participant form, the submit
// validation, and the admin results view are all driven by this config.
// Answers are stored as JSONB keyed by each question's `id`. Mirrors
// mira-post-event-survey.md.

export const SURVEY_SLUG = 'mira-dublin-2026'

export type Choice = { value: string; label: string }

type Base = {
  id: string
  /** Display label shown next to the question, e.g. "Q1". */
  number?: string
  title: string
  help?: string
  /** Optional helper link rendered after the help text (e.g. IOSP). */
  helpLink?: { text: string; href: string }
  /** Non-optional questions must be answered before the form can submit. */
  optional?: boolean
}

export type ScaleQuestion = Base & {
  kind: 'scale'
  min: number
  max: number
  minLabel?: string
  maxLabel?: string
}

export type SingleQuestion = Base & {
  kind: 'single'
  options: Choice[]
}

export type MultiQuestion = Base & {
  kind: 'multi'
  options: Choice[]
}

export type TextQuestion = Base & {
  kind: 'text'
  long?: boolean
  placeholder?: string
}

export type MatrixQuestion = Base & {
  kind: 'matrix'
  rows: Choice[]
  min: number
  max: number
  minLabel?: string
  maxLabel?: string
  /** Adds an explicit "N/A" option per row (e.g. "didn't attend"). */
  allowNA?: boolean
}

export type Question =
  | ScaleQuestion
  | SingleQuestion
  | MultiQuestion
  | TextQuestion
  | MatrixQuestion

export type Section = {
  title: string
  description?: string
  questions: Question[]
}

export const SURVEY_SECTIONS: Section[] = [
  {
    title: 'Overall Experience',
    questions: [
      {
        id: 'q1_overall',
        number: 'Q1',
        kind: 'scale',
        title: 'Overall, how would you rate the MIRA workshop?',
        min: 1,
        max: 5,
        minLabel: 'Poor',
        maxLabel: 'Excellent',
      },
      {
        id: 'q2_confidence',
        number: 'Q2',
        kind: 'scale',
        title:
          'How confident are you that continuing work on MIRA is the right direction — that it will improve research as the schema and ecosystem evolve?',
        min: 1,
        max: 5,
        minLabel: 'Not at all',
        maxLabel: 'Very confident',
      },
      {
        id: 'q2_confidence_delta',
        kind: 'single',
        title: 'Compared to before the workshop, your confidence is:',
        optional: true,
        options: [
          { value: 'higher', label: 'Higher' },
          { value: 'same', label: 'About the same' },
          { value: 'lower', label: 'Lower' },
        ],
      },
      {
        id: 'q2_confidence_text',
        kind: 'text',
        title: 'What would most increase your confidence in MIRA?',
        long: true,
        optional: true,
        placeholder: 'Optional',
      },
      {
        id: 'q2b_contribute',
        number: 'Q2b',
        kind: 'scale',
        title:
          'How likely are you to keep contributing to MIRA after the workshop — schema PRs, tooling, user feedback, graph data, or participating in the community?',
        min: 0,
        max: 10,
        minLabel: 'Not likely',
        maxLabel: 'Very likely',
      },
      {
        id: 'q2c_advocate',
        number: 'Q2c',
        kind: 'scale',
        title:
          'How likely are you to introduce others to MIRA — share what we’re building with collaborators, labs, or others who might benefit?',
        min: 0,
        max: 10,
        minLabel: 'Not likely',
        maxLabel: 'Very likely',
      },
      {
        id: 'q2c_advocate_text',
        kind: 'text',
        title: 'Who or what would you introduce?',
        long: true,
        optional: true,
        placeholder: 'Optional',
      },
      {
        id: 'q3_expectations',
        number: 'Q3',
        kind: 'single',
        title: 'Did the workshop meet your expectations?',
        options: [
          { value: 'exceeded', label: 'Exceeded' },
          { value: 'met', label: 'Met' },
          { value: 'below', label: 'Below' },
        ],
      },
      {
        id: 'q4_most_valuable',
        number: 'Q4',
        kind: 'text',
        title:
          'In one sentence, what was the single most valuable thing you got out of the MIRA workshop?',
        long: true,
      },
    ],
  },
  {
    title: 'Program & Content',
    questions: [
      {
        id: 'q5_sessions',
        number: 'Q5',
        kind: 'matrix',
        title: 'How valuable was each session type?',
        min: 1,
        max: 5,
        minLabel: 'Low value',
        maxLabel: 'High value',
        allowNA: true,
        optional: true,
        rows: [
          { value: 'lightning_talks', label: 'Lightning talks' },
          { value: 'user_stories', label: 'User stories as anchors' },
          { value: 'marketplace', label: 'The marketplace' },
          { value: 'breakouts', label: 'Daily breakouts' },
          { value: 'report_backs', label: 'Group report-backs' },
          { value: 'road_to_adoption', label: 'Road-to-adoption & commitments' },
          { value: 'hacking', label: 'Persistent hacking track' },
        ],
      },
      {
        id: 'q6_balance',
        number: 'Q6',
        kind: 'single',
        title: 'Was the balance of structured sessions vs. free/social time right?',
        options: [
          { value: 'too_much_structure', label: 'Too much structure' },
          { value: 'about_right', label: 'About right' },
          { value: 'too_little_structure', label: 'Too little structure' },
        ],
      },
      {
        id: 'q7_pacing',
        number: 'Q7',
        kind: 'single',
        title: 'How was the pacing of the days?',
        options: [
          { value: 'too_packed', label: 'Too packed' },
          { value: 'just_right', label: 'Just right' },
          { value: 'too_loose', label: 'Too loose' },
        ],
      },
      {
        id: 'q8_marketplace',
        number: 'Q8',
        kind: 'scale',
        title: 'Did the self-organizing “marketplace” format work for deciding what to do?',
        min: 1,
        max: 5,
        minLabel: "Didn't work",
        maxLabel: 'Worked well',
      },
      {
        id: 'q8_marketplace_text',
        kind: 'text',
        title: 'Why?',
        long: true,
        optional: true,
        placeholder: 'Optional',
      },
    ],
  },
  {
    title: 'Facilitation',
    questions: [
      {
        id: 'q9_facilitation',
        number: 'Q9',
        kind: 'scale',
        title: 'How well were sessions facilitated overall?',
        min: 1,
        max: 5,
        minLabel: 'Poorly',
        maxLabel: 'Very well',
      },
      {
        id: 'q10_facilitation_dims',
        number: 'Q10',
        kind: 'matrix',
        title: 'Rate the facilitation on each dimension:',
        min: 1,
        max: 5,
        minLabel: 'Poor',
        maxLabel: 'Excellent',
        optional: true,
        rows: [
          { value: 'clear_goals', label: 'Clear goals / outcomes' },
          { value: 'time_management', label: 'Time management' },
          { value: 'all_voices', label: 'Drawing in all voices (not dominated by a few)' },
          { value: 'on_track', label: 'Keeping sessions on-track' },
        ],
      },
      {
        id: 'q11_keep',
        number: 'Q11',
        kind: 'text',
        title: 'What should facilitators KEEP doing?',
        long: true,
        optional: true,
      },
      {
        id: 'q11_start',
        kind: 'text',
        title: 'What should facilitators START doing?',
        long: true,
        optional: true,
      },
      {
        id: 'q11_stop',
        kind: 'text',
        title: 'What should facilitators STOP doing?',
        long: true,
        optional: true,
      },
    ],
  },
  {
    title: 'Outcomes & Impact',
    questions: [
      {
        id: 'q12_connections',
        number: 'Q12',
        kind: 'single',
        title:
          'Did you make new connections or potential collaborations you expect to continue?',
        options: [
          { value: 'yes_several', label: 'Yes, several' },
          { value: 'a_few', label: 'A few' },
          { value: 'not_really', label: 'Not really' },
        ],
      },
      {
        id: 'q13_commitment',
        number: 'Q13',
        kind: 'single',
        title: 'Did you leave with a concrete commitment or next step?',
        options: [
          { value: 'yes', label: 'Yes' },
          { value: 'somewhat', label: 'Somewhat' },
          { value: 'no', label: 'No' },
        ],
      },
      {
        id: 'q13_followthrough',
        kind: 'scale',
        title: "If so, how confident are you that you'll follow through?",
        min: 1,
        max: 5,
        minLabel: 'Not confident',
        maxLabel: 'Very confident',
        optional: true,
      },
      {
        id: 'q14_clarity',
        number: 'Q14',
        kind: 'scale',
        title:
          'How much clearer is the MIRA schema / the direction of the standard to you now than before the workshop?',
        min: 1,
        max: 5,
        minLabel: 'No clearer',
        maxLabel: 'Much clearer',
      },
    ],
  },
  {
    title: 'Logistics & Venue',
    questions: [
      {
        id: 'q15_logistics',
        number: 'Q15',
        kind: 'matrix',
        title: 'Rate the following:',
        min: 1,
        max: 5,
        minLabel: 'Poor',
        maxLabel: 'Excellent',
        allowNA: true,
        optional: true,
        rows: [
          { value: 'accommodation', label: 'Accommodation' },
          { value: 'food', label: 'Food' },
          { value: 'travel_transport', label: 'Travel / transport logistics' },
          { value: 'activities', label: 'Outdoor & social activities (sauna, hikes, cold plunge, etc.)' },
        ],
      },
      {
        id: 'q16_length',
        number: 'Q16',
        kind: 'single',
        title: 'Was the workshop length (Sun–Thu, ~5 days) right?',
        options: [
          { value: 'too_short', label: 'Too short' },
          { value: 'just_right', label: 'Just right' },
          { value: 'too_long', label: 'Too long' },
        ],
      },
      {
        id: 'q17_logistics_friction',
        number: 'Q17',
        kind: 'text',
        title: 'Anything about logistics that created friction for you?',
        long: true,
        optional: true,
      },
    ],
  },
  {
    title: 'The Future (of the gathering)',
    questions: [
      {
        id: 'q18_cadence',
        number: 'Q18',
        kind: 'single',
        title: "What's the ideal time until the next MIRA workshop?",
        options: [
          { value: '4_months', label: '4 months' },
          { value: '6_months', label: '6 months' },
          { value: '12_months', label: '12 months' },
          { value: 'other', label: 'Other' },
        ],
      },
      {
        id: 'q18_cadence_other',
        kind: 'text',
        title: 'If other, what cadence?',
        optional: true,
        placeholder: 'Optional',
      },
      {
        id: 'q19_attend',
        number: 'Q19',
        kind: 'single',
        title: 'Would you personally like to attend the next MIRA workshop?',
        options: [
          { value: 'definitely', label: 'Definitely' },
          { value: 'probably', label: 'Probably' },
          { value: 'depends', label: 'Depends' },
          { value: 'no', label: 'No' },
        ],
      },
      {
        id: 'q20_location',
        number: 'Q20',
        kind: 'single',
        title: "For the next MIRA workshop, what's your location preference?",
        options: [
          { value: 'deerstone', label: 'Return to Deerstone' },
          { value: 'same_region', label: 'New venue, same region (Ireland/UK/Europe)' },
          { value: 'different_region', label: 'New venue, different region or continent' },
          { value: 'no_pref', label: 'No strong preference' },
        ],
      },
      {
        id: 'q21_venue_text',
        number: 'Q21',
        kind: 'text',
        title: 'What made the venue work or not work for you?',
        long: true,
        optional: true,
      },
      {
        id: 'q22_size',
        number: 'Q22',
        kind: 'single',
        title: 'This workshop had ~23 participants. For future gatherings, the ideal size is:',
        options: [
          { value: 'smaller', label: 'Smaller (more intimate)' },
          { value: 'about_same', label: 'About the same' },
          { value: 'somewhat_larger', label: 'Somewhat larger' },
          { value: 'much_larger', label: 'Much larger' },
        ],
      },
      {
        id: 'q_missing_voices',
        number: 'Q23',
        kind: 'text',
        title:
          "Who wasn't in the room that should have been? Any people, roles, disciplines, or perspectives we were missing?",
        long: true,
        optional: true,
      },
      {
        id: 'q23_iosp',
        number: 'Q24',
        kind: 'multi',
        title: 'How would you like to be involved in IOSP 2026?',
        help: 'Select all that apply.',
        helpLink: { text: 'What is IOSP? → iosp.science', href: 'https://iosp.science' },
        optional: true,
        options: [
          { value: 'attend', label: 'Attend' },
          { value: 'organize', label: 'Help organize or plan' },
          { value: 'facilitate', label: 'Facilitate a session' },
          { value: 'fund', label: 'Sponsor or help fund' },
          { value: 'recruit', label: 'Help recruit participants' },
          { value: 'not_sure', label: 'Not sure yet' },
          { value: 'probably_not', label: "Probably won't participate" },
        ],
      },
    ],
  },
  {
    title: 'Closing',
    questions: [
      {
        id: 'q24_keep',
        number: 'Q25',
        kind: 'text',
        title: 'KEEP — what should we keep?',
        long: true,
        optional: true,
      },
      {
        id: 'q24_change',
        kind: 'text',
        title: 'CHANGE — what should we change?',
        long: true,
        optional: true,
      },
      {
        id: 'q24_stop',
        kind: 'text',
        title: 'STOP — what should we stop?',
        long: true,
        optional: true,
      },
      {
        id: 'q25_anything',
        number: 'Q26',
        kind: 'text',
        title: "Anything we didn't ask that you'd like us to know?",
        long: true,
        optional: true,
      },
      {
        id: 'q26_name',
        number: 'Q27',
        kind: 'text',
        title: 'Your name',
        help: "Optional — only if you'd like us to be able to follow up with you. Responses are otherwise anonymous.",
        optional: true,
        placeholder: 'Optional',
      },
    ],
  },
]

export const ALL_QUESTIONS: Question[] = SURVEY_SECTIONS.flatMap((s) => s.questions)

/** Questions that must be answered before the form can be submitted. */
export const REQUIRED_QUESTION_IDS: string[] = ALL_QUESTIONS.filter(
  (q) => !q.optional
).map((q) => q.id)
