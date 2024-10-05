let jokers = [
{
  name: "Diamond Bard",
  text: [
    "Played cards with {C:diamonds}Diamond{} suit give {C:money}$1{}, as well as {C:mult}+4{} Mult for every {C:money}$20{} you have when scored"
  ],
  image_url: "img/j_diamond_bard.png",
  rarity: "Rare"
},
{
  name: "Heart Paladin",
  text: [
    "Played cards with {C:hearts}Heart{} suit give {X:mult,C:white}X1.5{} Mult when scored. {C:green}1 in 3{} chance to re-trigger"
  ],
  image_url: "img/j_heart_paladin.png",
  rarity: "Rare"
},
{
  name: "Spade Archer",
  text: [
    "Played cards with {C:spades}Spade{} suit give {C:chips}+50{} Chips when scored. Gains {C:chips}+10{} chips when 5 {C:spades}Spades{} are played"
  ],
  image_url: "img/j_spade_archer.png",
  rarity: "Rare"
},
{
  name: "Club Wizard",
  text: [
    "Played cards with {C:clubs}Club{} suit give {C:mult}+24{} Mult when scored"
  ],
  image_url: "img/j_club_wizard.png",
  rarity: "Rare"
},
{
  name: "Big Bang",
  text: [
    "{X:mult,C:white} X0.1{} Mult per the number of times {C:attention}poker hand{} has been played plus the level of the {C:attention}poker hand{}."
  ],
  image_url: "img/j_big_bang.png",
  rarity: "Rare"
},
{
  name: "Dynamic Duo",
  text: [
    "Played {C:attention}number{} cards give {C:mult}+4{} Mult and {C:chips}+30{} Chips when scored."
  ],
  image_url: "img/j_dynamic_duo.png",
  rarity: "Uncommon"
},
{
  name: "Collectible Chaos Card",
  text: [
    "{C:mult}+2{} Mult per {C:attention}reroll{} in the shop. {C:attention}1{} free {C:green}Reroll{} per shop",
    "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
  ],
  image_url: "img/j_collectible_chaos_card.png",
  rarity: "Uncommon"
},
{
  name: "Flip-Flop",
  text: [
    "{C:attention}+2{} hand size. {C:red}+8{} Mult {C:attention}Flips{} after each blind"
  ],
  image_url: "img/j_flip_flop.png",
  rarity: "Uncommon"
},
{
  name: "Royal Decree",
  text: [
    "Played {C:attention}face{} cards give {C:money}$2{} when scored. Each {C:attention}face{} card held in hand at end of round gives {C:money}$2{}"
  ],
  image_url: "img/j_royal_decree.png",
  rarity: "Uncommon"
},
{
  name: "Dementia Joker",
  text: [
    "{C:mult}+3{} Mult for each {C:attention}Joker{} card. {C:green}1 in 3{} chance to {C:attention}clone{} if not {C:dark_edition}Negative{} after you beat a blind",
    "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
  ],
  image_url: "img/j_dementia_joker.png",
  rarity: "Rare"
},
{
  name: "Golden Egg",
  text: [
    "Gains {C:money}$4{} of {C:attention}sell value{} at end of round. Earn {C:money}$4{} at end of round"
  ],
  image_url: "img/j_golden_egg.png",
  rarity: "Uncommon"
},
{
  name: "Flag Bearer",
  text: [
    "{C:mult}+1{} Mult per hand played, {C:mult}-1{} Mult per discard. Mult is multiplied by remaining {C:attention}discards{}",
    "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
  ],
  image_url: "img/j_flag_bearer.png",
  rarity: "Uncommon"
},
{
  name: "Uncanny Face",
  text: [
    "Played {C:attention}face{} cards give {C:chips}+15{} Chips and {C:mult}+2{} Mult for every {C:attention}face{} card in the scoring hand"
  ],
  image_url: "img/j_uncanny_face.png",
  rarity: "Uncommon"
},
{
  name: "Commercial Driver",
  text: [
    "{X:mult,C:white} X0.25{} Mult per consecutive hand played with a scoring {C:attention}enhanced{} card",
    "{C:inactive}(Currently {X:mult,C:white}X1{C:inactive} Mult)"
  ],
  image_url: "img/j_commercial_driver.png",
  rarity: "Uncommon"
},
{
  name: "Camping Trip",
  text: [
    "Played {C:attention}cards{} permanently gains {C:chips}+5{} Chips when scored ({C:chips}+10{} on the final hand). Your final hand triggers twice"
  ],
  image_url: "img/j_camping_trip.png",
  rarity: "Uncommon"
},
{
  name: "Sweet Theatre Combo",
  text: [
    "{C:mult}+30{} Mult {C:chips}+150{} Chips Destroyed after {C:attention}5{} rounds"
  ],
  image_url: "img/j_sweet_theatre_combo.png",
  rarity: "Uncommon"
},
{
  name: "Bribery Joker",
  text: [
    "Gains {C:red}+4{} Mult when any {C:attention}Booster Pack{} is skipped, and create a {C:tarot}Tarot{} card",
    "{C:inactive}(Must have room)",
    "{C:inactive}(Currently {C:red}+8{C:inactive} Mult)"
  ],
  image_url: "img/j_bribery_clown.png",
  rarity: "Uncommon"
},
{
  name: "Moorstone",
  text: [
    "This Joker gains {C:chips}+40{} Chips for each {C:attention}Stone Card in your full deck. Adds one {C:attention}Stone{} card to deck when played {C:attention}2{} {C:attention}Stone{} card",
    "{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)"
  ],
  image_url: "img/j_moorstone.png",
  rarity: "Rare"
},
{
  name: "Oscar Best Actor",
  text: [
    "Retrigger 1 times all card {C:attention}held in {C:attention}hand{} abilities and all played {C:attention}face{} cards"
  ],
  image_url: "img/j_oscar_best_actor.png",
  rarity: "Rare"
},
{
  name: "Optimist",
  text: [
    "{C:red}+2{} hand size {C:red}-1{} hands per round {C:red}+2{} discards"
  ],
  image_url: "img/j_optimist.png",
  rarity: "Uncommon"
},
{
  name: "Fight A Bull",
  text: [
    "{C:mult}+2{} Mult and {C:chips}+8{} Chips for every {C:money}$3{} you have",
    "{C:inactive}(Currently {C:chips}+0{C:inactive} Mult)",
    "{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)"
  ],
  image_url: "img/j_fight_a_bull.png",
  rarity: "Uncommon"
},
{
  name: "Melancholy Phantom",
  text: [
    "Gains {X:mult,C:white} X0.1{} Mult and {C:chips}+8{} Chips per {C:attention}playing card{} added to your deck",
    "{C:inactive}(Currently {X:mult,C:white} X2{C:inactive} Mult)",
    "{C:inactive}(Currently {C:chips}+50{C:inactive} Chips)"
  ],
  image_url: "img/j_melancholy_phantom.png",
  rarity: "Rare"
},
{
  name: "Solar Flare Joker",
  text: [
    "{C:green}1 in 2{} chance to upgrade level of played {C:attention}poker hand{} and {C:attention}discarded poker hand"
  ],
  image_url: "img/j_solar_flare_joker.png",
  rarity: "Rare"
},
{
  name: "Blue Java",
  text: [
    "{X:mult,C:white}X7{} Mult At the end of the round, {C:green}1 in 6{} chance to decrease by {X:mult,C:white}X1{} Mult"
  ],
  image_url: "img/j_blue_java.png",
  rarity: "Rare"
},
{
  name: "Serial Killer",
  text: [
    "When {C:attention}Blind{} is selected, destroy Joker to the right and permanently add {C:attention}25% its sell value to this {C:red}Mult",
    "{C:inactive}(Currently {X:mult,C:white} X2{} Mult)"
  ],
  image_url: "img/j_serial_killer.png",
  rarity: "Rare"
},
{
  name: "Big Loser",
  text: [
    "Gain {C:attention}$4{} and {X:mult,C:white}X3{} Mult if {C:attention}poker hand{} is a {C:attention}High Card{}, poker hand changes on every matching hand"
  ],
  image_url: "img/j_big_loser.png",
  rarity: "Rare"
},
{
  name: "Tight Rope",
  text: [
    "{X:red,C:white} X3{} Mult on {C:attention}final hand{} of round. This Joker gains {X:red,C:white} X0.75{} Mult when {C:attention}final{} {C:attention}hand{} is played"
  ],
  image_url: "img/j_tightrope.png",
  rarity: "Rare"
},
{
  name: "Monday Menace",
  text: [
    "{C:dark_edition}+1{} Joker Slot Create a random {C:planet}Planet{} or {C:tarot}Tarot{} card per 2 {C:attention}rerolls{} in the shop",
    "{C:inactive,s:0.7}({C:green,s:0.7}2{}{C:inactive,s:0.7} rerolls left){}",
    "{C:inactive,s:0.7}(Must have room){}"
  ],
  image_url: "img/j_monday_menace.png",
  rarity: "Uncommon"
},
{
  name: "Typography Joker",
  text: [
    "{C:blue}Common{} and {C:attention}Rare{} Jokers each give {C:mult}+10{} Mult if played hand contains no {C:attention}face cards{}"
  ],
  image_url: "img/j_typography.png",
  rarity: "Uncommon"
},
{
  name: "Party Animal",
  text: [
    "This Joker gains {C:chips}+16{} Chips when played hand is a {C:attention}High Card{} or {C:attention}Pair{}",
    "{C:inactive,s:0.7}(Currently {C:chips,s:0.7}+0{C:inactive,s:0.7} Chips){}"
  ],
  image_url: "img/j_party_animal.png",
  rarity: "Uncommon"
},
{
  name: "Fishclown",
  text: [
    "{C:attention}Enhanced Cards{} gives {X:mult,C:white}X1.5{} Mult when scored"
  ],
  image_url: "img/j_fishclown.png",
  rarity: "Rare"
},
{
  name: "Original Character",
  text: [
    "{C:dark_edition}+1{} Joker Slot {C:mult}+12{} Mult for each empty {C:attention}Joker{} slot",
    "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
  ],
  image_url: "img/j_original_character.png",
  rarity: "Uncommon"
}
]

// works the same. 
let consumables = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Tarot"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Planet"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Spectral"
  // },
]

let card_modifications = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Enhancement"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Edition"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Seal"
  // },
]

let decks = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Deck"
  // },
]

let stickers = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Sticker"
  // },
]

let blinds = [
  // {
  //   name: "The Wall",
  //   text: [
  //     "Extra large blind",
  //     "{C:inactive}({C:red}4x{C:inactive} Base for {C:attention}$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 2)"
  //   ],
  //   image_url: "img/the_wall.png",
  //   rarity: "Boss Blind"
  // },
  // {
  //   name: "Violet Vessel",
  //   text: [
  //     "Very large blind",
  //     "{C:inactive}({C:red}6x{C:inactive} Base for {C:attention}$$$$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 8)"
  //   ],
  //   image_url: "img/violet_vessel.png",
  //   rarity: "Showdown"
  // },
]

let shop_items = [
  {
    name: "Joker",
    text: [
      "{C:mult}+4{} Mult"
    ],
    image_url: "img/j_joker.png",
    rarity: "Voucher"
  },
  {
    name: "Joker",
    text: [
      "{C:mult}+4{} Mult"
    ],
    image_url: "img/j_joker.png",
    rarity: "Pack"
  },
]

let cols = {
  
  MULT: "#FE5F55",
  CHIPS: "#009dff",
  MONEY: "#f3b958",
  XMULT: "#FE5F55",
  FILTER: "#ff9a00",
  ATTENTION: "#ff9a00",
  BLUE: "#009dff",
  RED: "#FE5F55",
  GREEN: "#4BC292",
  PALE_GREEN: "#56a887",
  ORANGE: "#fda200",
  IMPORTANT: "#ff9a00",
  GOLD: "#eac058",
  YELLOW: "#ffff00",
  CLEAR: "#00000000", 
  WHITE: "#ffffff",
  PURPLE: "#8867a5",
  BLACK: "#374244",
  L_BLACK: "#4f6367",
  GREY: "#5f7377",
  CHANCE: "#4BC292",
  JOKER_GREY: "#bfc7d5",
  VOUCHER: "#cb724c",
  BOOSTER: "#646eb7",
  EDITION: "#ffffff",
  DARK_EDITION: "#5d5dff",
  ETERNAL: "#c75985",
  INACTIVE: "#ffffff99",
  HEARTS: "#f03464",
  DIAMONDS: "#f06b3f",
  SPADES: "#403995",
  CLUBS: "#235955",
  ENHANCED: "#8389DD",
  JOKER: "#708b91",
  TAROT: "#a782d1",
  PLANET: "#13afce",
  SPECTRAL: "#4584fa",
  VOUCHER: "#fd682b",
  EDITION: "#4ca893",
}

let rarities = {
  "Common": "#009dff", 
  "Uncommon": "#4BC292",
  "Rare": "#fe5f55",
  "Legendary": "#b26cbb",
  "Joker": "#708b91",
  "Tarot": "#a782d1",
  "Planet": "#13afce",
  "Spectral": "#4584fa",
  "Voucher": "#fd682b",
  "Pack": "#9bb6bd",
  "Enhancement": "#8389DD",
  "Edition": "#4ca893",
  "Seal": "#4584fa",
  "Deck": "#9bb6bd",
  "Sticker": "#5d5dff",
  "Boss Blind": "#5d5dff",
  "Showdown": "#4584fa",
}

regex = /{([^}]+)}/g;

let add_cards_to_div = (jokers, jokers_div) => {
  for (let joker of jokers) {
    console.log("adding joker", joker.name);
  
    joker.text = joker.text.map((line) => { return line + "{}"});
  
    joker.text = joker.text.join("<br/>");
    joker.text = joker.text.replaceAll("{}", "</span>");
    joker.text = joker.text.replace(regex, function replacer(match, p1, offset, string, groups) {
      let classes = p1.split(",");
  
      let css_styling = "";
  
      for (let i = 0; i < classes.length; i++) {
        let parts = classes[i].split(":");
        if (parts[0] === "C") {
          css_styling += `color: ${cols[parts[1].toUpperCase()]};`;
        } else if (parts[0] === "X") {
          css_styling += `background-color: ${cols[parts[1].toUpperCase()]}; border-radius: 5px; padding: 0 5px;`;
        }
      }
  
      return `</span><span style='${css_styling}'>`;
    });
  
    let joker_div = document.createElement("div");
    joker_div.classList.add("joker");
    if (joker.rarity === "Sticker" || joker.rarity == "Seal") {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" class="hasback" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else if (joker.soul) {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <span class="soulholder">
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-bg" />
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-top" />
        </span>
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    }
  
    jokers_div.appendChild(joker_div);
  }
}

if (jokers.length === 0) {
  document.querySelector(".jokersfull").style.display = "none"
} else {
  let jokers_div = document.querySelector(".jokers");
  add_cards_to_div(jokers, jokers_div);
}

if (consumables.length === 0) {
  document.querySelector(".consumablesfull").style.display = "none"
} else {
  let consumables_div = document.querySelector(".consumables");
  add_cards_to_div(consumables, consumables_div);
}

if (card_modifications.length === 0) {
  document.querySelector(".cardmodsfull").style.display = "none"
} else {
  let cardmods_div = document.querySelector(".cardmods");
  add_cards_to_div(card_modifications, cardmods_div);
}

if (decks.length === 0) {
  document.querySelector(".decksfull").style.display = "none"
} else {
  let decks_div = document.querySelector(".decks");
  add_cards_to_div(decks, decks_div);
}

if (stickers.length === 0) {
  document.querySelector(".stickersfull").style.display = "none"
} else {
  let stickers_div = document.querySelector(".stickers");
  add_cards_to_div(stickers, stickers_div);
}

if (blinds.length === 0) {
  document.querySelector(".blindsfull").style.display = "none"
} else {
  let blinds_div = document.querySelector(".blinds");
  add_cards_to_div(blinds, blinds_div);
}

if (shop_items.length === 0) {
  document.querySelector(".shopitemsfull").style.display = "none"
} else {
  let shopitems_div = document.querySelector(".shopitems");
  add_cards_to_div(shop_items, shopitems_div);
}
