const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL
});

async function checkThursdayData() {
  try {
    console.log('🔍 Checking Thursday data for current week...\n');
    
    const result = await pool.query(
      'SELECT data_content FROM marriage_meetings_dev WHERE user_id = $1 AND week_key = $2',
      ['8ce9f7b5-34ce-4f6b-87ef-ca0588710a72', '2025-09-01']
    );
    
    if (result.rows.length > 0) {
      const data = result.rows[0].data_content;
      console.log('📅 Current week schedule data:');
      console.log(JSON.stringify(data.schedule, null, 2));
      
      console.log('\n🔍 Thursday specifically:');
      console.log('Thursday array:', JSON.stringify(data.schedule?.Thursday, null, 2));
      console.log('Thursday length:', data.schedule?.Thursday?.length || 0);
      
      if (data.schedule?.Thursday) {
        data.schedule.Thursday.forEach((item, index) => {
          console.log(`  [${index}]: "${item}" (length: ${item?.length || 0})`);
        });
      }
    } else {
      console.log('❌ No data found for this week');
    }
  } catch (error) {
    console.error('❌ Error:', error.message);
  } finally {
    await pool.end();
  }
}

checkThursdayData();
