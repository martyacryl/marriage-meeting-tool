// Script to fix corrupted data by copying good data from week 2025-08-26 to 2025-08-25
const { neon } = require('@neondatabase/serverless');

const neonConnectionString = 'postgresql://neondb_owner:npg_JVaULlB0w8mo@ep-soft-rice-adn6s9vn-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require';

async function fixCorruptedData() {
    try {
        console.log('🔧 Fixing corrupted data...');
        
        const sql = neon(neonConnectionString);
        
        const userId = '8ce9f7b5-34ce-4f6b-87ef-ca0588710a72';
        const goodWeek = '2025-08-26';
        const corruptedWeek = '2025-08-25';
        
        console.log(`🔍 Getting good data from week: ${goodWeek}`);
        
        // Get the good data
        const goodDataResult = await sql`
            SELECT data_content 
            FROM marriage_meetings_dev 
            WHERE user_id = ${userId} AND week_key = ${goodWeek}
            LIMIT 1
        `;
        
        if (goodDataResult.length === 0) {
            console.log('❌ No good data found to copy from');
            return;
        }
        
        const goodData = goodDataResult[0].data_content;
        console.log('✅ Good data found, cleaning it up...');
        
        // Clean the data by removing any null values
        if (goodData.goals) {
            goodData.goals = goodData.goals.filter(goal => goal !== null);
        }
        if (goodData.todos) {
            goodData.todos = goodData.todos.filter(todo => todo !== null);
        }
        if (goodData.grocery) {
            goodData.grocery = goodData.grocery.filter(item => item !== null);
        }
        if (goodData.prayers) {
            goodData.prayers = goodData.prayers.filter(prayer => prayer !== null);
        }
        if (goodData.unconfessedSin) {
            goodData.unconfessedSin = goodData.unconfessedSin.filter(item => item !== null);
        }
        if (goodData.weeklyWinddown) {
            goodData.weeklyWinddown = goodData.weeklyWinddown.filter(item => item !== null);
        }
        
        console.log('🧹 Cleaned data:', {
            goals: goodData.goals ? goodData.goals.length : 0,
            todos: goodData.todos ? goodData.todos.length : 0,
            grocery: goodData.grocery ? goodData.grocery.length : 0,
            prayers: goodData.prayers ? goodData.prayers.length : 0,
            unconfessedSin: goodData.unconfessedSin ? goodData.unconfessedSin.length : 0,
            weeklyWinddown: goodData.weeklyWinddown ? goodData.weeklyWinddown.length : 0
        });
        
        // Update the corrupted week with clean data
        console.log(`🔧 Updating corrupted week: ${corruptedWeek}`);
        
        const updateResult = await sql`
            UPDATE marriage_meetings_dev 
            SET data_content = ${goodData}, updated_at = NOW()
            WHERE user_id = ${userId} AND week_key = ${corruptedWeek}
        `;
        
        console.log('✅ Update result:', updateResult);
        
        // Verify the update
        const verifyResult = await sql`
            SELECT data_content 
            FROM marriage_meetings_dev 
            WHERE user_id = ${userId} AND week_key = ${corruptedWeek}
            LIMIT 1
        `;
        
        if (verifyResult.length > 0) {
            const updatedData = verifyResult[0].data_content;
            console.log('✅ Verification - Updated data now has:', {
                goals: updatedData.goals ? updatedData.goals.length : 0,
                todos: updatedData.todos ? updatedData.todos.length : 0,
                familyVision: !!updatedData.familyVision
            });
        }
        
        console.log('🎉 Data corruption fixed successfully!');
        
    } catch (error) {
        console.error('❌ Error fixing corrupted data:', error);
    }
}

fixCorruptedData();
