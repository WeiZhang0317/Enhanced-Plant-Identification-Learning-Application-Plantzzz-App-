// src/theme.js

import { createTheme } from '@mui/material/styles';

const theme = createTheme({
  borders: {
    borderRadius: '4px', // 示例值，您可以根据实际需要进行调整
    radius: {
      xs: '2px',
      sm: '4px',
      md: '8px',
      lg: '12px',
      xl: '16px',
    },
  },
  gradients: {
    primary: {
      main: '#FFD54F', // 渐变起始颜色
      state: '#FFC107', // 渐变结束颜色
    },
    secondary: {
      main: '#F48FB1',
      state: '#EC407A',
    },
    // 添加更多渐变配置
  },
  boxShadows: {
    default: "0px 2px 1px -1px rgba(0,0,0,0.2), 0px 1px 1px 0px rgba(0,0,0,0.14), 0px 1px 3px 0px rgba(0,0,0,0.12)",
    colored: {
      primary: "0 4px 20px 0 rgba(255, 0, 0, .14), 0 7px 10px -5px rgba(255, 0, 0, .4)",
      // 根据需要添加更多颜色的阴影
    },
  },
  palette: {
    info: {
      main: '#2196f3', // 信息色，您可以根据实际需要进行调整
    },
    // 这里可以根据需要添加更多颜色
    // 例如 primary, secondary, error, warning, success 等
    primary: {
      main: '#556cd6',
    },
    secondary: {
      main: '#19857b',
    },
    error: {
      main: '#ff1744',
    },
    warning: {
      main: '#ff9800',
    },
    success: {
      main: '#4caf50',
    },
    grey: {
      100: '#f5f5f5',
      200: '#eeeeee',
      300: '#e0e0e0',
      400: '#bdbdbd',
      500: '#9e9e9e',
      600: '#757575',
      700: '#616161',
      800: '#424242',
      900: '#212121',
    },
  },
  // 添加其他可能需要的主题配置
});

export default theme;
