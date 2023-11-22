# 유저 생성,수정,단건 조회, 다건 조회 API


## 기술스택  
    - Elixir
    - Phoenix 프레임워크
    - Ecto
    - PostgreSQL


## 프로젝트 구조 
  
<details><summary>프로젝트 구조
</summary>

설명
</details>

- /lib/phx_toy_web/reouter.ex 👉 라우터
- /lib/phx_toy_web/controllers/user_controller.ex 👉 컨트롤러   
- /lib/phx_toy/users/user_context.ex 👉 user 비지니스 관련 컨텍스트(Service 계층 담당)   
- /lib/phx_toy/users/user.ex 👉 user 도메인(스키마)
- /lib/phx_toy/users/common/res_code.ex 👉 공통 api 반환 상태코드 모듈

## 프로젝트 구동 방법
1. 프로젝트 루트 경로의 docker-compose.yml의 postgresql 이미지를 컨테이너로 실행
2. users 테이블 생성
#### users 테이블 생성 스크립트
```sql

CREATE SEQUENCE IF NOT EXISTS public.users_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1
    OWNED BY users.id;

ALTER SEQUENCE public.users_id_seq
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    account_id character varying(30) COLLATE pg_catalog."default" NOT NULL,
    name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    delete_yn character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::bpchar,
    CONSTRAINT users_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;

COMMENT ON TABLE public.users
    IS '회원 테이블';
```

3. 프로젝트 루트 경로에서 mix phx.server 피닉스 프레임워크 서버 실행(localhsot:4000)


### 유저 생성 API
```
POST localhost:4000/users
{
    "account_id" : "dybala.arg",
    "name" : "권희운"
}
```

### 유저 수정 API
```
PUT localhost:4000/users/{userId}
{
    "name" : "권희운 이름 수정"
}
```

### 유저 삭제 API
```
DELETE localhost:4000/users/{userId}
```

### 유저 전체 조회 API
```
GET localhost:4000/users

```

### 유저 단건 조회 API
```
GET localhost:4000/users/{userId}

```