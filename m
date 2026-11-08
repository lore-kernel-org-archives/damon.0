Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174518;
	b=u9DQfQesQvqcTmhcOC6PvWIJX1YXymzAMU2Al1oFk/pJ7s6Z0cUU2Jz048vBUlX5nA5x
	 UZKzXEBQKc7gpPLLFYojdrQNCegUC98LtkEmxlOv5hrtfNjxoDU74GurfKEMb4t6tsCdX
	 Eu02Z/Df9W6vlfwKCM5D4w1a2knsTC+nFzGkC7hbkMZi7mq2/DZE8eYV3pW4QcYep3w56
	 xfEZfIm5qHabxhiOJZtai/ZfJT4MW7Q62a9Iyj1O7zChqyxNV0BtKcP9KBci8xyJFfNLy
	 hADU9UNzuNpJPZucqU4X65Gt1NnuS6sQs/WwIrTszCPH2Sohe3Q8xFRitpbISoZahUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174518;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FZdZQVw9H6aXCI8eUM5Z1MxH6OVioYDlzBV87SdVf/c=;
	b=Da3XSVb2E+1rtEwZhaIZgyzP3SfYuEwxbZif0ULoXrHNknTUCjA9iUg6D5xFTVTs7zdP
	 hpvmU/Ymee6QVtaY+aMreE+WgDWJrsgKsEyE7cv8JqHqL4pIfQjoHN+Yil2y2z+h8/yCH
	 XmLMgrpbngm0tXKuUXWBqIY7icRDdW6/nknS/m6kawd1V5Qt5pXfq0bkp0rJmg90qgVDI
	 SLlVxK/UOqhWOtbDwW1D3Eh+dZP7hKN+LnbxBEpJntSUYL+cpMwASprAawzGxbl2oP5ma
	 EeSVklskmEyC8S4HwxldqEiCbj8IfvGApO/1csUcHxp/Zs2JkPETIni4T5UEW9vznQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h749haC2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B3606A320
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h749haC2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD6E1F008A2
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174517;
	bh=FZdZQVw9H6aXCI8eUM5Z1MxH6OVioYDlzBV87SdVf/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h749haC2V/XH+rC3K3xZ2wCvKWGJ5JE0f2GbovfaHTt3D/u5QfXd2iyVCNiTnKZIM
	 ODXuy42y0MzQgkjbdEXs5txIu2ux86/C7yTN2i6Y97nMIvvqTE9JbB1QCxj4578oQp
	 Lr+way/ME1xPBlUjZwlPKWnL21bwu8ouWiWvid8JkmXrT2/Dghr1kakaG4ZT1HbAhU
	 irwHehre1CG1W9ESNDHyBWhpYkguCYcFz71xLk+S6rtitM48OYMowLo5OjsvysreQO
	 UvscgMaY+RKC3bXCjWT7Z75qS16oxBBXJnPsz39uJ4vpbrgf6Rcgb39zxA8hb6tai2
	 dBYUK1t/dssHA==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f1cf92c9eso27412685a.0
        for <damon@lists.linux.dev>; Sun, 08 Nov 2026 13:48:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFEPr/d2R0znxKnGBkoqq+feel1CZzfxf/TLTjKWnU8L5D7LyLTELF2k+6bSH2lBqJoyt9JWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Lwaqp7kS+xJwzoS2C3wIe5W7EvtzVyyjHrgSYxm5PKuJ3J3yd
	Tt+oZbfMRBKaGiym9sb+1fAH7v56jqroytYKnBIVUI+3saryOnc7j8n8JYrMihTsjrsLhypTxfa
	lONQcmaKa7GybX0N20RksGHrMLxyqjdM=
X-Received: by 2002:a05:620a:838d:b0:93f:568d:ebbf with SMTP id
 af79cd13be357-947847989dcmr307877085a.75.1794174517262; Sun, 08 Nov 2026
 13:48:37 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com> <20261016-mglru-fg-v4-15-2106750c0bfa@tencent.com>
In-Reply-To: <20261016-mglru-fg-v4-15-2106750c0bfa@tencent.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 9 Nov 2026 05:48:26 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wTFHJxzuiRDBcuevdULMcD+se6SuPbzWKA8wsUAG80_w@mail.gmail.com>
X-Gm-Features: AclHuK-s7JbtIEWTZGMVhiT12ls0SfPHfw3O0hQ9GXy9byf5WRAn6-BR9O_AjyE
Message-ID: <CAGsJ_4wTFHJxzuiRDBcuevdULMcD+se6SuPbzWKA8wsUAG80_w@mail.gmail.com>
Subject: Re: [PATCH v4 15/17] mm/mglru: make folio_inc_lru_refs lruvec lockless
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

On Fri, Oct 16, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> concurrent aging from corrupting the size counters.  This is no
> longer needed: the per-generation counters are atomic, and the
> active/inactive ABI counters are updated per folio and linearized by
> the CAS on the folio flags, so concurrent aging can no longer corrupt
> them.  The same argument already allowed folio_reset_lru_refs() to
> drop the lock.
>
> Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the RCU
> read lock around the lruvec lookup, and drop the spinlock entirely.
>

Yes, this is cool. We have two paths calling
folio_inc_lru_refs() or folio_inc_lru_refs_walk().

1. folio_mark_accessed() from syscall access
2. walk_update_folio() from page table walker or look_around

For the latter, we can't actually cross multiple
lruvecs/memcgs, because of get_pfn_folio() as shown
below:

static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *me=
mcg,
                                   struct pglist_data *pgdat)
{
        ...
        rcu_read_lock();
        if (folio_memcg(folio) !=3D memcg)
                folio =3D NULL;
        rcu_read_unlock();
        ...
}

Consider a common library file used by 100 memcgs, with
its folio residing in the root memcg.

When walking the 99 non-root memcgs, even if the folio
has been accessed, we won't get a chance to call
folio_inc_lru_refs_walk() for it. As a result, this folio
may eventually reach the eviction rmap path. With a high
mapcount, folio_referenced() could become quite
expensive.

That's what I was trying to point out here as well:

https://lore.kernel.org/linux-mm/20261102213915.57805-1-baohua@kernel.org/#=
t

For the former, you can get the lruvec with:

lruvec =3D lruvec_live_lock_irq(folio_lruvec(folio));

I'm wondering whether we could eventually unify them
so that both support cross-memcg inc_refs.

This isn't a blocker for the patch, just something I've
been thinking about.

> Without the lock, aging can advance max_seq while a promotion is in
> flight.  Generations are indexed by seq % MAX_NR_GENS, so the folio
> flags can return to the value read earlier and the cmpxchg succeeds
> with a target gen computed from a stale max_seq.  Recheck max_seq after
> a gen-changing cmpxchg: if it moved, account the committed update and
> retry with LRU_REF_FORCE, which promotes the folio to the newest gen.
> The retry may count the access twice, which is acceptable and avoids
> folio_activate(), whose LRU lock causes latency jitter.  smp_rmb()
> orders the flags read, including the one returned by a failed
> cmpxchg(), before the max_seq read.
>
> Also simplify the post-CAS accounting guards: gen is only assigned
> non-negative values after the old_gen < 0 early exit, so gen !=3D old_gen
> implies gen >=3D 0, and lru_gen_update_size() needs no explicit guard.
> The active/inactive ABI update keeps its gen >=3D 0 check because an
> off-LRU folio has no lruvec to update.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Thanks,
Barry
