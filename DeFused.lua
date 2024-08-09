--- STEAMODDED HEADER
--- MOD_NAME: DeFused
--- MOD_ID: DeFused
--- MOD_AUTHOR: [GayCoonie, itayfeder, Lyman]
--- MOD_DESCRIPTION: Removes the ability to fuse jokers, keeps the special new jokers!
--- BADGE_COLOUR: 00E3E3
--- PRIORITY: -10000
----------------------------------------------
------------MOD CODE -------------------------


G.localization.misc.dictionary["k_fusion"] = "Fusion"
G.localization.misc.dictionary["k_flipped_ex"] = "Flipped!"
G.localization.misc.dictionary["k_copied_ex"] = "Cloned!"
G.localization.misc.dictionary["k_in_tact_ex"] = "In-Tact!"
G.localization.misc.dictionary["b_fuse"] = "FUSE"
FusionJokers = {}

local updateref = Card.update
function Card:update(dt)
  updateref(self, dt)

  if G.STAGE == G.STAGES.RUN then

	if self.ability.name == "Flip-Flop" then
		if self.ability.extra.side == "mult" then
			if (self.config.center.atlas ~= "j_flip_flop" or G.localization.descriptions["Joker"]["j_flip_flop"] ~= G.localization.descriptions["Joker"]["j_flip_flop_mult"]) then
				G.localization.descriptions["Joker"]["j_flip_flop"] = G.localization.descriptions["Joker"]["j_flip_flop_mult"]
				self.config.center.atlas = "j_flip_flop"
				self:set_sprites(self.config.center)
			end
		else
			if (self.config.center.atlas ~= "j_flop_flip" or G.localization.descriptions["Joker"]["j_flip_flop"] ~= G.localization.descriptions["Joker"]["j_flip_flop_chips"]) then
				G.localization.descriptions["Joker"]["j_flip_flop"] = G.localization.descriptions["Joker"]["j_flip_flop_chips"]
				self.config.center.atlas = "j_flop_flip"
				self:set_sprites(self.config.center)
			end
		end
	end
end
end

local add_to_deckref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
  	if not self.added_to_deck then
    	if self.ability.name == 'Collectible Chaos Card' then
			G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
			calculate_reroll_cost(true)
    	end

		if self.ability.name == 'Flip-Flop' then
			if self.ability.extra.side == "mult" then
				G.hand:change_size(self.ability.extra.hands)
			else
				G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.ability.extra.discards
            	ease_discard(self.ability.extra.discards)
			end
		end

		if self.ability.name == 'Star Oracle' then
			G.consumeables:change_size(self.ability.extra.slots)
		end
  	end
  	add_to_deckref(self, from_debuff)
end

local remove_from_deckref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
	if self.added_to_deck then
		if self.ability.name == 'Collectible Chaos Card' then
			G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls - 1
            calculate_reroll_cost(true)
		end
		
		if self.ability.name == 'Flip-Flop' then
			if self.ability.extra.side == "mult" then
				G.hand:change_size(-self.ability.extra.hands)
			else
				G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.ability.extra.discards
            	ease_discard(-self.ability.extra.discards)
			end
		end

		if self.ability.name == 'Star Oracle' then
			G.consumeables:change_size(-self.ability.extra.slots)
		end
	end
	remove_from_deckref(self, from_debuff)
end

local new_roundref = new_round
function new_round()
	new_roundref()
	local chaos = find_joker('Collectible Chaos Card')
	G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls or 0
    G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + #chaos
	calculate_reroll_cost(true)
end


local calculate_dollar_bonusref = Card.calculate_dollar_bonus
function Card:calculate_dollar_bonus()
	calculate_dollar_bonusref(self)
	if self.ability.set == "Joker" then
        if self.ability.name == 'Golden Egg' then
            return self.ability.extra.dollars
        end
	end
end

-- local shatterref = Card.shatter
-- function Card:shatter()
-- 	G.E_MANAGER:add_event(Event({
--         trigger = 'before',
--         blockable = false,
--         func = (function() 
-- 			if (self.ability.name == 'Glass Card') and find_joker("Moon Marauder") then
-- 				local _card = copy_card(self, nil, nil, G.playing_card)
-- 				_card:add_to_deck()
-- 				table.insert(G.playing_cards, _card)
-- 			end
-- 		return true end)
--     }))
	
-- 	shatterref(self)

-- end





function SMODS.INIT.DeFused()
	local mod_id = "DeFused"
	local mod_obj = SMODS.findModByID(mod_id)
	
	table.insert(G.P_JOKER_RARITY_POOLS, {})
	table.insert(G.C.RARITY, HEX("F7D762"))

	loc_colour("mult", nil)
    G.ARGS.LOC_COLOURS["fusion"] = G.C.RARITY[5]

	

	local diamond_bard_def = {
		name = "Diamond Bard",
		text = {
			"Played cards with {C:diamonds}Diamond{} suit give",
            "{C:money}$#1#{}, as well as {C:mult}+#2#{} Mult for every ",
			"{C:money}$#3#{} you have when scored"
		}
	}

	local diamond_bard = SMODS.Joker:new("Diamond Bard", "diamond_bard", {extra = {
		money_threshold = 20, mult = 4, money = 1
	}}, { x = 0, y = 0 }, diamond_bard_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_diamond_bard", mod_obj.path, "j_diamond_bard.png", 71, 95, "asset_atli"):register();
	diamond_bard:register()

	function SMODS.Jokers.j_diamond_bard.loc_def(card)
		return {card.ability.extra.money, card.ability.extra.mult, card.ability.extra.money_threshold}
	end

	function SMODS.Jokers.j_diamond_bard.calculate(card, context)
		if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Diamonds') then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
			G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
			return {
				dollars = card.ability.extra.money,
				mult = card.ability.extra.mult * (1 + math.floor(G.GAME.dollars / card.ability.extra.money_threshold)),
				card = card
			}
		end
	end



	local heart_paladin_def = {
		name = "Heart Paladin",
		text = {
			"Played cards with {C:hearts}Heart{} suit give",
            "{X:mult,C:white}X#1#{} Mult when scored.", 
			"{C:green}#2# in #3#{} chance to re-trigger"
		}
	}
  
	local heart_paladin = SMODS.Joker:new("Heart Paladin", "heart_paladin", {extra = {
		odds = 3, Xmult = 1.5
	}}, { x = 0, y = 0 }, heart_paladin_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_heart_paladin", mod_obj.path, "j_heart_paladin.png", 71, 95, "asset_atli"):register();
	heart_paladin:register()

	function SMODS.Jokers.j_heart_paladin.loc_def(card)
		return {card.ability.extra.Xmult, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}
	end

	function SMODS.Jokers.j_heart_paladin.calculate(card, context)
		if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Hearts') then
			return {
				x_mult = card.ability.extra.Xmult,
				card = card
			}
		end

		if context.repetition and context.cardarea == G.play and
		context.other_card:is_suit('Hearts') then
			if pseudorandom('heart_paladin') < G.GAME.probabilities.normal/card.ability.extra.odds then
				return {
					message = localize('k_again_ex'),
					repetitions = 1,
					card = card
				}
			end
		end
	end

	

	local spade_archer_def = {
		name = "Spade Archer",
		text = {
			"Played cards with {C:spades}Spade{} suit give",
            "{C:chips}+#1#{} Chips when scored. Gains {C:chips}+#2#{} ", 
			"chips when 5 {C:spades}Spades{} are played"
		}
	}

	local spade_archer = SMODS.Joker:new("Spade Archer", "spade_archer", {extra = {
		chips = 50, chip_mod = 10
	}}, { x = 0, y = 0 }, spade_archer_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_spade_archer", mod_obj.path, "j_spade_archer.png", 71, 95, "asset_atli"):register();
	spade_archer:register()

	function SMODS.Jokers.j_spade_archer.loc_def(card)
		return {card.ability.extra.chips, card.ability.extra.chip_mod}
	end

	function SMODS.Jokers.j_spade_archer.calculate(card, context)
		if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Spades') then
			return {
				chips = card.ability.extra.chips,
				card = card
			}
		end

		if context.before and context.cardarea == G.jokers then
			local spades = 0
			for k, v in ipairs(context.scoring_hand) do
				if v:is_suit('Spades') then
					spades = spades + 1
				end
			end
			if spades == 5 then 
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS,
					card = card
				}
			end
		end
	end



	local club_wizard_def = {
		name = "Club Wizard",
		text = {
			"Played cards with {C:clubs}Club{} suit",
            "give {C:mult}+#1#{} Mult when scored"
		}
	}

	local club_wizard = SMODS.Joker:new("Club Wizard", "club_wizard", {extra = {
		mult = 24
	}}, { x = 0, y = 0 }, club_wizard_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_club_wizard", mod_obj.path, "j_club_wizard.png", 71, 95, "asset_atli"):register();
	club_wizard:register()

	function SMODS.Jokers.j_club_wizard.loc_def(card)
		return {card.ability.extra.mult}
	end

	function SMODS.Jokers.j_club_wizard.calculate(card, context)
		if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Clubs') then
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
	end



	local big_bang_def = {
		name = "Big Bang",
		text = {
			"{X:mult,C:white} X#1# {} Mult per the number",
			"of times {C:attention}poker hand{} has been played",
			"plus the level of the {C:attention}poker hand{}."
			
		}
	}
	
	local big_bang = SMODS.Joker:new("Big Bang", "big_bang", {extra = {
		Xmult = 0.1
	}}, { x = 0, y = 0 }, big_bang_def, 3, 11, true, true, true, true)
	SMODS.Sprite:new("j_big_bang", mod_obj.path, "j_big_bang.png", 71, 95, "asset_atli"):register();
	big_bang:register()

	function SMODS.Jokers.j_big_bang.loc_def(card)
		return {card.ability.extra.Xmult}
	end

	function SMODS.Jokers.j_big_bang.calculate(card, context)
		if context.cardarea == G.jokers and not context.after and not context.before and context.scoring_name then
			local mult_val = 1 + card.ability.extra.Xmult * (G.GAME.hands[context.scoring_name].level + G.GAME.hands[context.scoring_name].played)
			return {
				message = localize{type='variable',key='a_xmult',vars={mult_val}},
                Xmult_mod = mult_val
			}
		end
	end



	local dynamic_duo_def = {
		name = "Dynamic Duo",
		text = {
			"Played {C:attention}number{} cards give {C:mult}+#1#{} Mult ",
			"and {C:chips}+#2#{} Chips when scored."
			
		}
	}

	local dynamic_duo = SMODS.Joker:new("Dynamic Duo", "dynamic_duo", {extra = {
		mult = 4, chips = 30
	}}, { x = 0, y = 0 }, dynamic_duo_def, 2, 8, true, true, true, true)
	SMODS.Sprite:new("j_dynamic_duo", mod_obj.path, "j_dynamic_duo.png", 71, 95, "asset_atli"):register();
	dynamic_duo:register()

	function SMODS.Jokers.j_dynamic_duo.loc_def(card)
		return {card.ability.extra.mult, card.ability.extra.chips}
	end

	function SMODS.Jokers.j_dynamic_duo.calculate(card, context)
		if context.individual and context.cardarea == G.play and
		not context.other_card:is_face() then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
				card = card
			}
		end
	end

	local collectible_chaos_card_def = {
		name = "Collectible Chaos Card",
		text = {
			"{C:mult}+#1#{} Mult per {C:attention}reroll{} in the shop.",
			"{C:attention}#2#{} free {C:green}Reroll{} per shop",
			"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
			
		}
	}

	local collectible_chaos_card = SMODS.Joker:new("Collectible Chaos Card", "collectible_chaos_card", {extra = {
		per_reroll = 2, free = 1
	}, mult = 0}, { x = 0, y = 0 }, collectible_chaos_card_def, 2, 9, true, true, true, true)
	SMODS.Sprite:new("j_collectible_chaos_card", mod_obj.path, "j_collectible_chaos_card.png", 71, 95, "asset_atli"):register();
	collectible_chaos_card:register()

	function SMODS.Jokers.j_collectible_chaos_card.loc_def(card)
		return {card.ability.extra.per_reroll, card.ability.extra.free, card.ability.mult,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_collectible_chaos_card.calculate(card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.mult = card.ability.mult + card.ability.extra.per_reroll
            G.E_MANAGER:add_event(Event({
                func = (function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.mult}}, colour = G.C.MULT})
                return true
             end)}))
		end

		if context.cardarea == G.jokers and card.ability.mult > 0 and not context.after and not context.before then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.mult}},
				mult_mod = card.ability.mult
			}
		end
	end

	

	local flip_flop_hand_def = {
		name = "Flip-Flop",
		text = {
			"{C:attention}+#1#{} hand size. {C:red}+#2#{} Mult",
			"{C:attention}Flips{} after each blind"
			
		}
	}

	local flip_flop_discard_def = {
		name = "Flip-Flop",
		text = {
			"{C:red}+#1#{} discard. {C:chips}+#2#{} Chips",
			"{C:attention}Flips{} after each blind"
			
		}
	}

	local flip_flop = SMODS.Joker:new("Flip-Flop", "flip_flop", {extra = {
		hands = 2, discards = 2, mult = 8, chips = 50, side = "mult"
	}}, { x = 0, y = 0 }, flip_flop_hand_def, 2, 9, true, true, false, true)
	SMODS.Sprite:new("j_flip_flop", mod_obj.path, "j_flip_flop.png", 71, 95, "asset_atli"):register();
	SMODS.Sprite:new("j_flop_flip", mod_obj.path, "j_flop_flip.png", 71, 95, "asset_atli"):register();
	flip_flop:register()

	G.localization.descriptions["Joker"]["j_flip_flop_chips"] = flip_flop_discard_def
	G.localization.descriptions["Joker"]["j_flip_flop_mult"] = flip_flop_hand_def
	

	function SMODS.Jokers.j_flip_flop.loc_def(card)
		if card.ability.extra.side == "mult" then
			return {card.ability.extra.hands, card.ability.extra.mult,
			localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
			localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
		else
			return {card.ability.extra.discards, card.ability.extra.chips, 
			localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
			localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
		end
	end

	function SMODS.Jokers.j_flip_flop.calculate(card, context)
		if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			if card.ability.extra.side == "mult" then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
					func = function()
						card.ability.extra.side = "chips"
						G.localization.descriptions["Joker"]["j_flip_flop"] = G.localization.descriptions["Joker"]["j_flip_flop_chips"]
						card:juice_up(1, 1)
						card.config.center.atlas = "j_flop_flip"
						card:set_sprites(card.config.center)

				return true; end})) 

				G.hand:change_size(-card.ability.extra.hands)
				G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
				ease_discard(card.ability.extra.discards)	

				return {
					message = localize('k_flipped_ex'),
					colour = G.C.CHIPS
				}
			else
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
					func = function()
						card.ability.extra.side = "mult"
						G.localization.descriptions["Joker"]["j_flip_flop"] = G.localization.descriptions["Joker"]["j_flip_flop_mult"]
						card:juice_up(1, 1)
						card.config.center.atlas = "j_flip_flop"
						card:set_sprites(card.config.center)

				return true; end})) 

				G.hand:change_size(card.ability.extra.hands)
				G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
				ease_discard(-card.ability.extra.discards)	
				
				return {
					message = localize('k_flipped_ex'),
					colour = G.C.MULT
				}
			end
			
		end

		if context.cardarea == G.jokers and not context.after and not context.before then
			if card.ability.extra.side == "mult" then
				return {
					message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
					mult_mod = card.ability.extra.mult, 
					colour = G.C.MULT
				}
			else
				return {
					message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
					chip_mod = card.ability.extra.chips, 
					colour = G.C.CHIPS
				}
			end
			
		end
	end


	
	local royal_decree_def = {
		name = "Royal Decree",
		text = {
			"Played {C:attention}face{} cards give {C:money}$#1#{} when scored.",
			"Each {C:attention}face{} card held in hand",
			"at end of round gives {C:money}$#1#{}"
			
		}
	}

	local royal_decree = SMODS.Joker:new("Royal Decree", "royal_decree", {extra = {
		dollars = 2
	}, mult = 0}, { x = 0, y = 0 }, royal_decree_def, 2, 10, true, true, true, true)
	SMODS.Sprite:new("j_royal_decree", mod_obj.path, "j_royal_decree.png", 71, 95, "asset_atli"):register();
	royal_decree:register()

	function SMODS.Jokers.j_royal_decree.loc_def(card)
		return {card.ability.extra.dollars,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_royal_decree.calculate(card, context)
		if context.end_of_round and context.individual then
			if context.cardarea == G.hand and context.other_card:is_face() then
				return {
					h_dollars = 2,
					card = card
				}
			end
		end

		if context.cardarea == G.play and context.individual and context.other_card:is_face() then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 2
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                dollars = 2,
                card = card
            }
			
		end
	end



	local dementia_joker_def = {
		name = "Dementia Joker",
		text = {
			"{C:mult}+#1#{} Mult for each {C:attention}Joker{} card.",
			"{C:green}#2# in #3#{} chance to {C:attention}clone{} if ",
			"not {C:dark_edition}Negative{} after you beat a blind",
			"{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)"
			
		}
	}

	local dementia_joker = SMODS.Joker:new("Dementia Joker", "dementia_joker", {extra = {
		mult = 3, odds = 3
	}, mult = 0}, { x = 0, y = 0 }, dementia_joker_def, 3, 8, true, true, true, true)
	SMODS.Sprite:new("j_dementia_joker", mod_obj.path, "j_dementia_joker.png", 71, 95, "asset_atli"):register();
	dementia_joker:register()

	function SMODS.Jokers.j_dementia_joker.loc_def(card)
		return {card.ability.extra.mult, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, 
		(G.jokers and G.jokers.cards and #G.jokers.cards or 0)*card.ability.extra.mult,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_dementia_joker.calculate(card, context)
		if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			if pseudorandom('dementia_joker') < G.GAME.probabilities.normal/card.ability.extra.odds 
			and not (card.edition and card.edition.negative) then
				local card = copy_card(card, nil, nil, nil, card.edition and card.edition.negative)
				card:set_edition({negative = true}, true)
				card:add_to_deck()
				G.jokers:emplace(card)
				return {
					message = localize('k_copied_ex'),
					colour = G.C.DARK_EDITION
				}
			end
		end

		if context.cardarea == G.jokers and not context.after and not context.before then
			local x = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.set == 'Joker' then x = x + 1 end
			end
			return {
				message = localize{type='variable',key='a_mult',vars={x*card.ability.extra.mult}},
				mult_mod = x*card.ability.extra.mult
			}
		end
	end



	local golden_egg_def = {
		name = "Golden Egg",
		text = {
			"Gains {C:money}$#1#{} of {C:attention}sell value{}",
			" at end of round.",
			" Earn {C:money}$#1#{} at end of round"
			
		}
	}

	local golden_egg = SMODS.Joker:new("Golden Egg", "golden_egg", {extra = {
		dollars = 4
	}, mult = 0}, { x = 0, y = 0 }, golden_egg_def, 2, 10, true, true, false, true)
	SMODS.Sprite:new("j_golden_egg", mod_obj.path, "j_golden_egg.png", 71, 95, "asset_atli"):register();
	golden_egg:register()

	function SMODS.Jokers.j_golden_egg.loc_def(card)
		return {card.ability.extra.dollars,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_golden_egg.calculate(card, context)
		if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.dollars
			card:set_cost()
			return {
				message = localize('k_val_up'),
				colour = G.C.MONEY
			}
		end
	end


	
	local flag_bearer_def = {
		name = "Flag Bearer",
		text = {
			"{C:mult}+#1#{} Mult per hand played, {C:mult}-#2#{} Mult",
			"per discard. Mult is multiplied by",
			" remaining {C:attention}discards{}",
			"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
			
		}
	}

	local flag_bearer = SMODS.Joker:new("Flag Bearer", "flag_bearer", {extra = {
		hand_add = 1, discard_sub = 1
	}, mult = 0}, { x = 0, y = 0 }, flag_bearer_def, 2, 9, true, true, false, true)
	SMODS.Sprite:new("j_flag_bearer", mod_obj.path, "j_flag_bearer.png", 71, 95, "asset_atli"):register();
	flag_bearer:register()

	function SMODS.Jokers.j_flag_bearer.loc_def(card)
		return {card.ability.extra.hand_add, card.ability.extra.discard_sub, card.ability.mult * (G.GAME.current_round.discards_left or 0),
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_flag_bearer.calculate(card, context)
		if context.discard and not context.blueprint and context.other_card == context.full_hand[#context.full_hand] then
			local prev_mult = card.ability.mult
			card.ability.mult = math.max(0, card.ability.mult - card.ability.extra.discard_sub)
			if card.ability.mult ~= prev_mult then 
				return {
					message = localize{type='variable',key='a_mult_minus',vars={card.ability.extra.discard_sub}},
					colour = G.C.RED,
					card = card
				}
			end
		end

		if context.cardarea == G.jokers and context.before then
			if not context.blueprint then
				card.ability.mult = card.ability.mult + card.ability.extra.hand_add
				return {
					card = card,
					message = localize{type='variable',key='a_mult',vars={card.ability.extra.hand_add}}
				}
			end
		end

		if context.cardarea == G.jokers and not context.after and not context.before then
			local mult = card.ability.mult * G.GAME.current_round.discards_left
			return {
				message = localize{type='variable',key='a_mult',vars={mult}},
				mult_mod = mult
			}
		end
	end


	local uncanny_face_def = {
		name = "Uncanny Face",
		text = {
			"Played {C:attention}face{} cards give {C:chips}+#1#{} Chips and",
			"{C:mult}+#2#{} Mult for every {C:attention}face{} card",
			" in the scoring hand"
			
		}
	}

	local uncanny_face = SMODS.Joker:new("Uncanny Face", "uncanny_face", {extra = {
		chips = 15, mult = 2
	}}, { x = 0, y = 0 }, uncanny_face_def, 2, 8, true, true, true, true)
	SMODS.Sprite:new("j_uncanny_face", mod_obj.path, "j_uncanny_face.png", 71, 95, "asset_atli"):register();
	uncanny_face:register()

	function SMODS.Jokers.j_uncanny_face.loc_def(card)
		return {card.ability.extra.chips, card.ability.extra.mult,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end
	
	function SMODS.Jokers.j_uncanny_face.calculate(card, context)
		if context.individual and context.cardarea == G.play and
		context.other_card:is_face() then
			local faces = 0
			for k, v in ipairs(context.scoring_hand) do
				if v:is_face() then
					faces = faces + 1
				end
			end
			return {
				mult = card.ability.extra.mult * faces,
				chips = card.ability.extra.chips * faces,
				card = card
			}
		end
	end


	local commercial_driver_def = {
		name = "Commercial Driver",
		text = {
			"{X:mult,C:white} X#1# {} Mult per consecutive hand",
			"played with a scoring {C:attention}enhanced{} card",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	}

	local commercial_driver = SMODS.Joker:new("Commercial Driver", "commercial_driver", {extra = {
		bonus = 0.25, total = 1
	}}, { x = 0, y = 0 }, commercial_driver_def, 2, 8, true, true, true, true)
	SMODS.Sprite:new("j_commercial_driver", mod_obj.path, "j_commercial_driver.png", 71, 95, "asset_atli"):register();
	commercial_driver:register()

	function SMODS.Jokers.j_commercial_driver.loc_def(card)
		return {card.ability.extra.bonus, card.ability.extra.total,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_commercial_driver.calculate(card, context)
		if context.before and context.cardarea == G.jokers then
			local enhanced = false
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].config.center ~= G.P_CENTERS.c_base then enhanced = true end
			end
			if not enhanced then
				local last_mult = card.ability.extra.total
				card.ability.extra.total = 1
				if last_mult > 0 then 
					return {
						card = card,
						message = localize('k_reset')
					}
				end
			else
				card.ability.extra.total = card.ability.extra.total + card.ability.extra.bonus
			end
		end

		if context.cardarea == G.jokers and not context.before and not context.after then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.total}},
				Xmult_mod = card.ability.extra.total
			}
		end
	end

	
	local camping_trip_def = {
		name = "Camping Trip",
		text = {
			"Played {C:attention}cards{} permanently gains",
			"{C:chips}+#1#{} Chips when scored",
			"({C:chips}+#2#{} on the final hand)",
			"Your final hand triggers twice"
		}
	}

	local camping_trip = SMODS.Joker:new("Camping Trip", "camping_trip", {extra = {
		bonus_base = 5, bonus_final = 10
	}}, { x = 0, y = 0 }, camping_trip_def, 2, 10, true, true, true, true)
	SMODS.Sprite:new("j_camping_trip", mod_obj.path, "j_camping_trip.png", 71, 95, "asset_atli"):register();
	camping_trip:register()

	function SMODS.Jokers.j_camping_trip.loc_def(card)
		return {card.ability.extra.bonus_base, card.ability.extra.bonus_final,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_camping_trip.calculate(card, context)
		if context.individual and context.cardarea == G.play then
			context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
			if G.GAME.current_round.hands_left == 0 then
				context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.bonus_final
			else
				context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.bonus_base
			end
            
            return {
                extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                colour = G.C.CHIPS,
                card = card
            }
		end

		if context.repetition and context.cardarea == G.play and G.GAME.current_round.hands_left == 0 then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		end
	end

end

----------------------------------------------
------------MOD CODE END----------------------
