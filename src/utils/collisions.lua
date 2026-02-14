local Collisions = {}

function Collisions:checkHitBox(a, b)
  local a_left = a.x + a.ox
  local a_right = a.x + a.ox + a.width
  local a_top = a.y + a.oy
  local a_bottom = a.y + a.oy + a.height

  local b_left = b.x + b.ox
  local b_right = b.x + b.ox + b.width
  local b_top = b.y + b.oy
  local b_bottom = b.y + b.oy + b.height

  return a_left < b_right and a_right > b_left and
         a_top < b_bottom and a_bottom > b_top
end


function Collisions:genericAABB(a, b)
  return a.x + a.width > b.x and a.x < b.x + b.width and
         a.y + a.height > b.y and a.y < b.y + b.height
end

return Collisions
