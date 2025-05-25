import React, { useState } from 'react';
import { Search, Mail, Edit, Trash, Shield, ShieldOff } from 'lucide-react';
import { Input } from '../../components/ui/Input';
import { Button } from '../../components/ui/Button';
import { Card, CardContent } from '../../components/ui/Card';

const users = [
  {
    id: '1',
    email: 'john@example.com',
    full_name: 'John Doe',
    role: 'user',
    created_at: '2025-01-01T00:00:00Z',
  },
  {
    id: '2',
    email: 'jane@example.com',
    full_name: 'Jane Smith',
    role: 'admin',
    created_at: '2025-01-02T00:00:00Z',
  },
  // Add more sample users as needed
];

const ManageUsersPage: React.FC = () => {
  const [searchTerm, setSearchTerm] = useState('');
  
  const filteredUsers = users.filter(user =>
    user.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
    user.full_name.toLowerCase().includes(searchTerm.toLowerCase())
  );
  
  const handleDelete = (userId: string) => {
    if (!window.confirm('Are you sure you want to delete this user?')) return;
    console.log('Deleting user:', userId);
  };
  
  const toggleRole = (userId: string, currentRole: string) => {
    const newRole = currentRole === 'admin' ? 'user' : 'admin';
    console.log('Updating user role:', userId, newRole);
  };
  
  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
          Manage Users
        </h2>
        
        <div className="w-64">
          <Input
            placeholder="Search users..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            icon={<Search className="h-5 w-5 text-gray-400" />}
          />
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredUsers.map((user) => (
          <Card key={user.id}>
            <CardContent className="p-6">
              <div className="flex items-start justify-between mb-4">
                <div className="flex-1">
                  <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
                    {user.full_name}
                  </h3>
                  <div className="flex items-center text-gray-600 dark:text-gray-400">
                    <Mail className="h-4 w-4 mr-1" />
                    <span className="text-sm">{user.email}</span>
                  </div>
                </div>
                <span className={`px-2 py-1 text-xs rounded-full font-medium ${
                  user.role === 'admin'
                    ? 'bg-purple-100 text-purple-800 dark:bg-purple-900/30 dark:text-purple-400'
                    : 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400'
                }`}>
                  {user.role.charAt(0).toUpperCase() + user.role.slice(1)}
                </span>
              </div>
              
              <div className="text-sm text-gray-600 dark:text-gray-400 mb-4">
                Member since {new Date(user.created_at).toLocaleDateString()}
              </div>
              
              <div className="flex gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => console.log('Edit user:', user.id)}
                  icon={<Edit className="h-4 w-4" />}
                >
                  Edit
                </Button>
                
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => toggleRole(user.id, user.role)}
                  icon={user.role === 'admin' ? (
                    <ShieldOff className="h-4 w-4" />
                  ) : (
                    <Shield className="h-4 w-4" />
                  )}
                >
                  {user.role === 'admin' ? 'Remove Admin' : 'Make Admin'}
                </Button>
                
                <Button
                  variant="danger"
                  size="sm"
                  onClick={() => handleDelete(user.id)}
                  icon={<Trash className="h-4 w-4" />}
                >
                  Delete
                </Button>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
};

export default ManageUsersPage;