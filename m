Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170912;
	b=qkseNSexd6RW2VFVur/yhgMooBXDv3vwVCSvc4gyE7DCGAbAaoSeQH/V7z4/n11jyM9x
	 CLadf7z8CQ/eqVUKSykYydSI+xWkk6+t/0b2BNmhLkRHfZGCGUcswTHLM8A5QNgosMqzB
	 OqL4Z789aWIUSTFnj0vBaB5LnExHqVodN9X5EcbD7aiXGqB1813MDxI6CevSylEOIWU3J
	 oCpIJOievxub1qfXqhShvIL0raSNHnREjJFQpVRnmvdr59vOSlgmFnah/dzOrsxGzTiTx
	 438WC+h6LMuToYEW9/lnUhqh31RggNIMJJaV4915Bbqf1wF9du3l25NWNbgcHhnpY9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170912;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=djErT1YvUu0mkM8hSl51RULADOIRnOJrc/Fo5hTxu3A=;
	b=Lvbl0iFvrdy4vJnQ+3Nq3zj3BVQPhUO2ozS7mk+cuZIan4OLN4tYCmMQuTIen7hw034O
	 CCFTIvxx6iOgA7+yo5cOBxwlrztq7HJBIHC0tcxttvKVkUBPM/MmYPpUq0hOxP1UZ96Ya
	 tyHbaG2sGyN7WIn/4chR9Y7D4Y5WpK5yCmYTikKzNY3IvXJ4xZzeNAXSVTJxCjlNCCaov
	 +ZqUoPzSOUNRAEGWM2BLpXcdNN40nva/pr1X2skArF+ec35eu1pEZlsmvjaBKwQciMnWP
	 pivdKNOrBzXydts0LzDqoARBDtxv/vK60Y/KUixw0RCrXGWV+zIZ0TjKo998Je8OkkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ9dr7Vw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09C606A33B
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ9dr7Vw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F4E1F0093E
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794170912;
	bh=djErT1YvUu0mkM8hSl51RULADOIRnOJrc/Fo5hTxu3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VZ9dr7VwZlMqRCf2cZMC4mKBGmvOV4lXJUDDdnwvlDhOR0IigvXaYtuZTIbgdtsNL
	 f7i8FNCsRcbBGJJWx/OiQOMQIOi7j/NPX9ieTBzSWYw8PLgkFZkhiWP9IWO9uPxVdo
	 tNh1aka09dtSXfHWJG2oEajh3/HV2MYm0oZh42efak/XWKeBLkvbqt62djOGExRmGr
	 TS3Gf5XOK1gSeOnsmKJgoyrGsTNpYdAAgaGblzNlLLA22lCk7JlnYaKHuKIh3QNglu
	 0sL4bJmxZmhPf+AS132DBPMHIJ87VEQIBjTBRbj5lwRegYRCHJvHxHdIxJnl3pRujR
	 Jqo4EGqr3vFmA==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f3c8958d5so28108985a.2
        for <damon@lists.linux.dev>; Sun, 08 Nov 2026 12:48:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG1ykZg85hAHhjyAwkn0xICE+4F7oKXFwFkbi9+zh5oJaOvLyrJyQM5r7nTrxSWBsE5JAjQww==@lists.linux.dev
X-Gm-Message-State: APuU4Z9vRUwW5F1LycxqDK3KzA2lthx6SqUHRZa/Pt4JexDlBr4qetf0
	kAmrfnAXJKrGorxYpshzOfoy4vOo/X16VXKL+Vj3mI5Mk5dYqfhgEqNX1bPS505oaxdUCDctDFN
	HJ3ZT1RWu5wjAcT+4HGawzBprV29jhQ8=
X-Received: by 2002:a05:620a:1706:b0:944:d7b:e7a with SMTP id
 af79cd13be357-9478427a79emr342902085a.52.1794170910757; Sun, 08 Nov 2026
 12:48:30 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com> <20261016-mglru-fg-v4-6-2106750c0bfa@tencent.com>
In-Reply-To: <20261016-mglru-fg-v4-6-2106750c0bfa@tencent.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 9 Nov 2026 04:48:19 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zQh0TnAxifWPo2+DcyFFOtpXM+2QW91A07oumfyrqVYg@mail.gmail.com>
X-Gm-Features: AclHuK_zbDT_3bnI0_EC4q_0TU7opSFYKTqi1euA2GlbUa3wQRMNDwIK1fC-8Kw
Message-ID: <CAGsJ_4zQh0TnAxifWPo2+DcyFFOtpXM+2QW91A07oumfyrqVYg@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] mm/mglru: move add/del LRU size accounting out
 of lru_gen_update_size()
To: kasong@tencent.com
Cc: linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, SJ Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, zhaozhengzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 2:15=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Pure code shuffle, no behavior change.  lru_gen_update_size() now only
> updates the per-generation counters plus the promotion move; the
> addition and deletion active/inactive accounting move to
> lru_gen_add_folio() and lru_gen_del_folio(), which know the generation
> and can apply the active-window test directly.
>
> The unevictable case is untouched: unevictable folios never enter
> lru_gen_add_folio() and keep being accounted by lruvec_add_folio() as
> before.
>
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

The patch looks good to me.

Meanwhile, I've been struggling with the names of
__update_lru_size() and lru_gen_update_size() for a long
time.

Given that lru_gen_update_size() now only updates
nr_pages:
static inline void lru_gen_update_size(struct lruvec *lruvec, int type,
                struct folio *folio, int old_gen, int new_gen)
{
       ...

        if (old_gen >=3D 0)
                atomic_long_sub(delta, &lrugen->nr_pages[old_gen][type][zon=
e]);
        if (new_gen >=3D 0)
                atomic_long_add(delta, &lrugen->nr_pages[new_gen][type][zon=
e]);
}

while __update_lru_size() only handles
active/inactive accounting, could we rename them to make
their roles clearer? For example:

lru_gen_update_nr_pages()
lru_gen_update_active_inactive_size()

The names are longer, but the lru_gen_ prefix helps
distinguish this accounting from the actual
active/inactive LRU lists.


>  include/linux/mm_inline.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index cfcbe4a9aa85..65415eeac802 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -313,21 +313,9 @@ static inline void lru_gen_update_size(struct lruvec=
 *lruvec, struct folio *foli
>         if (new_gen >=3D 0)
>                 atomic_long_add(delta, &lrugen->nr_pages[new_gen][type][z=
one]);
>
> -       /* addition */
> -       if (old_gen < 0) {
> -               if (lru_gen_is_active(lruvec, new_gen))
> -                       lru +=3D LRU_ACTIVE;
> -               __update_lru_size(lruvec, lru, zone, delta);
> +       /* return now if not a promotion */
> +       if (old_gen < 0 || new_gen < 0)
>                 return;
> -       }
> -
> -       /* deletion */
> -       if (new_gen < 0) {
> -               if (lru_gen_is_active(lruvec, old_gen))
> -                       lru +=3D LRU_ACTIVE;
> -               __update_lru_size(lruvec, lru, zone, -delta);
> -               return;
> -       }
>
>         /* promotion */
>         if (!lru_gen_is_active(lruvec, old_gen) && lru_gen_is_active(lruv=
ec, new_gen)) {
> @@ -381,6 +369,8 @@ static inline bool lru_gen_add_folio(struct lruvec *l=
ruvec, struct folio *folio,
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> +       int delta =3D folio_nr_pages(folio);
> +       enum lru_list lru =3D type * LRU_INACTIVE_FILE;
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>
>         BUILD_BUG_ON(BIT(LRU_GEN_WIDTH - 1) !=3D MAX_NR_GENS);
> @@ -396,6 +386,10 @@ static inline bool lru_gen_add_folio(struct lruvec *=
lruvec, struct folio *folio,
>         set_mask_bits(folio_flags(folio, 0), LRU_GEN_MASK | BIT(PG_active=
), flags);
>
>         lru_gen_update_size(lruvec, folio, -1, gen);
> +       if (lru_gen_is_active(lruvec, gen))
> +               lru +=3D LRU_ACTIVE;
> +       __update_lru_size(lruvec, lru, zone, delta);
> +
>         /* for folio_rotate_reclaimable() */
>         if (reclaiming)
>                 list_add_tail(&folio->lru, &lrugen->folios[gen][type][zon=
e]);
> @@ -409,6 +403,9 @@ static inline bool lru_gen_del_folio(struct lruvec *l=
ruvec, struct folio *folio,
>  {
>         unsigned long flags;
>         int gen =3D folio_lru_gen(folio);
> +       int zone =3D folio_zonenum(folio);
> +       int delta =3D folio_nr_pages(folio);
> +       enum lru_list lru =3D folio_is_file_lru(folio) * LRU_INACTIVE_FIL=
E;
>
>         if (gen < 0)
>                 return false;
> @@ -422,6 +419,9 @@ static inline bool lru_gen_del_folio(struct lruvec *l=
ruvec, struct folio *folio,
>         gen =3D ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
>
>         lru_gen_update_size(lruvec, folio, gen, -1);
> +       if (lru_gen_is_active(lruvec, gen))
> +               lru +=3D LRU_ACTIVE;
> +       __update_lru_size(lruvec, lru, zone, -delta);
>         list_del(&folio->lru);
>
>         return true;
>
> --
> 2.56.0
>
>

Thanks,
Barry
