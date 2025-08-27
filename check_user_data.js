// Script to check database directly for user data
const { neon } = require('@neondatabase/serverless');

const neonConnectionString = 'postgresql://neondb_owner:npg_JVaULlB0w8mo@ep-soft-rice-adn6s9vn-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require';

async function checkUserData() {
    try {
        console.log('🔍 Checking database for user data...');
        
        const sql = neon(neonConnectionString);
        
        // Check for the specific user ID
        const userId = '8ce9f7b5-34ce-4f6b-87ef-ca0588710a72';
        
        console.log(`🔍 Looking for user: ${userId}`);
        
        // Check what's in the database
        const result = await sql`
            SELECT user_id, week_key, data_content, updated_at 
            FROM marriage_meetings_dev 
            WHERE user_id = ${userId}
            ORDER BY updated_at DESC
        `;
        
        console.log('📊 Database results:');
        console.log('Total rows found:', result.length);
        
        if (result.length > 0) {
            result.forEach((row, index) => {
                console.log(`\n--- Row ${index + 1} ---`);
                console.log('User ID:', row.user_id);
                console.log('Week Key:', row.week_key);
                console.log('Updated At:', row.updated_at);
                
                // Handle data_content properly
                if (row.data_content) {
                    console.log('Data Content Type:', typeof row.data_content);
                    console.log('Data Content Length:', row.data_content.length || 'N/A');
                    
                    try {
                        let parsed;
                        if (typeof row.data_content === 'string') {
                            parsed = JSON.parse(row.data_content);
                        } else {
                            parsed = row.data_content;
                        }
                        
                        console.log('Goals count:', parsed.goals ? parsed.goals.length : 'No goals');
                        console.log('Todos count:', parsed.todos ? parsed.todos.length : 'No todos');
                        console.log('Schedule items:', parsed.schedule ? Object.keys(parsed.schedule).length : 'No schedule');
                        console.log('Family Vision exists:', !!parsed.familyVision);
                        
                        if (parsed.goals && parsed.goals.length > 0) {
                            console.log('Sample goals:', parsed.goals.slice(0, 3).map(g => g.text || 'Unknown'));
                        }
                        
                        if (parsed.familyVision) {
                            console.log('Family Vision preview:', parsed.familyVision.substring(0, 100) + '...');
                        }
                        
                    } catch (e) {
                        console.log('❌ Could not parse data_content:', e.message);
                        console.log('Raw data_content:', row.data_content);
                    }
                } else {
                    console.log('❌ No data_content found');
                }
            });
        } else {
            console.log('❌ No data found for this user!');
        }
        
    } catch (error) {
        console.error('❌ Error checking database:', error);
    }
}

checkUserData();
