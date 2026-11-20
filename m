Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157380;
	b=bXcmY0Le/uLrRsnCwrr4RhvalGCvXihJSfnBHY1I9WAJku1uXp7QlHvlQ04GUo2ALPb7
	 aNSFWsy0F5RCClYGOcH/hbZTY6Pt+LkDnYBq2naGC+QjUCEv4mfDuzPLmWY/4VkQHNcKZ
	 G3jtOexhxGDxcf56KiSjw2x8LnS/wg6xkAxkOgrQcBpP8TYHOUPb6bq1hn+uh+PlRjqbW
	 Fvft1/jnmiAvpHtUSeAad7yaReMZB0dvgzg9I8L6tseoYisdbYcZEfV+wpQCLi/tvSU0x
	 Aj3h3lIkB2UitHWjSiYAI+zz8lxYQ8xa+GiXUwo4OfNBNeS7Cb/g8+0ZFSj1g61X/9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=82jQgJ5EVrQ2a7459gmbGwx0yatt6MbCteDy+T0Kbcc=;
	b=ui3DysaQgdObfNqTfgbcS6dqbT9v+w9rRPrP4kRETVmnkPfAxU3tNdJlb66LUVKpjTVW
	 I3CHwGj8oOeP00U4IMxHMEOYF0ispBTiUhtOFgDE1Bv4bdoL9nlvrIV1cLIrugcWe9rnk
	 BchZIHqcrRGSuarriH5+DrToh2AamQZI/fbV66Wluzi6GJFDm138eC6l71LVMF63LA99V
	 BPG2cU3NnYfI+OFVjZIplBe37PT0obW0Rj64GIN98Qb46aoARB98e5lxhOxGC446u6ZBl
	 FP2wX0xpQH0f7sAF6Hc8S1W4+/tPldBMUZYOGKEKLSkWebYgVNobWY9hdBTSVzQ7dqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Igxudcgo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561C606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5561C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Igxudcgo
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb606491faso2357245e9.3
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 22:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795157378; cv=none;
        d=google.com; s=arc-20260327;
        b=WkQVETJSTRKQt8+EQjFG5Hf/e77oGtSUs+363jb3aczC3+LvwtIm8jz3h9RnQKCIq3
         4pTk0ZiSNYIsNYRVTzLDmtz2+MtogW9rVC1iue3hXu3PI1Vc4c1Oq7aFflST3+Ppsn/B
         qtLI0VUhh+hu7IngpJKGCJcWsW3amwT9+Ji13J0ZpKQdypv2dF1oDfPjVmR9D2FSF/vP
         2wCAcQfa61MLGERRudzmHnbnwpzTAIoRFGxlOsZkfK1fTIm5WTXh+G8Qbh5u/3lwlSj8
         yx9CLZjh8+NPj9/SkxpZM5wlpeFuOWkCJbVjgrvk4qK2IYo4bzrioTcuWk889Y4UVpM/
         mxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=82jQgJ5EVrQ2a7459gmbGwx0yatt6MbCteDy+T0Kbcc=;
        fh=7nqO/pS7Y1CX6B1AszMeQCTpbCa6NkDA+PdHPOlcMZo=;
        b=SvN5nJKwfBe2ocnbxgxuzWrOowR68OKT/Ryh+XmXm9dan4GEIcdIWSU9d6TzqUgeme
         kE8FhYWG6jTn+i7g6tQmxE6PybF/EUwM5ZLbxCvKQy3ykTGmnFwC2NhFW2VhdIR9Z3yR
         HF3jVhf4OMqjZ6HrFfpeY5k+XJaB6YXuLgjrxMR8eWmanmAvs5fzaS2uhcYMavdNXAd0
         JMgzRX+OxLE1lmhc1IiRdcWRzxLhA07KB9qbqJid+QoshjVsvUzo37tkEhQDOazwDZ3+
         5+4e0Nr3K1hR3LTzRx6BJ/2SSGUs+lEoVt2dj13dLIqhOHOt3+k9KOPNQN9ssG4x8RbI
         Qcrg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157378; x=1795762178; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=82jQgJ5EVrQ2a7459gmbGwx0yatt6MbCteDy+T0Kbcc=;
        b=IgxudcgoC/32/6GjFsUMAtb5JMZOnFN5fnzdA+evicY4pETi5WdYSpZkARsegW3JHB
         mpyW6VN3m6echDIGH0WaK5T+55G7T9rydtvdBeBDwmOAlIdiMonn89C4gasgvGTnSA42
         6WfH2grbWSww1cdXitY73Jz3sfcsyeWRcHW2R9TmXnQul4LObYZLQtwV7Kg6Iz+38TMo
         crUn4iml0ZAhugtH6zblYYezmvI9bpb9iZTPSM/dMoWXeR4lQ60A54YTHpkoyHXk/1oZ
         2IYQeR9Su9QZHV+PM2Pjwg5ScSpmm22EzVNBOtgoZGMnE4xdWTQivILjP6KX/RbFIbt6
         K9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157378; x=1795762178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82jQgJ5EVrQ2a7459gmbGwx0yatt6MbCteDy+T0Kbcc=;
        b=uSSxfWeuNjpUYFaris45EMlRSycINvoHQQxS38/B/lXqolOIlle7f+kj06l85b+ZNO
         iHmZnYf812I3FPaHOoeMyXHzqJI3UJLOFqsBoEGtAZVpSG4XySvF0VImrGD3qC/UDxSq
         unMy9F2JvUR1yzvRUkffl8HHJSuZ4wsydNXWvQM+gJvSpKzGe1VsFwVk3wxSfMCuTldF
         /hEX8+eCgGIHWuhP97l+OlfN8AxoF1UdN30Qdm2xm0/81K4w5y5lBHfYwgt1Mov+oJUY
         Mqbf6H6IYWix96hKzeMWMta+3vz3YZptrdMq4Nim7c9iP/UrJnlMTyFQ/X2CI5xDNDR1
         O/tw==
X-Forwarded-Encrypted: i=1; AL+hErEqqiYbRAia3UpjrnNKWRteAUmAZ68HB0aVJYkfbcDUmqVtCsy+7MIktKdvkduDm9vAsR5ooA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/W/jgy8BHM75EQc9MKZabzQjIf10QNcN0d07MeOs90ZrbgAtU+
	ceZwFNEFMN7Qcjw9CnhoLsnMl7WSml+UqhO4n1xoX1du8WsboFCLGCwW4YtWBO8wyTjscs2T7NR
	lEigoivXLqU2UBVJNGrH9R1oupEa7Xis=
X-Gm-Gg: AYBFou0/APaS7Dl0ndR47qyjEFqnuTASY2SjCJjiK0fLcJ+AwygBFxcxHO+7ISZXDmh
	zTnfqZFr6IF7L+ho8oxyCyLm/AM4AWThGfxzLfAUmYh7mwHaBkVf6RXY658wfLRJsTdQJQXqYfA
	2EsqLLcRSPMPBNUkOyT1ynHAoK0VGZKfHMX5hdth0LwY82Shn7r+gj4wwCp2U9LFGqAbHdDwwSs
	+ujtDmF8XzCIq9nq2WVS6t1MHIKH12kzKssQVka+At+Y27KZwTCLLnLDy7KLyeM6ULSSEbnu7cn
	UsoafVpdUfBVta4Z8Okk4AHtayOx4PEuBb3i57cKLjk5hIBZZIsa8svDXg1IGrB8swGymca9u66
	mz+Tjujdk0pNCEuSMVqTwqPQvqMI0Y3FbhoU68xe9bbjg7xRWaFgYIuJmPWy73B7ckA==
X-Received: by 2002:a05:600c:37c6:b0:4bb:7033:c938 with SMTP id
 5b1f17b1804b1-4bb888147b7mr42207885e9.14.1795157377099; Thu, 19 Nov 2026
 22:49:37 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 14:49:23 +0800
X-Gm-Features: Aa3M54qOc1yY5SxJT7UDbDpxwpV9EzYxtLGhUe-eTcqoOXQmzD9xaaxO1UoM8Dw
Message-ID: <CAN_Opa_4DSrhb=nOKFEP2eV-WVaFpehpS1-o_PTO1cibJ8doUQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/17] mm/mglru: make generation page counters atomic
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
> No feature change, convert them to atomic so we can update them without
> holding the LRU lock. A temporary underflow is fine: readers clamp a
> negative value to zero, and the counters only need to be eventually
> consistent.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h |  6 ++----
>  include/linux/mmzone.h    |  2 +-
>  mm/vmscan.c               | 26 +++++++++++++-------------
>  mm/vmscan.h               |  2 +-
>  4 files changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 2edb9beef6d3..46beded51c7d 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -265,11 +265,9 @@ static inline void lru_gen_update_size(struct lruvec=
 *lruvec, struct folio *foli
>         VM_WARN_ON_ONCE(old_gen =3D=3D -1 && new_gen =3D=3D -1);
>
>         if (old_gen >=3D 0)
> -               WRITE_ONCE(lrugen->nr_pages[old_gen][type][zone],
> -                          lrugen->nr_pages[old_gen][type][zone] - delta)=
;
> +               atomic_long_sub(delta, &lrugen->nr_pages[old_gen][type][z=
one]);
>         if (new_gen >=3D 0)
> -               WRITE_ONCE(lrugen->nr_pages[new_gen][type][zone],
> -                          lrugen->nr_pages[new_gen][type][zone] + delta)=
;
> +               atomic_long_add(delta, &lrugen->nr_pages[new_gen][type][z=
one]);
>
>         /* addition */
>         if (old_gen < 0) {
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c161d563ce8f..4c4aad95b0b6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -554,7 +554,7 @@ struct lru_gen_folio {
>         /* the multi-gen LRU lists, lazily sorted on eviction */
>         struct list_head folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES]=
;
>         /* the multi-gen LRU sizes, eventually consistent */
> -       long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> +       atomic_long_t nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
>         /* the exponential moving average of refaulted */
>         unsigned long avg_refaulted[ANON_AND_FILE][MAX_NR_TIERS];
>         /* the exponential moving average of evicted+protected */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fe1fe1439c7c..8d14831cdf83 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3350,8 +3350,7 @@ static void reset_batch_size(struct lru_gen_mm_walk=
 *walk)
>                         continue;
>
>                 walk->nr_pages[gen][type][zone] =3D 0;
> -               WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
> -                          lrugen->nr_pages[gen][type][zone] + delta);
> +               atomic_long_add(delta, &lrugen->nr_pages[gen][type][zone]=
);
>
>                 if (lru_gen_is_active(lruvec, gen))
>                         lru +=3D LRU_ACTIVE;
> @@ -3971,11 +3970,8 @@ static bool inc_min_seq(struct lruvec *lruvec, int=
 type, int swappiness)
>                                 break;
>                 }
>                 flush_lru_batch(head, &batch_end, target_list);
> -
> -               WRITE_ONCE(lrugen->nr_pages[old_gen][type][zone],
> -                          lrugen->nr_pages[old_gen][type][zone] - delta)=
;
> -               WRITE_ONCE(lrugen->nr_pages[target_gen][type][zone],
> -                          lrugen->nr_pages[target_gen][type][zone] + del=
ta);
> +               atomic_long_sub(delta, &lrugen->nr_pages[old_gen][type][z=
one]);
> +               atomic_long_add(delta, &lrugen->nr_pages[target_gen][type=
][zone]);
>                 if (!remaining)
>                         return false;
>         }
> @@ -4093,8 +4089,8 @@ static bool inc_max_seq(struct lruvec *lruvec, unsi=
gned long seq, int swappiness
>         for (type =3D 0; type < ANON_AND_FILE; type++) {
>                 for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
>                         enum lru_list lru =3D type * LRU_INACTIVE_FILE;
> -                       long delta =3D lrugen->nr_pages[prev][type][zone]=
 -
> -                                    lrugen->nr_pages[next][type][zone];
> +                       long delta =3D atomic_long_read(&lrugen->nr_pages=
[prev][type][zone]) -
> +                                    atomic_long_read(&lrugen->nr_pages[n=
ext][type][zone]);
>
>                         if (!delta)
>                                 continue;
> @@ -4625,8 +4621,13 @@ static void __lru_gen_reparent_memcg(struct lruvec=
 *child_lruvec, struct lruvec
>         child_lrugen =3D &child_lruvec->lrugen;
>         parent_lrugen =3D &parent_lruvec->lrugen;
>
> +       /*
> +        * The child is offline and the lockless updaters, which hold
> +        * rcu_read_lock() over the update, avoid racing with reparenting=
,
> +        * so the read/set/add operations below are safe.
> +        */
>         for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
> -               long nr_pages =3D child_lrugen->nr_pages[gen][type][zone]=
;
> +               long nr_pages =3D atomic_long_read(&child_lrugen->nr_page=
s[gen][type][zone]);
>                 int child_lru_active =3D lru_gen_is_active(child_lruvec, =
gen) ? LRU_ACTIVE : 0;
>                 int parent_lru_active =3D lru_gen_is_active(parent_lruvec=
, gen) ? LRU_ACTIVE : 0;
>
> @@ -4634,9 +4635,8 @@ static void __lru_gen_reparent_memcg(struct lruvec =
*child_lruvec, struct lruvec
>                 list_splice_tail_init(&child_lrugen->folios[gen][type][zo=
ne],
>                                       &parent_lrugen->folios[gen][type][z=
one]);
>
> -               WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
> -               WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
> -                          parent_lrugen->nr_pages[gen][type][zone] + nr_=
pages);
> +               atomic_long_set(&child_lrugen->nr_pages[gen][type][zone],=
 0);
> +               atomic_long_add(nr_pages, &parent_lrugen->nr_pages[gen][t=
ype][zone]);
>
>                 if (lru_gen_is_active(child_lruvec, gen) !=3D lru_gen_is_=
active(parent_lruvec, gen)) {
>                         __update_lru_size(child_lruvec, lru + child_lru_a=
ctive, zone, -nr_pages);
> diff --git a/mm/vmscan.h b/mm/vmscan.h
> index c2cea36289f3..6551f0a6691a 100644
> --- a/mm/vmscan.h
> +++ b/mm/vmscan.h
> @@ -126,7 +126,7 @@ static inline unsigned long lruvec_gen_size(struct lr=
u_gen_folio *lrugen,
>         unsigned long size =3D 0;
>
>         for (int zone =3D 0; zone < max_zone; zone++)
> -               size +=3D max(READ_ONCE(lrugen->nr_pages[gen][type][zone]=
), 0L);
> +               size +=3D max(atomic_long_read(&lrugen->nr_pages[gen][typ=
e][zone]), 0L);
>
>         return size;
>  }
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
