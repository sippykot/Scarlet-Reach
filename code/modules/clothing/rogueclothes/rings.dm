

/obj/item/clothing/ring
	name = "ring"
	desc = ""
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/roguetown/clothing/rings.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/rings.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/rings.dmi'
	sleevetype = "shirt"
	icon_state = ""
	slot_flags = ITEM_SLOT_RING
	resistance_flags = FIRE_PROOF | ACID_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing
	experimental_inhand = FALSE
	drop_sound = 'sound/foley/coinphy (1).ogg'

/obj/item/clothing/ring/silver
	name = "silver ring"
	icon_state = "ring_s"
	sellprice = 33

/obj/item/clothing/ring/aalloy
	name = "decrepit ring"
	desc = "A decrepit old ring"
	icon_state = "ring_a"
	sellprice = 5


/obj/item/clothing/ring/gold
	name = "gold ring"
	icon_state = "ring_g"
	sellprice = 45

/obj/item/clothing/ring/active
	var/active = FALSE
	desc = "Unfortunately, like most magic rings, it must be used sparingly. (Right-click me to activate)"
	var/cooldowny
	var/cdtime
	var/activetime
	var/activate_sound

/obj/item/clothing/ring/active/attack_right(mob/user)
	if(loc != user)
		return
	if(cooldowny)
		if(world.time < cooldowny + cdtime)
			to_chat(user, span_warning("Nothing happens."))
			return
	user.visible_message(span_warning("[user] twists the [src]!"))
	if(activate_sound)
		playsound(user, activate_sound, 100, FALSE, -1)
	cooldowny = world.time
	addtimer(CALLBACK(src, PROC_REF(demagicify)), activetime)
	active = TRUE
	update_icon()
	activate(user)

/obj/item/clothing/ring/active/proc/activate(mob/user)
	user.update_inv_wear_id()

/obj/item/clothing/ring/active/proc/demagicify()
	active = FALSE
	update_icon()
	if(ismob(loc))
		var/mob/user = loc
		user.visible_message(span_warning("The ring settles down."))
		user.update_inv_wear_id()


/obj/item/clothing/ring/active/nomag
	name = "ring of null magic"
	icon_state = "ruby"
	activate_sound = 'sound/magic/antimagic.ogg'
	cdtime = 10 MINUTES
	activetime = 30 SECONDS
	sellprice = 100

/obj/item/clothing/ring/active/nomag/update_icon()
	..()
	if(active)
		icon_state = "rubyactive"
	else
		icon_state = "ruby"

/obj/item/clothing/ring/active/nomag/activate(mob/user)
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, FALSE, FALSE, ITEM_SLOT_RING, INFINITY, FALSE)

/obj/item/clothing/ring/active/nomag/demagicify()
	. = ..()
	var/datum/component/magcom = GetComponent(/datum/component/anti_magic)
	if(magcom)
		magcom.ClearFromParent()

//gold rings
/obj/item/clothing/ring/emerald
	name = "gemerald ring"
	icon_state = "g_ring_emerald"
	desc = "A beautiful golden ring with a polished Gemerald set into it."
	sellprice = 195

/obj/item/clothing/ring/ruby
	name = "rontz ring"
	icon_state = "g_ring_ruby"
	desc = "A beautiful golden ring with a polished Rontz set into it."
	sellprice = 255

/obj/item/clothing/ring/topaz
	name = "toper ring"
	icon_state = "g_ring_topaz"
	desc = "A beautiful golden ring with a polished Toper set into it."
	sellprice = 180

/obj/item/clothing/ring/quartz
	name = "blortz ring"
	icon_state = "g_ring_quartz"
	desc = "A beautiful golden ring with a polished Blortz set into it."
	sellprice = 245

/obj/item/clothing/ring/sapphire
	name = "saffira ring"
	icon_state = "g_ring_sapphire"
	desc = "A beautiful golden ring with a polished Saffira set into it."
	sellprice = 200

/obj/item/clothing/ring/diamond
	name = "dorpel ring"
	icon_state = "g_ring_diamond"
	desc = "A beautiful golden ring with a polished Dorpel set into it."
	sellprice = 270

/obj/item/clothing/ring/signet
	name = "Signet Ring"
	icon_state = "signet"
	desc = "A large golden ring engraved with the Symbol of Psydon."
	sellprice = 135

//silver rings
/obj/item/clothing/ring/emeralds
	name = "gemerald ring"
	icon_state = "s_ring_emerald"
	sellprice = 155

/obj/item/clothing/ring/rubys
	name = "rontz ring"
	icon_state = "s_ring_ruby"
	sellprice = 215

/obj/item/clothing/ring/topazs
	name = "toper ring"
	icon_state = "s_ring_topaz"
	sellprice = 140

/obj/item/clothing/ring/quartzs
	name = "blortz ring"
	icon_state = "s_ring_quartz"
	sellprice = 205

/obj/item/clothing/ring/sapphires
	name = "saffira ring"
	icon_state = "s_ring_sapphire"
	sellprice = 160

/obj/item/clothing/ring/diamonds
	name = "dorpel ring"
	icon_state = "s_ring_diamond"
	sellprice = 230

/obj/item/clothing/ring/dragon_ring
	name = "Dragon Ring"
	icon_state = "dragonring"
	desc = "Carrying the likeness of a dragon, this glorious ring hums with a subtle energy."
	sellprice = 666
	var/active_item

/obj/item/clothing/ring/dragon_ring/equipped(mob/living/user, slot)
	. = ..()
	if(active_item)
		return
	else if(slot == SLOT_RING)
		active_item = TRUE
		to_chat(user, span_notice("Here be dragons."))
		user.change_stat("strength", 2)
		user.change_stat("constitution", 2)
		user.change_stat("endurance", 2)
	return

/obj/item/clothing/ring/dragon_ring/dropped(mob/living/user)
	..()
	if(active_item)
		to_chat(user, span_notice("Gone is thy hoard."))
		user.change_stat("strength", -5)
		user.change_stat("constitution", -5)
		user.change_stat("endurance", -5)
		active_item = FALSE
	return

/obj/item/clothing/ring/duelist
	name = "duelist's ring"
	desc = "Born out of duelists desire for theatrics, this ring denotes a proposal — an honorable duel, with stakes set ahigh.\nIf both duelists wear this ring, successful baits will off balance them, and clashing disarms will never be unlikely.\n<i>'You shall know his name. You shall know his purpose. You shall die.'</i>"
	icon_state = "ring_duel"
	sellprice = 10

/obj/item/clothing/ring/fate_weaver
	name = "fate weaver"
	desc = "An arcyne creation first theorized by malcontents with the resolution of Xylix's plays. It protects is wearer by tugging things gently toward less fatal potentials."
	icon_state = "ring_s"
	max_integrity = 75
	body_parts_covered = COVERAGE_FULL | COVERAGE_HEAD_NOSE | NECK | HANDS | FEET //field covers the whole body
	armor = ARMOR_MASK_METAL_BAD //even protection against most damage types
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT)
	blade_dulling = DULLING_BASHCHOP
	blocksound = PLATEHIT
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/ring/fate_weaver/proc/dispel()
	if(!QDELETED(src))
		src.visible_message(span_warning("The [src]'s borders begin to shimmer and fade, before it vanishes entirely!"))
		qdel(src)

/obj/item/clothing/ring/fate_weaver/obj_break()
	. = ..()
	if(!QDELETED(src))
		dispel()

/obj/item/clothing/ring/fate_weaver/attack_hand(mob/user)
	. = ..()
	if(!QDELETED(src))
		dispel()
	
/obj/item/clothing/ring/fate_weaver/dropped()
	. = ..()
	if(!QDELETED(src))
		dispel()
