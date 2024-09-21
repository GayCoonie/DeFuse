--- STEAMODDED HEADER
--- MOD_NAME: DeFused
--- MOD_ID: DeFused
--- MOD_AUTHOR: [GayCoonie, itayfeder, Lyman, amstd, Gappie]
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
G.localization.misc.v_dictionary.sweet_theatre_combo = {"+#1#mult +#2#chips"}
G.localization.misc.v_dictionary.melancholy_phantom = {"X#1#mult +#2#chips"}

DeFused = {}

local function has_joker(val)
	for k, v in pairs(G.jokers.cards) do
		if v.ability.set == 'Joker' and v.config.center_key == val then 
			return k
		end
	end
	return -1
end

local updateref = Card.update
function Card:update(dt)
  updateref(self, dt)

  if G.STAGE == G.STAGES.RUN then

	if self.ability.name == "Flip-Flop" then
		if self.ability.extra.side == "mult" then
			if (self.config.center.atlas ~= "j_d_flip_flop" or G.localization.descriptions["Joker"]["j_d_flip_flop"] ~= G.localization.descriptions["Joker"]["j_d_flip_flop_mult"]) then
				G.localization.descriptions["Joker"]["j_d_flip_flop"] = G.localization.descriptions["Joker"]["j_d_flip_flop_mult"]
				self.config.center.atlas = "j_d_flip_flop"
				self:set_sprites(self.config.center)
			end
		else
			if (self.config.center.atlas ~= "j_d_flop_flip" or G.localization.descriptions["Joker"]["j_d_flip_flop"] ~= G.localization.descriptions["Joker"]["j_d_flip_flop_chips"]) then
				G.localization.descriptions["Joker"]["j_d_flip_flop"] = G.localization.descriptions["Joker"]["j_d_flip_flop_chips"]
				self.config.center.atlas = "j_d_flop_flip"
				self:set_sprites(self.config.center)

            end
   end
end


        if self.config.center.key == "j_d_original_character" then
            self.ability.extra.mult = (G.jokers.config.card_limit - #G.jokers.cards) * 12
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == 'Joker Stencil' then self.ability.extra = self.ability.extra + 6 end
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

    		if self.ability.name == 'Optimist' then
			G.hand:change_size(self.ability.extra.h_size)
			
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.ability.extra.h_plays
        	ease_hands_played(self.ability.extra.h_plays)
            	
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.ability.extra.d_size
        	ease_discard(self.ability.extra.d_size)
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

      if self.ability.name == "Monday Menace" then
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
        end
        if self.ability.name == "Original Character" then
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
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
		
		if self.ability.name == 'Optimist' then
			G.hand:change_size(-self.ability.extra.h_size)
			
			G.GAME.round_resets.hands = G.GAME.round_resets.hands - self.ability.extra.h_plays
        	ease_hands_played(-self.ability.extra.h_plays)
        	
			G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.ability.extra.d_size
        	ease_discard(-self.ability.extra.d_size)
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

        if self.ability.name == "Monday Menace" then
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            end
        end
        if self.ability.name == "Original Character" then
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            end
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
	if self.ability.set == "Joker" then
        if self.ability.name == 'Golden Egg' then
          return self.ability.extra.dollars
      end
	end
 return calculate_dollar_bonusref(self)
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

	local d_diamond_bard = SMODS.Joker:new("Diamond Bard", "d_diamond_bard", {extra = {
		money_threshold = 20, mult = 4, money = 1
	}}, { x = 0, y = 0 }, diamond_bard_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_d_diamond_bard", mod_obj.path, "j_diamond_bard.png", 71, 95, "asset_atli"):register();
	d_diamond_bard:register()

	function SMODS.Jokers.j_d_diamond_bard.loc_def(card)
		return {card.ability.extra.money, card.ability.extra.mult, card.ability.extra.money_threshold}
	end

	function SMODS.Jokers.j_d_diamond_bard.calculate(card, context)
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
  
	local d_heart_paladin = SMODS.Joker:new("Heart Paladin", "d_heart_paladin", {extra = {
		odds = 3, Xmult = 1.5
	}}, { x = 0, y = 0 }, heart_paladin_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_d_heart_paladin", mod_obj.path, "j_heart_paladin.png", 71, 95, "asset_atli"):register();
	d_heart_paladin:register()

	function SMODS.Jokers.j_d_heart_paladin.loc_def(card)
		return {card.ability.extra.Xmult, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}
	end

	function SMODS.Jokers.j_d_heart_paladin.calculate(card, context)
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

	local d_spade_archer = SMODS.Joker:new("Spade Archer", "d_spade_archer", {extra = {
		chips = 50, chip_mod = 10
	}}, { x = 0, y = 0 }, spade_archer_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_d_spade_archer", mod_obj.path, "j_spade_archer.png", 71, 95, "asset_atli"):register();
	d_spade_archer:register()

	function SMODS.Jokers.j_d_spade_archer.loc_def(card)
		return {card.ability.extra.chips, card.ability.extra.chip_mod}
	end

	function SMODS.Jokers.j_d_spade_archer.calculate(card, context)
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

	local d_club_wizard = SMODS.Joker:new("Club Wizard", "d_club_wizard", {extra = {
		mult = 24
	}}, { x = 0, y = 0 }, club_wizard_def, 3, 12, true, true, true, true)
	SMODS.Sprite:new("j_d_club_wizard", mod_obj.path, "j_club_wizard.png", 71, 95, "asset_atli"):register();
	d_club_wizard:register()

	function SMODS.Jokers.j_d_club_wizard.loc_def(card)
		return {card.ability.extra.mult}
	end

	function SMODS.Jokers.j_d_club_wizard.calculate(card, context)
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
	
	local d_big_bang = SMODS.Joker:new("Big Bang", "d_big_bang", {extra = {
		Xmult = 0.1
	}}, { x = 0, y = 0 }, big_bang_def, 3, 11, true, true, true, true)
	SMODS.Sprite:new("j_d_big_bang", mod_obj.path, "j_big_bang.png", 71, 95, "asset_atli"):register();
	d_big_bang:register()

	function SMODS.Jokers.j_d_big_bang.loc_def(card)
		return {card.ability.extra.Xmult}
	end

	function SMODS.Jokers.j_d_big_bang.calculate(card, context)
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

	local d_dynamic_duo = SMODS.Joker:new("Dynamic Duo", "d_dynamic_duo", {extra = {
		mult = 4, chips = 30
	}}, { x = 0, y = 0 }, dynamic_duo_def, 2, 8, true, true, true, true)
	SMODS.Sprite:new("j_d_dynamic_duo", mod_obj.path, "j_dynamic_duo.png", 71, 95, "asset_atli"):register();
	d_dynamic_duo:register()

	function SMODS.Jokers.j_d_dynamic_duo.loc_def(card)
		return {card.ability.extra.mult, card.ability.extra.chips}
	end

	function SMODS.Jokers.j_d_dynamic_duo.calculate(card, context)
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

	local d_collectible_chaos_card = SMODS.Joker:new("Collectible Chaos Card", "d_collectible_chaos_card", {extra = {
		per_reroll = 2, free = 1
	}, mult = 0}, { x = 0, y = 0 }, collectible_chaos_card_def, 2, 9, true, true, true, true)
	SMODS.Sprite:new("j_d_collectible_chaos_card", mod_obj.path, "j_collectible_chaos_card.png", 71, 95, "asset_atli"):register();
	d_collectible_chaos_card:register()

	function SMODS.Jokers.j_d_collectible_chaos_card.loc_def(card)
		return {card.ability.extra.per_reroll, card.ability.extra.free, card.ability.mult,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_d_collectible_chaos_card.calculate(card, context)
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

	local d_flip_flop = SMODS.Joker:new("Flip-Flop", "d_flip_flop", {extra = {
		hands = 2, discards = 2, mult = 8, chips = 50, side = "mult"
	}}, { x = 0, y = 0 }, flip_flop_hand_def, 2, 9, true, true, false, true)
	SMODS.Sprite:new("j_d_flip_flop", mod_obj.path, "j_flip_flop.png", 71, 95, "asset_atli"):register();
	SMODS.Sprite:new("j_d_flop_flip", mod_obj.path, "j_flop_flip.png", 71, 95, "asset_atli"):register();
	d_flip_flop:register()

	G.localization.descriptions["Joker"]["j_d_flip_flop_chips"] = flip_flop_discard_def
	G.localization.descriptions["Joker"]["j_d_flip_flop_mult"] = flip_flop_hand_def
	

	function SMODS.Jokers.j_d_flip_flop.loc_def(card)
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

	function SMODS.Jokers.j_d_flip_flop.calculate(card, context)
		if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			if card.ability.extra.side == "mult" then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
					func = function()
						card.ability.extra.side = "chips"
						G.localization.descriptions["Joker"]["j_d_flip_flop"] = G.localization.descriptions["Joker"]["j_d_flip_flop_chips"]
						card:juice_up(1, 1)
						card.config.center.atlas = "j_d_flop_flip"
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
						G.localization.descriptions["Joker"]["j_d_flip_flop"] = G.localization.descriptions["Joker"]["j_d_flip_flop_mult"]
						card:juice_up(1, 1)
						card.config.center.atlas = "j_d_flip_flop"
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

	local d_royal_decree = SMODS.Joker:new("Royal Decree", "d_royal_decree", {extra = {
		dollars = 2
	}, mult = 0}, { x = 0, y = 0 }, royal_decree_def, 2, 10, true, true, true, true)
	SMODS.Sprite:new("j_d_royal_decree", mod_obj.path, "j_royal_decree.png", 71, 95, "asset_atli"):register();
	d_royal_decree:register()

	function SMODS.Jokers.j_d_royal_decree.loc_def(card)
		return {card.ability.extra.dollars,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_d_royal_decree.calculate(card, context)
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

	local d_dementia_joker = SMODS.Joker:new("Dementia Joker", "d_dementia_joker", {extra = {
		mult = 3, odds = 3
	}, mult = 0}, { x = 0, y = 0 }, dementia_joker_def, 3, 8, true, true, true, true)
	SMODS.Sprite:new("j_d_dementia_joker", mod_obj.path, "j_dementia_joker.png", 71, 95, "asset_atli"):register();
	d_dementia_joker:register()

	function SMODS.Jokers.j_d_dementia_joker.loc_def(card)
		return {card.ability.extra.mult, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, 
		(G.jokers and G.jokers.cards and #G.jokers.cards or 0)*card.ability.extra.mult,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_d_dementia_joker.calculate(card, context)
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

	local d_golden_egg = SMODS.Joker:new("Golden Egg", "d_golden_egg", {extra = {
		dollars = 4
	}, mult = 0}, { x = 0, y = 0 }, golden_egg_def, 2, 10, true, true, false, true)
	SMODS.Sprite:new("j_d_golden_egg", mod_obj.path, "j_golden_egg.png", 71, 95, "asset_atli"):register();
	d_golden_egg:register()

	function SMODS.Jokers.j_d_golden_egg.loc_def(card)
		return {card.ability.extra.dollars,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_d_golden_egg.calculate(card, context)
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

	local d_flag_bearer = SMODS.Joker:new("Flag Bearer", "d_flag_bearer", {extra = {
		hand_add = 1, discard_sub = 1
	}, mult = 0}, { x = 0, y = 0 }, flag_bearer_def, 2, 9, true, true, false, true)
	SMODS.Sprite:new("j_d_flag_bearer", mod_obj.path, "j_flag_bearer.png", 71, 95, "asset_atli"):register();
	d_flag_bearer:register()

	function SMODS.Jokers.j_d_flag_bearer.loc_def(card)
		return {card.ability.extra.hand_add, card.ability.extra.discard_sub, card.ability.mult * (G.GAME.current_round.discards_left or 0),
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_d_flag_bearer.calculate(card, context)
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

	local d_uncanny_face = SMODS.Joker:new("Uncanny Face", "d_uncanny_face", {extra = {
		chips = 15, mult = 2
	}}, { x = 0, y = 0 }, uncanny_face_def, 2, 8, true, true, true, true)
	SMODS.Sprite:new("j_d_uncanny_face", mod_obj.path, "j_uncanny_face.png", 71, 95, "asset_atli"):register();
	d_uncanny_face:register()

	function SMODS.Jokers.j_d_uncanny_face.loc_def(card)
		return {card.ability.extra.chips, card.ability.extra.mult,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end
	
	function SMODS.Jokers.j_d_uncanny_face.calculate(card, context)
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

	local d_commercial_driver = SMODS.Joker:new("Commercial Driver", "d_commercial_driver", {extra = {
		bonus = 0.25, total = 1
	}}, { x = 0, y = 0 }, commercial_driver_def, 2, 8, true, true, true, true)
	SMODS.Sprite:new("j_d_commercial_driver", mod_obj.path, "j_commercial_driver.png", 71, 95, "asset_atli"):register();
	d_commercial_driver:register()

	function SMODS.Jokers.j_d_commercial_driver.loc_def(card)
		return {card.ability.extra.bonus, card.ability.extra.total,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_d_commercial_driver.calculate(card, context)
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

	local d_camping_trip = SMODS.Joker:new("Camping Trip", "d_camping_trip", {extra = {
		bonus_base = 5, bonus_final = 10
	}}, { x = 0, y = 0 }, camping_trip_def, 2, 10, true, true, true, true)
	SMODS.Sprite:new("j_d_camping_trip", mod_obj.path, "j_camping_trip.png", 71, 95, "asset_atli"):register();
	d_camping_trip:register()

	function SMODS.Jokers.j_d_camping_trip.loc_def(card)
		return {card.ability.extra.bonus_base, card.ability.extra.bonus_final,
		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
	end

	function SMODS.Jokers.j_d_camping_trip.calculate(card, context)
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

    	--j_sweet_theatre_combo
    	local sweet_theatre_combo_def = {
    		name = "Sweet Theatre Combo",
    		text = {
                "{C:mult}+#1#{} Mult",
    			"{C:chips}+#2#{} Chips",
    			"Destroyed after {C:attention}#3#{} rounds",
    			
    		}
    	}
    	
    	local d_sweet_theatre_combo = SMODS.Joker:new("Sweet Theatre Combo", "d_sweet_theatre_combo", {extra = {mult = 30, chips = 150,count = 5
    	}}, { x = 0, y = 0 }, sweet_theatre_combo_def, 2, 8, true, true, true, false)
    	SMODS.Sprite:new("j_d_sweet_theatre_combo", mod_obj.path, "j_sweet_theatre_combo.png", 71, 95, "asset_atli"):register();
    	d_sweet_theatre_combo:register()
    
    	function SMODS.Jokers.j_d_sweet_theatre_combo.loc_def(card)
    		return {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.count, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_sweet_theatre_combo.calculate(card, context)
    		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
    		    card.ability.extra.count=card.ability.extra.count-1
                if card.ability.extra.count<=0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                end      
            end
            
            if context.cardarea == G.jokers and not context.after and not context.before then
                return {
    				message = localize{type='variable',key='sweet_theatre_combo',vars={card.ability.extra.mult,card.ability.extra.chips}},
    				mult_mod = card.ability.extra.mult,
    				chip_mod = card.ability.extra.chips,
    			}
    		end
    	end
    	
    	--j_bribery_clown
    	local bribery_clown_def = {
    		name = "Bribery Joker",
    		text = {
                "Gains {C:red}+#2#{} Mult when any",
                "{C:attention}Booster Pack{} is skipped,",
                "and create a {C:tarot}Tarot{} card",
                "{C:inactive}(Must have room)",
                "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)",
    			
    		}
    	}
    	
    	local d_bribery_clown = SMODS.Joker:new("Bribery Clown", "d_bribery_clown", {extra = {mult = 8, mult_add = 4
    	}}, { x = 0, y = 0 }, bribery_clown_def, 2, 6, true, true, true, true)
    	SMODS.Sprite:new("j_d_bribery_clown", mod_obj.path, "j_bribery_clown.png", 71, 95, "asset_atli"):register();
    	d_bribery_clown:register()
    
    	function SMODS.Jokers.j_d_bribery_clown.loc_def(card)
    		return {card.ability.extra.mult, card.ability.extra.mult_add, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_bribery_clown.calculate(card, context)
    	    if context.skipping_booster and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult_add}},
                            colour = G.C.RED,}) 
                        return true
                    end}))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local tarot = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'hal')
                                tarot:add_to_deck()
                                G.consumeables:emplace(tarot)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                end
            end
    		
            if context.cardarea == G.jokers and not context.after and not context.before then
                return {
    				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
    				mult_mod = card.ability.extra.mult,
    			}
    		end
    	end
    	
    	--j_moorstone
        local moorstone_def = {
    		name = "Moorstone",
    		text = {
                "This Joker gains {C:chips}+#1#{} Chips",
                "for each {C:attention}Stone Card",
                "in your full deck",
                "Adds one {C:attention}Stone{} card",
                "to deck when",
                "played {C:attention}#3#{} {C:attention}Stone{} card",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
    			
    		}
    	}
    
    	local d_moorstone = SMODS.Joker:new("Moorstone", "d_moorstone", {extra = {chips_add = 40, chips = 0, count = 2
    	}}, { x = 0, y = 0 }, moorstone_def, 3, 8, true, true, true, true)
    	SMODS.Sprite:new("j_d_moorstone", mod_obj.path, "j_moorstone.png", 71, 95, "asset_atli"):register();
    	d_moorstone:register()
    
    	function SMODS.Jokers.j_d_moorstone.loc_def(card)
    	    card.ability.extra.chips = card.ability.extra.chips_add*(card.ability.stone_tally or 0)
    		return {card.ability.extra.chips_add, card.ability.extra.chips, card.ability.extra.count, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_moorstone.calculate(card, context)
    	    if context.individual and context.cardarea == G.play and
    		context.other_card.ability.effect == 'Stone Card' and not (context.blueprint_card or card).getting_sliced then
    		    card.ability.extra.count = card.ability.extra.count - 1
    		    if card.ability.extra.count <= 0 then
    		        card.ability.extra.count = 2
    		        G.E_MANAGER:add_event(Event({
                        func = function() 
                            local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
                            card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                            card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, card)
                            G.hand:emplace(card)
                            card.states.visible = nil
    
                            return true
                        end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced})
                   
                    playing_card_joker_effects({true})
    		    end
    		end
    		
    		if context.cardarea == G.jokers and not context.after and not context.before then
    			card.ability.stone_tally = 0
                for k, v in pairs(G.playing_cards) do
                    if v.config.center == G.P_CENTERS.m_stone then card.ability.stone_tally = card.ability.stone_tally+1 end
                end
                card.ability.extra.chips = card.ability.extra.chips_add*(card.ability.stone_tally or 0)
                if card.ability.stone_tally > 0 then
                    return {
                        message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                        chip_mod = card.ability.extra.chips, 
                        colour = G.C.CHIPS
                    }
                end
    		end
    	end
    	
    	--j_oscar_best_actor
    	local oscar_best_actor_def = {
    		name = "Oscar Best Actor",
    		text = {
                "Retrigger #1# times all",
                "card {C:attention}held in",
                "{C:attention}hand{} abilities",
                "and all played {C:attention}face{} cards",
    			
    		}
    	}
    
    	local d_oscar_best_actor = SMODS.Joker:new("Oscar Best Actor", "d_oscar_best_actor", {extra = {count = 1
    	}}, { x = 0, y = 0 }, oscar_best_actor_def, 3, 10, true, true, true, true)
    	SMODS.Sprite:new("j_d_oscar_best_actor", mod_obj.path, "j_oscar_best_actor.png", 71, 95, "asset_atli"):register();
    	d_oscar_best_actor:register()
    
    	function SMODS.Jokers.j_d_oscar_best_actor.loc_def(card)
    		return {card.ability.extra.count,
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_oscar_best_actor.calculate(card, context)
    		if context.repetition then
                if context.cardarea == G.play then
                    if true or (context.other_card:is_face()) then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = card.ability.extra.count,
                            card = card
                        }
                    end
                end
                if context.cardarea == G.hand then
                    if (next(context.card_effects[1]) or #context.card_effects > 1) then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = card.ability.extra.count,
                            card = card
                        }
                    end
                end
            end
    	end
    	
    	--j_optimist
    	local optimist_def = {
    		name = "Optimist",
    		text = {
                "{C:red}+#1#{} hand size",
                "{C:red}#2#{} hands per round",
                "{C:red}+#3#{} discards",
    			
    		}
    	}
    
    	local d_optimist = SMODS.Joker:new("Optimist", "d_optimist", {extra = {
    		h_size = 2, h_plays = -1, d_size = 2
    	}}, { x = 0, y = 0 }, optimist_def, 2, 12, true, true, false, true)
    	SMODS.Sprite:new("j_d_optimist", mod_obj.path, "j_optimist.png", 71, 95, "asset_atli"):register();
    	d_optimist:register()
    
    	function SMODS.Jokers.j_d_optimist.loc_def(card)
    		return {card.ability.extra.h_size, card.ability.extra.h_plays, card.ability.extra.d_size, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    	
    	--j_fight_a_bull
    	local fight_a_bull_def = {
    		name = "Fight A Bull",
    		text = {
                "{C:mult}+2{} Mult and {C:chips}+8{} Chips",
                "for every {C:money}$#1#{} you have",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Mult)",
                "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)",
                
    		}
    	}
    	
    	local d_fight_a_bull = SMODS.Joker:new("Fight A Bull", "d_fight_a_bull", {extra = {dollars = 3, mult = 0, chips = 0
    	}}, { x = 0, y = 0 }, fight_a_bull_def, 2, 8, true, true, true, true)
    	SMODS.Sprite:new("j_d_fight_a_bull", mod_obj.path, "j_fight_a_bull.png", 71, 95, "asset_atli"):register();
    	d_fight_a_bull:register()
    
    	function SMODS.Jokers.j_d_fight_a_bull.loc_def(card)
    	    card.ability.extra.mult = 2*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
            card.ability.extra.chips = 8*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
    		return {card.ability.extra.dollars, card.ability.extra.mult, card.ability.extra.chips, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_fight_a_bull.calculate(card, context)
            if context.cardarea == G.jokers and not context.after and not context.before then
                card.ability.extra.mult = 2*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
                card.ability.extra.chips = 8*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
                
                return {
    				message = localize{type='variable',key='d_sweet_theatre_combo',vars={card.ability.extra.mult,card.ability.extra.chips}},
    				mult_mod = card.ability.extra.mult,
    				chip_mod = card.ability.extra.chips,
    			}
    		end
    	end
    	
    	--j_melancholy_phantom
    	local melancholy_phantom_def = {
    		name = "Melancholy Phantom",
    		text = {
                "Gains {X:mult,C:white} X0.1 {} Mult and {C:chips}+8{} Chips",
                "per {C:attention}playing card{} added",
                "to your deck",
                "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                
    		}
    	}
    	
    	local d_melancholy_phantom = SMODS.Joker:new("Melancholy Phantom", "d_melancholy_phantom", {extra = {x_mult = 2, chips = 50
    	}}, { x = 0, y = 0 }, melancholy_phantom_def, 3, 10, true, true, true, true)
    	SMODS.Sprite:new("j_d_melancholy_phantom", mod_obj.path, "j_melancholy_phantom.png", 71, 95, "asset_atli"):register();
    	d_melancholy_phantom:register()
    
    	function SMODS.Jokers.j_d_melancholy_phantom.loc_def(card)
    		return {card.ability.extra.x_mult, card.ability.extra.chips, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_melancholy_phantom.calculate(card, context)
            if context.cardarea == G.jokers and not context.after and not context.before then
                return {
    				message = localize{type='variable',key='d_melancholy_phantom',vars={card.ability.extra.x_mult,card.ability.extra.chips}},
    				Xmult_mod = card.ability.extra.x_mult,
    				chip_mod = card.ability.extra.chips,
    			}
    		end
    		
    		if context.playing_card_added and not card.getting_sliced then
        		if (not context.blueprint) and context.cards and context.cards[1] then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + #context.cards*0.1
                    card.ability.extra.chips = card.ability.extra.chips + #context.cards*8
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'd_melancholy_phantom', vars = {card.ability.extra.x_mult,card.ability.extra.chips}}})
                end
            end
    	end
    	
    	--j_solar_flare_joker
    	local solar_flare_joker_def = {
    		name = "Solar Flare Joker",
    		text = {
                "{C:green}#1# in #2#{} chance to",
                "upgrade level of",
                "played {C:attention}poker hand{}",
                "and {C:attention}discarded poker hand",
                
    		}
    	}
    	
    	local d_solar_flare_joker = SMODS.Joker:new("Solar Flare Joker", "d_solar_flare_joker", {extra = {odds = 2
    	}}, { x = 0, y = 0 }, solar_flare_joker_def, 3, 10, true, true, true, true)
    	SMODS.Sprite:new("j_d_solar_flare_joker", mod_obj.path, "j_solar_flare_joker.png", 71, 95, "asset_atli"):register();
    	d_solar_flare_joker:register()
    
    	function SMODS.Jokers.j_d_solar_flare_joker.loc_def(card)
    		return {''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_solar_flare_joker.calculate(card, context)
            if context.pre_discard then
                if pseudorandom('solar_radiation') < G.GAME.probabilities.normal/card.ability.extra.odds and not context.hook then
                local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
                    level_up_hand(context.blueprint_card or card, text, nil, 1)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                end
            end
    		
    		if context.cardarea == G.jokers  and context.before then
                if pseudorandom('solar_radiation') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    return {
                        card = card,
                        level_up = true,
                        message = localize('k_level_up_ex')
                    }
                end
            end
    	end
    	
    	--j_blue_java
    	local blue_java_def = {
    		name = "Blue Java",
    		text = {
    			"{X:mult,C:white}X#1#{} Mult",
                "At the end of the round,",
                "{C:green}#2# in #3#{} chance to",
                "decrease by {X:mult,C:white}X1{} Mult",
                
    		}
    	}
    	
    	local d_blue_java = SMODS.Joker:new("Blue Java", "d_blue_java", {extra = {Xmult_mod = 0.5, Xmult = 7, odds = 6
    	}}, { x = 0, y = 0 }, blue_java_def, 3, 10, true, true, true, true)
    	SMODS.Sprite:new("j_d_blue_java", mod_obj.path, "j_blue_java.png", 71, 95, "asset_atli"):register();
    	d_blue_java:register()
    
    	function SMODS.Jokers.j_d_blue_java.loc_def(card)
    		return {card.ability.extra.Xmult, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_blue_java.calculate(card, context)
            if context.after and not context.blueprint and not context.repetition and not context.individual then
                if pseudorandom('hybrid_banana') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_mod
                    if card.ability.extra.Xmult < 1 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                card.T.r = -0.2
                                card:juice_up(0.3, 0.4)
                                card.states.drag.is = true
                                card.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                    func = function()
                                            G.jokers:remove_card(card)
                                            card:remove()
                                            card = nil
                                        return true; end})) 
                                return true
                            end
                        })) 
                        return {
                            message = localize('k_eaten_ex'),
                            colour = G.C.FILTER
                        }
                    end
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                        Xmult_mod = card.ability.extra.Xmult,
                    }
                end
            end
    		
    		if context.cardarea == G.jokers and not context.after and not context.before then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.Xmult,
                }
    		end
    	end
    	
    	--j_serial_killer
    	local serial_killer_def = {
    		name = "Serial Killer",
    		text = {
                "When {C:attention}Blind{} is selected,",
                "destroy Joker to the right",
                "and permanently add {C:attention}25%",
                "its sell value to this {C:red}Mult",
                "{C:inactive}(Currently {X:mult,C:white} X#1# {} Mult)",
                
    		}
    	}
    	
    	local d_serial_killer = SMODS.Joker:new("Serial Killer", "d_serial_killer", {extra = {Xmult_per = 0.25, Xmult = 2
    	}}, { x = 0, y = 0 }, serial_killer_def, 3, 10, true, true, true, true)
    	SMODS.Sprite:new("j_d_serial_killer", mod_obj.path, "j_serial_killer.png", 71, 95, "asset_atli"):register();
    	d_serial_killer:register()
    
    	function SMODS.Jokers.j_d_serial_killer.loc_def(card)
    		return {card.ability.extra.Xmult, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_d_serial_killer.calculate(self, context)
            if context.setting_blind and not self.getting_sliced and not context.blueprint then
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == self then my_pos = i; break end
                end
                if my_pos and G.jokers.cards[my_pos+1] and not self.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
                    local sliced_card = G.jokers.cards[my_pos+1]
                    sliced_card.getting_sliced = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.joker_buffer = 0
                        self.ability.extra.Xmult = self.ability.extra.Xmult + sliced_card.sell_cost*self.ability.extra.Xmult_per
                        self:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                        play_sound('slice1', 0.96+math.random()*0.08)
                    return true end }))
                    card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {self.ability.extra.Xmult+self.ability.extra.Xmult_per*sliced_card.sell_cost}}, colour = G.C.RED, no_juice = true})
                end
            end
    		
    		if context.cardarea == G.jokers and not context.after and not context.before then
                return {
                    message = localize{type='variable',key='a_xmult',vars={self.ability.extra.Xmult}},
                    Xmult_mod = self.ability.extra.Xmult,
                }
    		end
	end
local big_loser_def = {
    name = "Big Loser",
    text = {
        "Gain {C:attention}$4{} and {X:mult,C:white}X3{} Mult if",
        "{C:attention}poker hand{} is a {C:attention}#1#{},",
        "poker hand changes on",
        "every matching hand"
    }
}

local d_big_loser = SMODS.Joker:new("Big Loser", "d_big_loser", {
    extra = { 
        x_mult = 3,
        dollars = 4,
        poker_hand = "High Card"
    }
}, {x = 0, y = 0}, big_loser_def, 3, 10, true, true, true, true)
SMODS.Sprite:new("j_d_big_loser", mod_obj.path, "j_big_loser.png", 71, 95, "asset_atli"):register();
d_big_loser:register()

function SMODS.Jokers.j_d_big_loser.loc_def(card)
    return { card.ability.extra.poker_hand }
end

function SMODS.Jokers.j_d_big_loser.calculate(self, context)
            if context.joker_main and context.cardarea == G.jokers then
                if context.scoring_name == self.ability.extra.poker_hand then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible and k ~= self.ability.to_do_poker_hand then _poker_hands[#_poker_hands+1] = k end
                            end
                            self.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('to_do'))
                            return true
                        end
                    }))
                    ease_dollars(self.ability.extra.dollars) 
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult } },
                        Xmult_mod = self.ability.extra.x_mult
                    }
                end
    end
end


local tightrope_def = {
    name = "Tight Rope",
    text = {
        "{X:red,C:white} X#1# {} Mult on {C:attention}final hand{}",
        "of round. This Joker gains",
        "{X:red,C:white} X0.75{} Mult when {C:attention}final{}",
        "{C:attention}hand{} is played"
    }
}

local d_tightrope = SMODS.Joker:new("Tight Rope", "d_tightrope", {
    extra = { 
        x_mult = 3
    }
}, {x = 0, y = 0}, tightrope_def, 3, 10, true, true, true, true)
SMODS.Sprite:new("j_d_tightrope", mod_obj.path, "j_tightrope.png", 71, 95, "asset_atli"):register();
d_tightrope:register()

function SMODS.Jokers.j_d_tightrope.loc_def(card)
    return { card.ability.extra.x_mult }
end

function SMODS.Jokers.j_d_tightrope.calculate(self, context)
           if context.joker_main and context.cardarea == G.jokers then
                if G.GAME.current_round.hands_left == 0 then
                    self.ability.extra.x_mult = self.ability.extra.x_mult + 0.75
                    G.E_MANAGER:add_event(Event({
                        func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
                        end}))
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult } },
                        Xmult_mod = self.ability.extra.x_mult
}
        end
    end
end


local monday_menace_def = {
    name = "Monday Menace",
    text = {
        "{C:dark_edition}+1{} Joker Slot",
        "Create a random {C:planet}Planet{} or {C:tarot}Tarot{}",
        "card per 2 {C:attention}rerolls{} in the shop",
        "{C:inactive,s:0.7}({C:green,s:0.7}#1#{}{C:inactive,s:0.7} rerolls left){}",
        "{C:inactive,s:0.7}(Must have room){}"
    }
}

local d_monday_menace = SMODS.Joker:new("Monday Menace", "d_monday_menace", {
    extra = {
        counter = 2
    }
}, {x = 0, y = 0}, monday_menace_def, 2, 16, true, true, true, true)
SMODS.Sprite:new("j_d_monday_menace", mod_obj.path, "j_monday_menace.png", 71, 95, "asset_atli"):register();
d_monday_menace:register()

function SMODS.Jokers.j_d_monday_menace.loc_def(card)
    return { card.ability.extra.counter }
end

function SMODS.Jokers.j_d_monday_menace.calculate(self, context)
           if context.reroll_shop and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                if self.ability.extra.counter == 1 then
                    local tarot_or_planet = pseudorandom_element({1, 2}, pseudoseed('monday_menace'))
                    if tarot_or_planet == 1 then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                G.E_MANAGER:add_event(Event({
                                    func = function() 
                                        local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                        card:add_to_deck()
                                        G.consumeables:emplace(card)
                                        G.GAME.consumeable_buffer = 0
                                        return true
                                    end}))   
                            card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})                       
                                return true
                            end)}))
                    end
                    if tarot_or_planet == 2 then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                G.E_MANAGER:add_event(Event({
                                    func = function() 
                                        local card = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, '8ba')
                                        card:add_to_deck()
                                        G.consumeables:emplace(card)
                                        G.GAME.consumeable_buffer = 0
                                        return true
                                    end}))   
                                    card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})                       
                                return true
                            end)}))
                    end
                    self.ability.extra.counter = 2
                else
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        play_sound('tarot1')
                        self:juice_up(0.3, 0.5)
                        return true end }))
                    self.ability.extra.counter = self.ability.extra.counter - 1
        end
    end
end


local typography_def = {
    name = "Typography Joker",
    text = {
        "{C:blue}Common{} and {C:attention}Rare{} Jokers",
        "each give {C:mult}+10{} Mult if played hand",
        "contains no {C:attention}face cards{}"
    }
}

local d_typography = SMODS.Joker:new("Typography Joker", "d_typography", {
    extra = {
        mult = 10
    }
}, {x = 0, y = 0}, typography_def, 2, 8, true, true, true, true)
SMODS.Sprite:new("j_d_typography", mod_obj.path, "j_typography.png", 71, 95, "asset_atli"):register();
d_typography:register()

function SMODS.Jokers.j_d_typography.loc_def(card)
    return { card.ability.extra.mult }
end

function SMODS.Jokers.j_d_typography.calculate(self, context)
           if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == 5) and self ~= context.other_joker then
                local CheckForFaces = true
                for k, v in ipairs(context.full_hand) do
                    CheckForFaces = CheckForFaces and not v:is_face()
                end
                if not CheckForFaces then
                    return nil
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                return {
                    message = localize{type='variable',key='a_mult',vars={self.ability.extra.mult}},
                    mult_mod = self.ability.extra.mult
                }
    end
end


local party_animal_def = {
    name = "Party Animal",
    text = {
        "This Joker gains {C:chips}+16{} Chips",
        "when played hand is a",
        "{C:attention}High Card{} or {C:attention}Pair{}",
        "{C:inactive,s:0.7}(Currently {}{C:chips,s:0.7}+#1#{}{C:inactive,s:0.7} Chips){}"
    }
}

local d_party_animal = SMODS.Joker:new("Party Animal", "d_party_animal", {
    extra = {
        chips = 0
    }
}, {x = 0, y = 0}, party_animal_def, 2, 8, true, true, true, true)
SMODS.Sprite:new("j_d_party_animal", mod_obj.path, "j_party_animal.png", 71, 95, "asset_atli"):register();
d_party_animal:register()

function SMODS.Jokers.j_d_party_animal.loc_def(card)
    return { card.ability.extra.chips }
end

function SMODS.Jokers.j_d_party_animal.calculate(self, context)
            if context.joker_main and context.cardarea == G.jokers then
                if (context.scoring_name == "High Card" or context.scoring_name == "Pair") then
                    self.ability.extra.chips = self.ability.extra.chips + 16
                    G.E_MANAGER:add_event(Event({
                        func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
                        end}))
                end
                return {
                    message = localize{type='variable',key='a_chips',vars={self.ability.extra.chips}},
                    chip_mod = self.ability.extra.chips,
                    colour = G.C.CHIPS
                }
    end
end


local fishclown_def = {
    name = "Fishclown",
    text = {
        "{C:attention}Enhanced Cards{} gives",
        "{X:mult,C:white}X1.5{} Mult when scored"
    }
}

local d_fishclown = SMODS.Joker:new("Fishclown", "d_fishclown", {
    extra = {
        x_mult = 1.5
    }
}, {x = 0, y = 0}, fishclown_def, 3, 8, true, true, true, true)
SMODS.Sprite:new("j_d_fishclown", mod_obj.path, "j_fishclown.png", 71, 95, "asset_atli"):register();
d_fishclown:register()

function SMODS.Jokers.j_d_fishclown.loc_def(card)
    return { card.ability.extra.x_mult }
end

function SMODS.Jokers.j_d_fishclown.calculate(self, context)
            if context.individual and context.cardarea == G.play and context.other_card.ability.effect ~= 'Base' then
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult } },
                    x_mult = self.ability.extra.x_mult,
                    card = self
                }
    end
end



local original_character_def = {
    name = "Original Character",
    text = {
        "{C:dark_edition}+1{} Joker Slot",
        "{C:mult}+12{} Mult for each",
        "empty {C:attention}Joker{} slot",
        "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
    }
}

local d_original_character = SMODS.Joker:new("Original Character", "d_original_character", {
    extra = {
        mult = 0
    }
}, {x = 0, y = 0}, original_character_def, 2, 10, true, true, true, true)
SMODS.Sprite:new("j_d_original_character", mod_obj.path, "j_original_character.png", 71, 95, "asset_atli"):register();
d_original_character:register()

function SMODS.Jokers.j_d_original_character.loc_def(card)
    return { card.ability.extra.mult }
end

function SMODS.Jokers.j_d_original_character.calculate(self, context)
            if context.joker_main and context.cardarea == G.jokers and self.ability.extra.mult >= 0 then
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } },
                    mult_mod = self.ability.extra.mult,
                }
    end
end

end

----------------------------------------------
------------MOD CODE END----------------------
