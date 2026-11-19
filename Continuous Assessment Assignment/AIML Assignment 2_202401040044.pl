% SKIN CARE EXPERT CHATBOT
% PROLOG PROJECT

% SKIN TYPES

skin_type(oily).
skin_type(dry).
skin_type(combination).
skin_type(normal).
skin_type(sensitive).

% SKIN CONCERNS

concern(acne).
concern(dryness).
concern(oiliness).
concern(pigmentation).
concern(dullness).
concern(redness).

% INGREDIENT KNOWLEDGE
% What each ingredient helps with

helps(niacinamide, acne).
helps(niacinamide, oiliness).
helps(niacinamide, pigmentation).

helps(hyaluronic_acid, dryness).

helps(salicylic_acid, acne).
helps(salicylic_acid, oiliness).

helps(vitamin_c, pigmentation).
helps(vitamin_c, dullness).

helps(aloe_vera, redness).

helps(ceramides, dryness).

helps(zinc, acne).
helps(zinc, oiliness).

% INGREDIENTS SUITABLE FOR SKIN TYPES

suitable(oily, niacinamide).
suitable(oily, salicylic_acid).
suitable(oily, zinc).

suitable(dry, hyaluronic_acid).
suitable(dry, ceramides).

suitable(combination, niacinamide).
suitable(combination, hyaluronic_acid).

suitable(normal, niacinamide).
suitable(normal, hyaluronic_acid).

suitable(sensitive, aloe_vera).
suitable(sensitive, ceramides).

% RULE 1
% An ingredient is recommended when:
% 1. It helps the user's concern
% 2. It is suitable for the user's skin type

recommended(Skin, Concern, Ingredient) :-
    helps(Ingredient, Concern),
    suitable(Skin, Ingredient).

% GENTLE INGREDIENTS
% Ingredients considered gentle for high sensitivity

gentle(aloe_vera).
gentle(ceramides).
gentle(hyaluronic_acid).

% RULE 2
% Low sensitivity allows all suitable ingredients.
% High sensitivity allows only gentle ingredients.

sensitivity_ok(low, _).

sensitivity_ok(high, Ingredient) :-
    gentle(Ingredient).

% RULE 3
% An ingredient is safely recommended when:
% 1. It matches the skin type
% 2. It helps the concern
% 3. It is suitable for the sensitivity level

safe_recommendation(Skin, Concern, Sensitivity, Ingredient) :-
    recommended(Skin, Concern, Ingredient),
    sensitivity_ok(Sensitivity, Ingredient).

% SKIN TYPE OPTIONS

ask_skin_type(Skin) :-

    nl,
    write('------------------------------------------'), nl,
    write('           SELECT YOUR SKIN TYPE'), nl,
    write('------------------------------------------'), nl,

    write('1. Oily'), nl,
    write('2. Dry'), nl,
    write('3. Combination'), nl,
    write('4. Normal'), nl,
    write('5. Sensitive'), nl,

    write('Enter your choice (1-5 or name): '),
    read(Choice),

    skin_choice(Choice, Skin).

% Number input

skin_choice(1, oily).
skin_choice(2, dry).
skin_choice(3, combination).
skin_choice(4, normal).
skin_choice(5, sensitive).

% Word input

skin_choice(oily, oily).
skin_choice(dry, dry).
skin_choice(combination, combination).
skin_choice(normal, normal).
skin_choice(sensitive, sensitive).

% CONCERN OPTIONS

ask_concern(Concern) :-

    nl,
    write('------------------------------------------'), nl,
    write('          SELECT YOUR MAIN CONCERN'), nl,
    write('------------------------------------------'), nl,

    write('1. Acne'), nl,
    write('2. Dryness'), nl,
    write('3. Oiliness'), nl,
    write('4. Pigmentation'), nl,
    write('5. Dullness'), nl,
    write('6. Redness'), nl,

    write('Enter your choice (1-6 or name): '),
    read(Choice),

    concern_choice(Choice, Concern).

% Number input

concern_choice(1, acne).
concern_choice(2, dryness).
concern_choice(3, oiliness).
concern_choice(4, pigmentation).
concern_choice(5, dullness).
concern_choice(6, redness).

% Word input

concern_choice(acne, acne).
concern_choice(dryness, dryness).
concern_choice(oiliness, oiliness).
concern_choice(pigmentation, pigmentation).
concern_choice(dullness, dullness).
concern_choice(redness, redness).

% SENSITIVITY OPTIONS

ask_sensitivity(Sensitivity) :-

    nl,
    write('------------------------------------------'), nl,
    write('           SELECT SKIN SENSITIVITY'), nl,
    write('------------------------------------------'), nl,

    write('1. Low'), nl,
    write('2. High'), nl,

    write('Enter your choice (1-2 or name): '),
    read(Choice),

    sensitivity_choice(Choice, Sensitivity).

% Number input

sensitivity_choice(1, low).
sensitivity_choice(2, high).

% Word input

sensitivity_choice(low, low).
sensitivity_choice(high, high).

% SKIN TYPE ADVICE

skin_advice(oily) :-
    write('Skin Type: OILY'), nl,
    write('Advice: Focus on lightweight products and oil control.'), nl.

skin_advice(dry) :-
    write('Skin Type: DRY'), nl,
    write('Advice: Focus on hydration and skin barrier support.'), nl.

skin_advice(combination) :-
    write('Skin Type: COMBINATION'), nl,
    write('Advice: Balance hydration and oil control.'), nl.

skin_advice(normal) :-
    write('Skin Type: NORMAL'), nl,
    write('Advice: Maintain a simple and consistent routine.'), nl.

skin_advice(sensitive) :-
    write('Skin Type: SENSITIVE'), nl,
    write('Advice: Prefer gentle skincare products.'), nl.

% DISPLAY INGREDIENTS

show_list([]).

show_list([H|T]) :-
    write('- '),
    write(H),
    nl,
    show_list(T).

% FALLBACK RECOMMENDATION

% If no exact match is found,
% recommend ingredients based on the concern
% and sensitivity level.

fallback_recommendation(Concern, Sensitivity) :-

    findall(
        Ingredient,
        (
            helps(Ingredient, Concern),
            sensitivity_ok(Sensitivity, Ingredient)
        ),
        Ingredients
    ),

    write('No exact match was found for your skin type.'), nl,

    write('Safe concern-based alternatives:'), nl,

    show_list(Ingredients).

% PERSONALIZED RECOMMENDATION

give_recommendation(Skin, Concern, Sensitivity) :-

    findall(
        Ingredient,
        safe_recommendation(Skin, Concern, Sensitivity, Ingredient),
        Ingredients
    ),

    recommendation_result(Ingredients, Concern, Sensitivity).

% Exact recommendation found

recommendation_result([H|T], _, _) :-

    write('Exact personalized recommendation found!'), nl,

    write('Recommended ingredients:'), nl,

    write('- '),
    write(H),
    nl,

    show_list(T).

% No exact recommendation found

recommendation_result([], Concern, Sensitivity) :-

    fallback_recommendation(Concern, Sensitivity).

% BASIC SKINCARE ROUTINE

routine :-

    nl,
    write('             BASIC ROUTINE'), nl,
 

    nl,
    write('MORNING ROUTINE'), nl,
    write('1. Gentle cleanser'), nl,
    write('2. Recommended skincare product'), nl,
    write('3. Moisturizer'), nl,
    write('4. Sunscreen'), nl,

    nl,
    write('NIGHT ROUTINE'), nl,
    write('1. Gentle cleanser'), nl,
    write('2. Recommended treatment'), nl,
    write('3. Moisturizer'), nl.

% MAIN CHATBOT

start :-

    nl,
    write('        WELCOME TO SKIN CARE CHATBOT'), nl,
 

    write('Educational skincare assistant.'), nl,
    write('This chatbot does not diagnose medical conditions.'), nl,

    ask_skin_type(Skin),

    ask_concern(Concern),

    ask_sensitivity(Sensitivity),

    nl,
   
    write('               YOUR PROFILE'), nl,
  

    skin_advice(Skin),

    write('Main Concern: '),
    write(Concern),
    nl,

    write('Sensitivity: '),
    write(Sensitivity),
    nl,

    nl,

    write('        PERSONALIZED RECOMMENDATION'), nl,
   

    give_recommendation(Skin, Concern, Sensitivity),

    routine,

    nl,
    write('=========================================='), nl,
    write('Thank you for using the Skin Care Chatbot!'), nl,
    write('For persistent or severe concerns, consult a qualified dermatologist.'), nl.