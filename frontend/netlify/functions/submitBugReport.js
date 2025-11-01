function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "POST,OPTIONS"
  };
}

export async function handler(event) {
  const baseHeaders = corsHeaders(event);
  
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 204, headers: baseHeaders };
  }

  if (event.httpMethod !== "POST") {
    return {
      statusCode: 405,
      headers: baseHeaders,
      body: "Method Not Allowed"
    };
  }

  try {
    // Parse JSON body
    const { title, description, email } = JSON.parse(event.body || "{}");
    
    // Validate required fields
    if (!title || !description || !email) {
      throw new Error("Missing required fields: title, description, or email");
    }
    
    // Log the bug report (in production, you would send an email)
    console.log("=== BUG REPORT SUBMISSION ===");
    console.log("Title:", title);
    console.log("Description:", description);
    console.log("Email:", email);
    console.log("Timestamp:", new Date().toISOString());
    console.log("=============================");
    
    // TODO: Send email to albumguessr@gmail.com using:
    // - Netlify's built-in form handling with email notifications (configure in Netlify UI)
    // - SendGrid integration
    // - AWS SES
    // - Mailgun
    // - Or any other email service
    
    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ success: true, message: "Bug report submitted successfully" })
    };
    
  } catch (error) {
    console.error("Error processing bug report:", error);
    return {
      statusCode: 500,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ success: false, error: error.message })
    };
  }
}

