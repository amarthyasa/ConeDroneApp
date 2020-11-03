import unittest
from sensor import flyover_success
from sensor import convert_sensor_data
from indicator import indicator_led
from indicator import indicator_flag
from messages import parseMessage

class Tests(unittest.TestCase):
    def test_distance_more_than_four(self):
        result = flyover_success(5)
        self.assertTrue(result) 
    def test_distance_more_than_four_float(self):
        result = flyover_success(4.01)
        self.assertTrue(result) 
    def test_distance_less_than_four(self):
        result = flyover_success(3)
        self.assertFalse(result)
    def test_distance_less_than_four_float(self):
        result = flyover_success(3.99)
        self.assertFalse(result)
    def test_distance_equal_to_four(self):
        result = flyover_success(4)
        self.assertFalse(result)
    def test_distance_equal_to_four_float(self):
        result = flyover_success(4.00)
        self.assertFalse(result)

    def test_sensor_data_converter100(self):
        result = convert_sensor_data(100)
        self.assertEqual(result,1)
    def test_sensor_data_converter1(self):
        result = convert_sensor_data(1)
        self.assertEqual(result,0.01)
    def test_sensor_data_converter390(self):
        result = convert_sensor_data(398.428)
        self.assertEqual(result,3.98428)



    def test_led_true_flyover(self):
        result = indicator_led(flyover_success(5))
        self.assertEqual(1,1)
    def test_led_false_flyover(self):
        result = indicator_led(flyover_success(3.998))
        self.assertEqual(0,0)
    def test_flag_true_flyover(self):
        result = indicator_flag(flyover_success(5))
        self.assertEqual(1,1)
    def test_flag_false_flyover(self):
        result = indicator_flag(flyover_success(3.998))
        self.assertEqual(0,0)

#tests for errors


if __name__ == '__main__':
    unittest.main()