Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162636;
	b=v4GsUOzUuYJlC7ohEnAUUh7+il8F/6GUyde/pBPHtNK3cN4NiwX5mGqdVoz2M7xSA3Uo
	 G9BNe90hzGVty1U0IyjrkIl/ey3G2IZN9PtUooKRHKgkA+pya5qQiGEeZWy62VuhM+U8z
	 eTl/of0HPUYDqGvlWGJr0/HnyfVmQIXfyVLeQ2SAIWSFh4MDaHS6hLuqfzVLQo6DosRc3
	 MVAY4y+zFAwm94JEjcVOPqRoLHz9IDH0j78NbDoEw+Iyev3xFY9io3HSX3PsfkMh7CJoz
	 BRqMknX33kJ98DRKPvWdIWnGKthbKQ95XSnv9mDGMdA8kK2nu4jywaxVmgMQJL5tiQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=I9NquCUCJSJuGXe0n1gktrr9r7y4Jk/ICWggLQ59hqA=;
	b=DJNjwrxmt6tUl6ichipr0uyqJcdyCjSdg2mPI2YTDVe13T5q8Gptl9Nh/u46otdjrpJt
	 6LBvNGv7GUMB4U5RkTjmnTCW5HHCYvBEmPNUqSu4YcmYwtJP7B2cBBSKTsmzWaY501OpI
	 FtTRY3ieyta2RqbAwDLHfWMrKcNR3n0vjxPvWJ1SXUs8/5B8UHJaE+Iqvop92Xn0g8Hau
	 eqVLyV0gHmm0nM7ftofDiyQlQF3KfHNjf2M2mR0FrZY1axXfYze+s4yjfI/MZHmWF0ROJ
	 +vpNf0Bcmsf2hwcMnTbN0NoCeMh7fe/X8dlLugS9OxQps33tJk3Kviwr971HT4L8HGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C1qDqvhR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11160A2625
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B11160A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C1qDqvhR
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d05d51553so3513095e9.2
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:17:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795162633; cv=none;
        d=google.com; s=arc-20260327;
        b=VjimO/3l7Y9R5QddbHnbwgzVcBQZmJ0hBMnYTO3owdXf/DXT3THS8SG45jKdEZEOYq
         /C9VKpccjrbUDhCyUU9dmyD03hYkPruFjQXTfCXla5Ql1NRmM5vhl7KQaphth0J6kI1m
         rTKi5JH5bzUBYzkNQpav2nVzCECDx45jPwXe9zQLXHTjJkkRvIv8IzkQ3DcmczPC7GTa
         ARhZ8IuLIKPXDn+Co52qz2hwKbzXr9WzIco9AcqvnwExUakycFumfyjBeDGVlwK23+8g
         unYjQKZlP7iRNOW7Xq1iGrrGFm21eVAxz8WEEzaMMk1R0JmrnmRedz26VdG8aA0mmGK7
         e7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9NquCUCJSJuGXe0n1gktrr9r7y4Jk/ICWggLQ59hqA=;
        fh=kwytUuTN+0/gIZ5SfK2s963qoFWsfbSJtv5cEPYijiY=;
        b=lFrcVlH8UbQ/RNA8sza+Tk6Ha3CO2GYqepu6YkX1w01ir6ggQllMR+f+PxhH9XsJ9z
         UC9n7l9zsKc+jnPZ059Mo3ieNoJZgZvVCIWS/oblhqPlMcGLAB8MY6xuEqOa2izDQFIv
         yEK0V88O9l0v0fltiayUbhSolYx0euyt5Z6tc9aSq7SzvxP7b8NHZIT3OnW1mF+36oyt
         LiocUQVx4hGGQNdYvj+onSqFnsAySSNn2YKlDW/BVZG3Ymfl4ZJrYXtdk/iduFWTFG6T
         PZ55OmQanElX8JwXK1QvcZQlASuNjkYysKFw3u/fSo80YLRycyXCasc9ATu56wiW/I8M
         KspA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162633; x=1795767433; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9NquCUCJSJuGXe0n1gktrr9r7y4Jk/ICWggLQ59hqA=;
        b=C1qDqvhRwgouBgCZW6cDraVbgqCW++Zk+rrDWfy2/GbsZV/H8wBS8zV+Adafzslgll
         VMzvEdMzgsoWNQFfE1PlbjhE7l2LakO+ep0GMPRsY36YV8SQHMDXE1h2xgQytZ7dBqKZ
         TTreahweg+bXcXsHh+QkcfrQOmT8/7EkVgO5gm5KMn06gaxMy5SegVUHdoS59f7xNVXv
         /Gkrmp9WHxreGYQkGCY/Zbbu2/1npOGu7q42zFe6OW8L0jLVDbUIvVSpgB/LAkPnwIfI
         iVi6fmmk+Br0cQSy6X6/mXJxOB61+QBjWcQr59F4bDNfQiPo2YrvRweet+chQGR8FJJH
         62fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162633; x=1795767433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9NquCUCJSJuGXe0n1gktrr9r7y4Jk/ICWggLQ59hqA=;
        b=KjXspuS+wgxsgUnha+kArJHbhTf9wcbw2//qc1HuBELDwNQHTFMbGUhAgq9pIk7Xda
         tgWfARjx2k4B3D6BWERhHohXfD72byPxzMvONTq75dVuYGWwnmmBdThe+x95KbOI99UW
         geeLDgJaMHePtiYhbIMuamTbx10VlmpGWXTIfDPEk+V7aWT7SWQHqdsfRyg5Uhx/Ice1
         DfM20w2iMDZpqW1eZCmh3+4+lU0D77zMxpvPk8r1dsnZJrWb+2ST3SYLEC2Z+dmyo244
         ++cQZ1VjyzsYEij9/JGH1v3QqbTsdsmvqsMsmEmS6vecgNzX+UIYswTQITHXt/P4GCPR
         3DfA==
X-Forwarded-Encrypted: i=1; AL+hErGU/oBCgJf6w3uAiALRL/kM0kqbUVPuhsn254Lhm7diHn0EiM0qEuRSy7FLr/wm2+aTIt8Daw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+zXw4oNAGZzPaRqLPjB7hDkfxcyHnII9IMtu0QECPZM3r1yfte
	4lL9jdK1YTsN7VylXZEJ6uHdYDNlUL0ZQbBzm+3YextfcHnfA4ErkH/tL1lVxVpfs/fzlGYB8bm
	5lXX5bSmlj882yg1SgnZnPkm4EK4DYBI=
X-Gm-Gg: AYBFou0b5g4OQ4GeNoAoQIcITZE4w+gXGmR8XNu7wSeyXZ4BedSx/cssiDcp8AURixS
	N02gp+RndVU7prDKfJWJKrHdLYbqJ+mPufWcySsJMYdnklHQNwxO7Tz2RR6MvH4e4Hm8id3AGfa
	cElUU6K5XIra2aeDxAhpD0ic+rp/i04pUTBuzJnyAdqqspr4BM4/HKIrKzttP85oq5cTCGC5laj
	7ExjBdfmRiXUw2aFRhy11PT3iXGuPAxjO5QhqsfMc9qxUM5LRzeEZnBJjwx360vu6TDk6003MI+
	wiXgDyCJJk+JGCMKtJTKxsGfi3ADXC/kg/5rAIDneaYQtnngrdhB19DhGrNOiJ4uge40nS/GAKT
	W8C5Qd7nJ4dgrtnoL95PqdjpLXG/YapFZqRXPTxbbfwFkw1LrBtkc/6fJoEytFW2lJA==
X-Received: by 2002:a05:600c:b8a:b0:4bb:7007:4a5a with SMTP id
 5b1f17b1804b1-4bb88817772mr45942875e9.23.1795162632893; Fri, 20 Nov 2026
 00:17:12 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-7-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-7-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:17:00 +0800
X-Gm-Features: AclHuK87_PiI6KLw_fxUiiW6AWziAjedbgzbNSGoCid8qtKuQuZJuSbue31J1p8
Message-ID: <CAN_Opa_mk5xH5LtV04f=ooQuVatjbEviN6jxkayAatzqkie4qg@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] mm/mglru: make folio lru referenced times count
 a generic API
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:03=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Pure code shuffle, no behavior change.
>
> Make the folio LRU refs helpers available regardless of CONFIG_LRU_GEN.
> Without MGLRU the extra bits are never set, so they are inert. Move the
> lru_gen_* helpers into the CONFIG_LRU_GEN section.  This prepares for
> unifying the API for checking folio referenced and workingset status.
>
> folio_migrate_lru_refs() now migrates the complete refs count,
> including PG_workingset (bit 1 of the encoding), bitwise identical to
> the direct copy dropped from folio_migrate_flags().
>
> lru_set_refs_flags() skips the nonexistent mask bits when
> LRU_REFS_WIDTH collapses to 0, preserving the two independent flags for
> !CONFIG_LRU_GEN builds.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 55 ++++++++++++++++++++++++-----------------=
------
>  mm/migrate.c              |  2 --
>  2 files changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index f38dad1198fc..180db43c3a85 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -184,6 +184,12 @@ static inline int lru_get_gen_flags(unsigned long fl=
ags)
>         return gen;
>  }
>
> +static inline int folio_lru_gen(const struct folio *folio)
> +{
> +       return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)))=
;
> +}
> +#endif
> +
>  /**
>   * lru_set_refs_flags - Set the LRU referenced count to folio flags.
>   * @flags: pointer to the folio flags
> @@ -206,7 +212,8 @@ static inline void lru_set_refs_flags(unsigned long *=
flags, unsigned int refs)
>                 *flags |=3D BIT(PG_referenced);
>         if (refs & BIT(1))
>                 *flags |=3D BIT(PG_workingset);
> -       *flags |=3D ((unsigned long)refs >> 2) << LRU_REFS_PGOFF;
> +       if (LRU_REFS_WIDTH)
> +               *flags |=3D ((unsigned long)refs >> 2) << LRU_REFS_PGOFF;
>  }
>
>  /**
> @@ -252,13 +259,31 @@ static inline void folio_set_lru_refs(struct folio =
*folio, unsigned int refs)
>         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flag=
s));
>  }
>
> +#ifdef CONFIG_LRU_GEN
>  void folio_inc_lru_refs(struct folio *folio, unsigned int flags);
> +#else
> +static inline void folio_inc_lru_refs(struct folio *folio, unsigned int =
flags)
> +{
> +       /* Should not be called with !CONFIG_LRU_GEN */
> +       WARN_ON_ONCE(1);
> +}
> +#endif
>
> -static inline int folio_lru_gen(const struct folio *folio)
> +/**
> + * folio_migrate_lru_refs - copy the reference state to a new folio
> + * @new: the destination folio
> + * @old: the source folio
> + *
> + * Transfer the reference state to @new during migration: the MGLRU
> + * refs count, or PG_referenced and PG_workingset (bits 0-1 of the
> + * encoding) for the active/inactive LRU.
> + */
> +static inline void folio_migrate_lru_refs(struct folio *new, const struc=
t folio *old)
>  {
> -       return lru_get_gen_flags(READ_ONCE(*const_folio_flags(folio, 0)))=
;
> +       folio_set_lru_refs(new, folio_lru_refs(old));
>  }
>
> +#ifdef CONFIG_LRU_GEN
>  static inline bool lru_gen_is_old(struct lruvec *lruvec, int type, int g=
en)
>  {
>         unsigned long min_seq =3D READ_ONCE(lruvec->lrugen.min_seq[type])=
;
> @@ -424,20 +449,6 @@ static inline bool lru_gen_del_folio(struct lruvec *=
lruvec, struct folio *folio,
>
>         return true;
>  }
> -
> -/**
> - * folio_migrate_lru_refs - copy the reference state to a new folio
> - * @new: the destination folio
> - * @old: the source folio
> - *
> - * Transfer the reference state to @new during migration: the MGLRU
> - * refs count, including PG_referenced, or just PG_referenced for the
> - * active/inactive LRU.
> - */
> -static inline void folio_migrate_lru_refs(struct folio *new, const struc=
t folio *old)
> -{
> -       folio_set_lru_refs(new, folio_lru_refs(old));
> -}
>  #else /* !CONFIG_LRU_GEN */
>
>  static inline bool lru_gen_enabled(void)
> @@ -470,16 +481,6 @@ static inline bool lru_gen_del_folio(struct lruvec *=
lruvec, struct folio *folio,
>  {
>         return false;
>  }
> -
> -static inline void folio_inc_lru_refs(struct folio *folio, unsigned int =
flags)
> -{
> -}
> -
> -static inline void folio_migrate_lru_refs(struct folio *new, const struc=
t folio *old)
> -{
> -       if (folio_test_referenced(old))
> -               folio_set_referenced(new);
> -}
>  #endif /* CONFIG_LRU_GEN */
>
>  static __always_inline
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 28a8d7734735..c8c49357df87 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -796,8 +796,6 @@ void folio_migrate_flags(struct folio *newfolio, stru=
ct folio *folio)
>                 folio_set_active(newfolio);
>         } else if (folio_test_clear_unevictable(folio))
>                 folio_set_unevictable(newfolio);
> -       if (folio_test_workingset(folio))
> -               folio_set_workingset(newfolio);
>         if (folio_test_checked(folio))
>                 folio_set_checked(newfolio);
>         /*
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
