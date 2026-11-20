Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157597;
	b=1XItieAJEOfX/ut5CCoBBzP8thrCJfYZ+mgz/ZF0KRFY07yisNVr4yxxNCHkCkQ6riKp
	 5ON1vboN/PVSPeScCGl6hlmUl1uC6BjdTi6fxXLmi8RA/wkGEM4S6w/bIrBnr98SdfD8Q
	 Yh6C68ODFDZ7uFcj7yBI0iC2SjDW+9Q2N/jGzz95k9oKrf2QdMAVlYpZ5l6OYIqTOA6A0
	 JA/WwvLXCVvUQlR7QecA7bGYum7K35JvtXxfF9gI0K/IG1/BI1rQMwqLxVaRaIermXc9m
	 3UdA5cQn3tUSNQuXYznXgq+jaqiLzRr0k2jE3k42n+3uuCAn+NOXMzJB6j3hdk90GZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/fJM3JyrbV2mEEaUD0SZw8LIvK7Rur9l2Ozl8m23grs=;
	b=VJ9PqpVV/gGu6hzRPwLM/98lPvC29pZT5tI6ZWS33wpN9V6awE1N3EOvY3hGiKooGFHK
	 zd1LrvJepRBGFQP273z4MvHTXFPlPD7GHZd7vHNPiiXQUuXfzM0a9bEBs0c9+ALiZi+St
	 ASC0oGHKywbiVqaD8jlEh4ujwVhhyK3RmHRcpFzq4YGYpvWdmafOPVXtgjKBKGee6qI0/
	 Qabf8U+NbqjE9FgbsmftQ/LLCrFLl2g8mlslgpgLptl2I5t354V7WisvpQAXWN+mo4xNB
	 HFrIhzjZgkYgVQIVNBIulqsRV3IjSdNDFBlNVRzXuPd9IEvHPdXOAox7aIVGayVaHiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YhbHhnW7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689C606A326
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A689C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YhbHhnW7
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso3687885e9.0
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 22:53:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795157595; cv=none;
        d=google.com; s=arc-20260327;
        b=Y9q0G17pHUziz1F6Tp1/IiA3PrKEK9Hunaysn9FzNpHZoYja6aFQjXT5XSewyPMEc6
         goNpLPIJUHZY7CGKaNPUE/nkNa0Bjc+y0/yPwKStBAh7jeMUOtbw2jcTtaYqun5NIAMS
         LzEvxQO/AzzaaZl/PSki51qGWhQj2H43w/hkJUPz4cqpLhCOiSauzimbmeJkZen9Q6XZ
         lKE8UKaX8J4h5cq+l0m4z60isW6l8fQRy85fjQeUVxsf2tKtjCMZqp/VjN8O7US5hf+1
         uGko7NaUi6kdx8zfAKFGutcry9TurAfFP4aIbHYVMi+5dneaKcOz3m0B6Dw4nRvD9Usq
         XE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/fJM3JyrbV2mEEaUD0SZw8LIvK7Rur9l2Ozl8m23grs=;
        fh=bDtlq2ImB14Cba+BpVJEbs+v+77ACaM1ia8scJ46iNU=;
        b=DimkVIts+9IaCu2eycByT1Vaooqw9Ug8+UfFlfnXY9UVzEAzE4WweekjjOiop78NJc
         oHzCcqPnS/pqgGG+fqmOsD/5yLbXXewoRvs0zcl2NG/gdYLwXCSB5SkgzrhUKhC8MQvc
         /T7p6hILdOAckmxgK1DFtVh+TWXE+gYfFCHApC456Hl6aFcU+dTgne/9QbcHoSTL82zj
         sqOenHuASqaHMOjfQvlnlM4W65vrkpAVugdi/lH9sxOT/X4MWR8M6e1GFvGqE6FZCPp1
         0sClGGRNKIp9EqT0W09NT3cFETBq0L5t6TmkLvK1diN8IK/nL60RxNJOW6ub+3zLw/yu
         L+VQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157595; x=1795762395; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/fJM3JyrbV2mEEaUD0SZw8LIvK7Rur9l2Ozl8m23grs=;
        b=YhbHhnW7kWIL1quyzJbST1D6vRTP7fL/1Lw2YJ7JYkn7uAb9qG/JsAgY5JfPKhkyh7
         i4a3KzUT2vZIKzL9LfJ6i2XHSaEYn4DYlgAJl49cJWXKEIzDkchLfAj91tJ+RpLC2LMP
         TEKDYWAjq9s7FSm6Y5okCQViR4wlg+DxWgcWmgHpP3HLdulrtXL7mW4eqpFE2eqYzoM/
         EyDSkB0XMd1e5V74xUArWggwasY+2DQtiXpEVqQ5+AsJcz0x+8+lydNlrqyEEcjLgK2Y
         4awiqU7kK18l27rMKVZ57oyz24PMo4uUH6/sHyV6NB1crNmOeYOSYXebw+sJrgKgG2Ny
         fgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157595; x=1795762395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/fJM3JyrbV2mEEaUD0SZw8LIvK7Rur9l2Ozl8m23grs=;
        b=Azp8RwDa8TQFg/ec8vvMUc0kb3YBGmHEBZrCAQcwTO2g5zZSCZQorTSCA7TZrke6o1
         UjXxVsSo1Vipwbrvpgbshdgx8/bePhsUjpdUSjmVOw26Td6Wp/+Ma7DfXawK1Qq14C2J
         CLGxrXJHMbhs5GzpNhnUPDRjIe49IDzJHkgHwRPf5VdHHrBh8oI9TehwTUna3Bb9wH3/
         8cOnw7x+aZ9Vdj0paH689BJKc46Vvbh1fMHh2QfcJQqUlhiXzVob1bxQACmSAMYWy2uF
         ajhfHiNL/kyoJ2YB2DUxyCcBcMN5qEj904g0pBpKFxgpKqtHT9m/4RJEqskqgJACw+1J
         k+JQ==
X-Forwarded-Encrypted: i=1; AL+hErHpL7vKGqtlmvsUiOcP0J9cd+4L5ihJQ6jcISO9wQx84aOQdeAQwD5AZt++wD+yMeUG38VjVw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9a5KUd2qQbX0XvrX0Un73fLDA8eDtKvp0k/JcmY+Bydptq7RpG
	oT1sbhErCf3sUQ2NqATg7ysTasF6g8WMi0KczvQHIiAMbD/Z4e9ZPNhYJeGbeuBm+TrABkeLFFN
	lBmjRowtC+fGgkZT/cQdWLXtc5znnH7s=
X-Gm-Gg: AYBFou3z6RlB3zkTVgPKfysOapwu2NK7M0KAccC62b1EW9zVY4j/CZFKj87MXyHQIv3
	wKtURMGc6CqwZbKqiiRwX4SxS1xu75Kzo+1fnwsG9M7YI/giCT1UWDlCImV0+a0wJ5QJySb+Ko0
	l9Cc0GxjEV6ofAkFs1HqrUZK9VkM4CmigQxayGp2M6RApFwSxRyWAm4sPqH6GTX3ptc9RnrYpX4
	xUhzKmvQBhRlw4h9fz8g+scTF/EIb6OmzhqyPd9LMiE1QT6WJ3OfTDoZL7aPEtsEYn/Kr8fft9X
	Tkt3KX7KiwURdfejxLjmScaDCykjRey5AdRED3jZgjP186/9w0+a50CR0GqFW9OMjsYxqnv5Afa
	glXGKKm2AlIp2ZGs+FuOSGEo3bjD8NOvSGkmjwA+UhrYGSboEZQoyWC5eIlrIBttnbw==
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb8881941bmr45328225e9.24.1795157594548; Thu, 19 Nov 2026
 22:53:14 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-5-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-5-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 14:53:02 +0800
X-Gm-Features: AclHuK-UAZOlULyacCKbVJRgcNRnp6P5R-TwcyKCwuErXy_grzV4Q1tvMgKauLc
Message-ID: <CAN_Opa8b0Uh9WQ85HkZJPm6UuqW+eSqtdP_UWW76naupt3HNmg@mail.gmail.com>
Subject: Re: [PATCH v5 05/17] mm/mglru: skip the flags cmpxchg when nothing changes
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
> From: Ridong Chen <chenridong@xiaomi.com>
>
> folio_update_gen() and folio_set_lru_refs() always end with a
> try_cmpxchg() on folio->flags, even when the new value equals the old
> one. The locked instruction still takes the struct page cacheline in
> exclusive state.
>
> That is common in practice: a folio mapped by many processes is visited
> once per mm during a page table walk, and after the first visit it is
> already in the youngest generation with refs cleared and PG_workingset
> set. isolate_folio() and the eviction paths also call
> folio_set_lru_refs(folio, 0) on folios whose refs are already zero.
>
> Break out of the loop when the flags would not change. The update is
> complete at the point of that read: the flags already hold the target
> value, and a concurrent change to them is ordered after it. When the
> cmpxchg would have succeeded, the value written is the same, so no new
> state becomes reachable.
>
> What the patch drops is the retry. A retry re-reads the flags and
> recomputes new_flags from the newer value, so it overwrites a concurrent
> update with what this CPU wanted. For folio_update_gen(), a walker that
> read an older max_seq can lose the cmpxchg against a promotion done by
> another CPU, and then write its older generation back on the retry.
> folio_set_lru_refs() can likewise clear a refs increment that raced with
> it. Breaking out keeps the newer state.
>
> No caller relies on the full barrier that the locked instruction
> implied on the skipped path: the eviction and isolation callers run
> under the LRU lock, and the others (page table walks,
> folio_mark_accessed(), lru_gen_clear_refs()) only care about the
> resulting flags value, which is already in place. Note that
> lru_gen_inc_refs() already returns without any atomic when refs is at
> LRU_REFS_MAX and the folio is in the workingset.
>
> Tested on an i7-13700HX with turbo disabled and the performance
> governor. N processes map the same 2GiB tmpfs file (huge=3Dnever) and
> read every page, then one aging pass is triggered on their memcg
> through /sys/kernel/debug/lru_gen ("+ <memcg_id> 0 <max_seq> 200 1").
> Time per aging pass in ms, median of 5 runs of 10 passes each, averaged
> over 2 boots of each kernel:
>
>   processes    base   patched
>           1    32.9      31.7   -3.5%
>           8   195.1     160.2  -17.9%
>          32   755.8     592.2  -21.7%
>          64  1597.2    1260.6  -21.1%
>
> With one process, every visit changes the generation, so there is
> nothing to skip. Before the patch, perf annotate attributes 53-58% of
> the walk_update_folio() samples to the lock cmpxchg in the inlined
> folio_update_gen() in this test.
>
> [kasong: folio_update_gen() is replaced by folio_inc_lru_refs_walk()
> later in the series, which keeps the same early exit.]
> Reviewed-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 2 ++
>  mm/vmscan.c               | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 46beded51c7d..2571b3f01226 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -233,6 +233,8 @@ static inline void folio_set_lru_refs(struct folio *f=
olio, unsigned int refs)
>         do {
>                 new_flags =3D old_flags;
>                 lru_set_refs_flags(&new_flags, refs);
> +               if (new_flags =3D=3D old_flags)
> +                       break;
>         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flag=
s));
>  }
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8d14831cdf83..0f24b6ebc1eb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3274,6 +3274,8 @@ static int folio_update_gen(struct folio *folio, in=
t new_gen, int *type,
>                 lru_set_gen_flags(&new_flags, new_gen);
>                 lru_set_refs_flags(&new_flags, 0);
>                 new_flags |=3D BIT(PG_workingset);
> +               if (new_flags =3D=3D old_flags)
> +                       break;
>         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flag=
s));
>
>         *type =3D folio_flags_is_file_lru(&old_flags);
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
