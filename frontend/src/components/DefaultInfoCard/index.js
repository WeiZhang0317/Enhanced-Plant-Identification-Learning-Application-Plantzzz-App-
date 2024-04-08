import React from "react";
import PropTypes from "prop-types";

// @mui material components
import Card from "@mui/material/Card";
import Divider from "@mui/material/Divider";
import Icon from "@mui/material/Icon";

// Material Dashboard 2 React components
import MDBox from '../MDBox'; // 假设MDBox在components文件夹下的MDBox文件夹内


function DefaultInfoCard({ color, icon, title, description, value }) {
  return (
    <Card>
      <MDBox p={2} mx={3} display="flex" justifyContent="center">
        <MDBox
          display="grid"
          justifyContent="center"
          alignItems="center"
          bgColor={color}
          color="white"
          width="4rem"
          height="4rem"
          shadow="md"
          borderRadius="lg"
          variant="gradient"
        >
          <Icon fontSize="default">{icon}</Icon>
        </MDBox>
      </MDBox>
      <MDBox pb={2} px={2} textAlign="center" lineHeight={1.25}>
        <div style={{ fontWeight: 'medium', textTransform: 'capitalize', fontSize: '1rem' }}>
          {title}
        </div>
        {description && (
          <div style={{ fontSize: '0.875rem', color: '#9e9e9e' }}>
            {description}
          </div>
        )}
        {description && !value ? null : <Divider />}
        {value && (
          <div style={{ fontWeight: 'medium', fontSize: '1.25rem' }}>
            {value}
          </div>
        )}
      </MDBox>
    </Card>
  );
}

DefaultInfoCard.defaultProps = {
  color: "info",
  value: "",
  description: "",
};

DefaultInfoCard.propTypes = {
  color: PropTypes.oneOf(["primary", "secondary", "info", "success", "warning", "error", "dark"]),
  icon: PropTypes.node.isRequired,
  title: PropTypes.string.isRequired,
  description: PropTypes.string,
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
};

export default DefaultInfoCard;
