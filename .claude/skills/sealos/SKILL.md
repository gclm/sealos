# sealos Development Patterns

> Auto-generated skill from repository analysis

## Overview

This skill teaches development patterns for the Sealos project, a cloud operating system based on Kubernetes. The codebase primarily uses TypeScript with a focus on Kubernetes-native applications, API development, and multi-provider cloud services. The project follows conventional commit patterns and emphasizes standardized error handling, OpenAPI documentation, and comprehensive localization support.

## Coding Conventions

### File Naming
- Use **camelCase** for TypeScript files: `authService.ts`, `tokenTypes.ts`
- Use **kebab-case** for configuration files: `values.yaml`, `deployment.yaml`
- Test files follow pattern: `*.test.ts`

### Import/Export Style
```typescript
// Use alias imports
import { AuthService } from '@/services/backend/auth'
import { TokenType } from '@/types/token'

// Use named exports
export { validateToken, refreshToken }
export type { TokenResponse, AuthConfig }
```

### Commit Messages
- Follow conventional commits: `feat:`, `fix:`, `refactor:`
- Keep messages around 65 characters
- Examples:
  ```
  feat: add v2alpha billing API endpoints
  fix: resolve token validation in auth middleware
  refactor: update helm chart configuration structure
  ```

## Workflows

### V2 Alpha API Development
**Trigger:** When someone wants to add or update V2 alpha API endpoints
**Command:** `/new-v2-api`

1. Create route handler in `app/api/v2alpha/[endpoint]/route.ts`
   ```typescript
   import { NextRequest } from 'next/server'
   import { validateSchema } from './schema'
   
   export async function POST(request: NextRequest) {
     // Implementation with standardized error handling
   }
   ```

2. Add schema validation file `app/api/v2alpha/[endpoint]/schema.ts`
   ```typescript
   import { z } from 'zod'
   
   export const requestSchema = z.object({
     // Define schema
   })
   ```

3. Update error handling types in `types/v2alpha/error.ts`
4. Generate OpenAPI documentation in `app/api/v2alpha/openapi/route.ts`
5. Update `package.json` dependencies if new packages are needed

### Helm Chart Configuration Updates
**Trigger:** When someone wants to modify deployment configuration or add new config parameters
**Command:** `/update-helm-config`

1. Update chart `values.yaml` with new configuration parameters
   ```yaml
   config:
     newParameter: "default-value"
     existingConfig:
       enabled: true
   ```

2. Modify template files (`configmap.yaml`, `deployment.yaml`)
   ```yaml
   # configmap.yaml
   data:
     config.yaml: |
       {{ .Values.config | toYaml | nindent 4 }}
   ```

3. Update entrypoint scripts (`*-entrypoint.sh`) to handle new parameters
4. Test configuration changes in development environment

### Authentication Token Fixes
**Trigger:** When someone needs to fix token authentication or authorization issues
**Command:** `/fix-auth-token`

1. Update auth service files in `services/backend/auth.ts`
   ```typescript
   export class AuthService {
     async validateToken(token: string): Promise<TokenValidation> {
       // Token validation logic
     }
   }
   ```

2. Modify token types in `types/token.ts`
   ```typescript
   export interface TokenPayload {
     userId: string
     permissions: string[]
     expiresAt: number
   }
   ```

3. Update API endpoints handling auth in `pages/api/auth/*.ts`
4. Fix middleware authentication logic in `middleware/*.ts`

### Kubernetes Controller CRD Updates
**Trigger:** When someone wants to modify or extend Kubernetes custom resources
**Command:** `/update-controller-crd`

1. Update API types in `api/v1/*_types.go`
   ```go
   // +kubebuilder:object:root=true
   type MyResource struct {
       metav1.TypeMeta   `json:",inline"`
       metav1.ObjectMeta `json:"metadata,omitempty"`
       
       Spec   MyResourceSpec   `json:"spec,omitempty"`
       Status MyResourceStatus `json:"status,omitempty"`
   }
   ```

2. Regenerate CRD YAML files using `make manifests`
3. Update controller logic in `controllers/*_controller.go`
4. Regenerate deepcopy methods using `make generate`

### Localization Updates
**Trigger:** When someone wants to add new UI text or update translations
**Command:** `/update-translations`

1. Update English locale files in `public/locales/en/common.json`
   ```json
   {
     "newFeature": {
       "title": "New Feature",
       "description": "Feature description"
     }
   }
   ```

2. Update Chinese locale files in `public/locales/zh/common.json`
   ```json
   {
     "newFeature": {
       "title": "新功能",
       "description": "功能描述"
     }
   }
   ```

3. Modify components using translations in `src/components/*.tsx`
   ```typescript
   import { useTranslation } from 'next-i18next'
   
   const { t } = useTranslation('common')
   return <h1>{t('newFeature.title')}</h1>
   ```

### Kubernetes ConfigMap and Deployment Updates
**Trigger:** When someone wants to modify application configuration or deployment settings
**Command:** `/update-k8s-config`

1. Update ConfigMap templates in `templates/configmap.yaml`
2. Modify Deployment templates in `templates/deployment.yaml`
   ```yaml
   spec:
     template:
       spec:
         containers:
         - name: app
           env:
           - name: NEW_CONFIG
             valueFrom:
               configMapKeyRef:
                 name: app-config
                 key: new-parameter
   ```

3. Update `values.yaml` with new configuration options
4. Sync configuration parameters across all related files

## Testing Patterns

Tests use Jest framework with the pattern `*.test.ts`:

```typescript
// auth.test.ts
import { AuthService } from '@/services/backend/auth'

describe('AuthService', () => {
  it('should validate valid tokens', async () => {
    const authService = new AuthService()
    const result = await authService.validateToken('valid-token')
    expect(result.isValid).toBe(true)
  })
})
```

## Commands

| Command | Purpose |
|---------|---------|
| `/new-v2-api` | Create or update V2 alpha API endpoints with schemas and docs |
| `/update-helm-config` | Modify Helm chart templates and configuration |
| `/fix-auth-token` | Fix authentication and token-related issues |
| `/update-controller-crd` | Update Kubernetes controller CRDs and types |
| `/update-translations` | Add or update UI translations |
| `/update-k8s-config` | Update Kubernetes ConfigMaps and Deployments |