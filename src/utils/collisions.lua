local Collisions = {}

function Collisions:AABB(a, b)
  return a.x + a.width > b.x and a.x < b.x + b.width and
         a.y + a.height > b.y and a.y < b.y + b.height
end

return Collisions
