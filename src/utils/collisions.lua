local Collisions = {}

function Collisions:checkHitBox(a, b)
  local a_left = a.x + a.ox
  local a_right = a.x + a.ox + a.width
  local a_top = a.y + a.oy
  local a_bottom = a.y + a.oy + a.height

  return a_left < b.x + b.width and a_right > b.x and
         a_top < b.y + b.height and a_bottom > b.y
end


function Collisions:genericAABB(a, b)
  return a.x + a.width > b.x and a.x < b.x + b.width and
         a.y + a.height > b.y and a.y < b.y + b.height
end

return Collisions
