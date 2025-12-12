using Microsoft.AspNetCore.Mvc;
using VendingMachinesAPI.Models;

namespace VendingMachinesAPI.Contorllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MachinesController : Controller
    {
        private readonly VendingMachinesContext _context;

        public MachinesController (VendingMachinesContext context)
        {
            _context = context;
        }

        [HttpGet("test")]
        public IActionResult Test()
        {
            return Ok("Test works");
        }

        [HttpGet("get-all-machines")]
        public IActionResult GetMachines()
        {
            var machines = _context.ВендинговыйАппаратs.ToList();
            return Ok(machines);
        }

        [HttpPost]
        public IActionResult AddMachine(ВендинговыйАппаратДТО addMachineDTO)
        {
            try
            {
                var machine = new ВендинговыйАппарат()
                {
                    Местоположение = addMachineDTO.Местоположение,
                    Модель = addMachineDTO.Модель,
                    Доход = addMachineDTO.Доход,
                    СерийныйНомер = addMachineDTO.СерийныйНомер,
                    ИнвентарныйНомер = addMachineDTO.ИнвентарныйНомер,
                    КодИзготовитель = addMachineDTO.КодИзготовитель,
                    КодКалендарь = addMachineDTO.КодКалендарь,
                    КодРесурс = addMachineDTO.КодРесурс,
                    КодСтатус = addMachineDTO.КодСтатус,
                    КодТипАппарата = addMachineDTO.КодТипАппарата,
                    КодСтранаПроизводства = addMachineDTO.КодСтранаПроизводства,
                    КодСотрудник = addMachineDTO.КодСотрудник,
                    КодПользователь = addMachineDTO.КодПользователь
                };
                _context.ВендинговыйАппаратs.Add(machine);
                _context.SaveChanges();

                return Ok(machine);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Ошибка: {ex.Message}");
            }
        }

        [HttpPut("{serialNumber:long}")]
        public IActionResult EditMachine(long serialNumber, [FromBody]ОбнвовитьАппаратДТО updateMachine)
        {
            try
            {
                var machine = _context.ВендинговыйАппаратs.FirstOrDefault(s => s.СерийныйНомер == serialNumber);
                machine.Местоположение = updateMachine.Местоположение;
                machine.Модель = updateMachine.Модель;
                machine.Доход = updateMachine.Доход;
                machine.ИнвентарныйНомер = updateMachine.ИнвентарныйНомер;
                machine.КодИзготовитель = updateMachine.КодИзготовитель;
                machine.КодКалендарь = updateMachine.КодКалендарь;
                machine.КодРесурс = updateMachine.КодРесурс;
                machine.КодСтатус = updateMachine.КодСтатус;
                machine.КодТипАппарата = updateMachine.КодТипАппарата;
                machine.КодСтранаПроизводства = updateMachine.КодСтранаПроизводства;
                machine.КодСотрудник = updateMachine.КодСотрудник;
                machine.КодПользователь = updateMachine.КодПользователь;

                _context.SaveChanges();
                return Ok(machine);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Ошибка: {ex.Message}");
            }
        }

        [HttpDelete("{model}")]
        public IActionResult DeleteUser(string model)
        {
            var machine = _context.ВендинговыйАппаратs.FirstOrDefault(m => m.Модель == model);
            if (machine is null)
            {
                return NotFound();
            }
            _context.ВендинговыйАппаратs.Remove(machine);
            _context.SaveChanges();
            return Ok(machine);
        }
    }
}
