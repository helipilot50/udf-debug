

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      info(formatting)
      tprint(v, indent+1)
    else
      info(formatting .. tostring(v))
    end
  end
end
-- debug routing to print the local heap

function dumpRecord (rec)
  info("record:")
  info(tostring(record.setname(rec))..":"..tostring(record.digest(rec))..
            ":(gen:"..tostring(record.gen(rec))..")"..
            ",(exp:"..tostring(record.ttl(rec))..")")
  info(" bins:")
  local names = record.bin_names(rec)
  for k, v in pairs(names) do
    local binVal = rec[v]
    info("  (" .. v .. ":"..tostring(binVal)..")")
  end
end



function dumpLocal()
  local i = 1 
  repeat
        local name, value = ldebug.getlocal(2, i)
        if name then 
          if type(value) == "table" then
            info("dump:"..name)
            tprint(value, 1)
          else
            info("dump:"..name.." = "..tostring(value)) 
          end
        end
        i = i + 1
  until not name
end
