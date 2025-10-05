local me = require("me")

local util = {}
util.me = me

function decode(info)
    if type(info) == "string" then return info end
    local str = {}
    for i = 2, #info do
        str[i-1] = decode(info[i])
    end
    return table.concat(str, "")
end

function util.get_list()
    local p = prototypes.item[me.name.."-list"]
    if p then
      local info = p.localised_description
      return decode(info)
    end
end

function util.force_enable_recipe(event, recipe_name)
  if game.players[event.player_index].force.recipes[recipe_name] then
    game.players[event.player_index].force.recipes[recipe_name].enabled=true      
  end
end


function util.warptorio2_expansion_helper() 
  if script.active_mods["warptorio2_expansion"] then
    function check_container_for_items(container,items)
      local has_all =true
      for k=1,#items do 
        if container.get_item_count(items[k].name)<items[k].count then has_all=false break end
      end
      return has_all 		
    end

    function remove_items_from_container(container,items)
      for k=1,#items do 
        container.remove_item(items[k])
      end	
    end

    script.on_nth_tick(60, function (event)
      if storage.done then return end
      local fix_items={
        {name='iron-plate',count=100},
        {name='iron-gear-wheel',count=100},
        {name='repair-pack',count=50},
      }
      local entities = {}
      for i=1,100 do
        if game.surfaces[i] then
          local lentities= game.surfaces[i].find_entities_filtered{area = {{-100, -100}, {100, 100}}, name = "wpe_broken_lab"}
          for j, entity in pairs(lentities) do
            table.insert(entities, entity)
          end
        end
      end
      if #entities == 0 then
        if storage.checking then
          -- The lab has already been fixed
          storage.done = true
        else
          -- Check that the lab doesn't reappear due to a warp
          storage.checking = true
        end
        return
      end
      if check_container_for_items(entities[1],fix_items) then
        remove_items_from_container(entities[1],fix_items)
        local lab = entities[1].surface.create_entity({name='wpe_repaired_lab', position=entities[1].position, force = game.forces.player})
        lab.destructible=false
        lab.minable=false
        entities[1].destroy()
        storage.done = true
      end
    end)
  end
end



return util
