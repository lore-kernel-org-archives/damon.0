Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211731;
	b=bdIXhiO8M4RcqZysZl0dBLnVilDKHhSpqSXgNlz1hGxPw2omfy4gbJZMnn+98C2fO09a
	 yeafr1Pv3Q1LAYfgTaqjlDOJNaAKbWi6x7mOcyYk7mb9L7134/pLiaBQQ+SzDyHzw22wq
	 oO/cH+bVT/eva6cd5i795Ve/myBYTc/RETxbMxyPZd2eS1hYsCUDfYU+8p4D6ePIRdRve
	 15+rvD9sCxCUpXkkLF3PFiznopSuvNyoq+HrlIAzLwRrIEFICTQ9xKuhFmjFbtPMGV8Oi
	 6sgeXDZTBwgSEMJMUJn1QlM8qOqnKolJAXK4ou+hLDKVZ82tfU8W/MighmO2Dz8BAGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LiMJF1XvwF+Qc5jdWubo4n2qJDpryfHhpNFCa3GO55Y=;
	b=sPpCyjuukcdhlFN/1w0XpG9ca+oMx9brukxX1o0c4M6nyJJjC0JA0tPWATCNmybHcYR6
	 y8pFimVuFJggZTl/LT7Y8+NUU8DFEVdyiatL/++QW+0+rbfezNKzFuWzHvTeBsjEiXnSL
	 ql0zN0oXHIuO0XZd5JKxg1w40vvuc6EcDPb/0Rfrhnkt7qUL2C7N8mtgN87VVR6+4xckx
	 CW4x9Rcm0L7lb8SOh/mSFOuai/JVaQYOFuhkeWs34zRyW/8ywf9gXeej3OhTdilZrlneK
	 2DAK4JGWvADpCTYvarLVO8H7Ux6/ZSN/kuNZ7/vcSuAalUb7o2X4LO6ms2a9MVOpkrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6j8lzD5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A10606A330
	for <damon@lists.linux.dev>; Mon,  9 Nov 2026 08:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A10606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6j8lzD5
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c45551fa84eso74719066b.3
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 00:08:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794211729; cv=none;
        d=google.com; s=arc-20260327;
        b=JS+KgRmeTB2L6wz9ZlXgf2C8aXMAn7V9UatclJdVc96bm0EM9CTHuoNFZavJmfaAn2
         9tsfFRifbfCJjkdT+LS5guXzhEYbgTen4MAUPYzPvb6X9cpYz76pjRzU4VSdZr5KvZeT
         ivn7qef8DDH7M2TIeunr97ucfIQEhTwPcSvRDSFsAV2z+jHuObrngeOl/31wTdLicu85
         oTcGPTJNs109frme08A+ww+yLu5Ym3OnVt1i4aDa+WgSIj9fp/yJnVPfDSI7ZHxsCqdy
         ls/nkgftRS20KXoeeGESs9HkyhW9vroR3aiUgix4Wtpn35i8A8H8aZSEehxbZdqkqqSN
         6h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LiMJF1XvwF+Qc5jdWubo4n2qJDpryfHhpNFCa3GO55Y=;
        fh=g2GwwMR52dn09p94gdA0OAsLwIGvTj23/k9i36wpYH8=;
        b=UX5GpDV5rr1F8NhGD+JY9UOSurkChTZK6tHdoBrOEVt1Md2y3B/8FMmxYlVDTxE9JI
         pBzmmTlWY3trI0KFxlsKnC5RHiwTtudfwlX8JsFeCNdiw41hn0TWzj0LCxE/cpUsOtfA
         jZk1aW2jsHFDESpAwAgmCSfZ1drsvhmqs6vnSsFkr/m6KQt09u74i917BMeZtWmWDLss
         32IMQbobEJQtfAwYEU2AD2Pianfv/xard+qYocXP1hg2+Q1X4LCYYmcNNJt5UtjUqqEw
         KTt99TI5+mXz/PQemfX04qz4AJbK5F/RYwu2alFfUhIUb2XTe02MObvbJcEDY+FWmn95
         fSkw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211729; x=1794816529; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LiMJF1XvwF+Qc5jdWubo4n2qJDpryfHhpNFCa3GO55Y=;
        b=y6j8lzD5dha0eJHQTnNJgy7LWHWB3PUqmXaei8QeMdYixm1QWHIHzXxfyxRAytHY8l
         TrmA0kUNTQut6sgg2eivWX+I7xbtj7hB1fk8rmlDuH8obpMhKy2BIrq9wGqv+VsNaIXz
         RKfXQkrYYytaJetXvYdPpOjEDfKc4HDt+M8bRPfXpkQGYMQs0vZ5jbVbjvvFFovvyBck
         p8Vmwq8vyMKmzYW3LGv4Y9nppr8vZD5MTkfeZlgMNsIC/V9b/Z+X0dCXLJIknFW51b6N
         G8vIYYyIssp9qrkQah02rr+tr9Ak+IUPoPLHRnsu9LsTJjn2hqAde8lZDQ3XVkue7dab
         9/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211729; x=1794816529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LiMJF1XvwF+Qc5jdWubo4n2qJDpryfHhpNFCa3GO55Y=;
        b=L+69rZX1BPPH3ekWHahsGcNh5NnOJ855ffEUcuwquHBsxjbLbrcx3uId+1CotX7Hwh
         sS2c71sKD7B2cUjhO1yeWZzBxKWD0UX1rpsDp8Su7m+NFQqaP/3JuxoF5roIdSSRbUTs
         PPtRhv8FX6DfJ61SInwZxwO7zC0otrLTd/YAMGYjE+h/tZL0HZk8cVdWsBT0xIbnVeAQ
         6SQsYsGxTG7KJ+R1qBkDgmiUyecR/ZNJm/Ad6X9SNEYJXZD4MwVSf9rj7JfUE0l8XQEj
         oLRec6XHpYswKTH3TrzpoJJkCmHbcb3d0+RfuKkwssy8+kd60VbQnVVILdcKIvz67gJz
         zXOg==
X-Forwarded-Encrypted: i=1; AL+hErFnYkIdcnXJv2xOIj48BGdztkYFBn9pPKXqViDvU/Ny/BpaJDya29alDPtfH/TQRZ+cr1mXrQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+gHYKBYIJXEHjn/mJW+SeJ3YWo0Oa0sPuoo++ZRFWnymU6ybc4
	TxQeutrxtd2zb+61xr5dhB8ZwAz8rgzW/d++H93Rg9qKjZ5MEcsjRvOzC2jHC1MquPv/1CXpR7Z
	JtkpD5qNYG6lcVp+u0dUY5aslauYuw7c=
X-Gm-Gg: AYBFou0P3aWe8T0rFYpVJ3LjsIIYFas4V3hn9cYSN03c8bp1jDicnXte0i4q+ZQHTtM
	MmZY9mjHQ5lqqfdlf8WyiSIHCtLh4LRa+9Odqe5y37ytAujAYu1++vYoo1JulNT+WxtN5Ut+e10
	bl2UZqoIBfDKIkroG3SrjALrAg8OEE+4GVf6Xs+1/QNa5NkFFOBxXSikWeR9jNyzW5YDPpR2XqO
	R6yLTRHF5AE81hzd8x56PLa7i+q0zUWAU9EgZKzq0GHRaeqLxYkgpEZCbZNSeV9RIpfA2NfbdhS
	ooEVU9ZTfVfybryga92CVi26ujR6vXylbdAGtraqgHFBvLfO8IJHjNDmEgFoajgcGRcO4i1zkc+
	vHfr/e8XTOkYJbgz/vwQ9x5qloLuQUuLIV/FexXnPHxnmm9vxsLwFxOSXJmXBZs0oghmm
X-Received: by 2002:a17:906:d54d:b0:c42:4750:8d33 with SMTP id
 a640c23a62f3a-c4d6d79c9e9mr220208366b.28.1794211729178; Mon, 09 Nov 2026
 00:08:49 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-15-2106750c0bfa@tencent.com> <CAGsJ_4wTFHJxzuiRDBcuevdULMcD+se6SuPbzWKA8wsUAG80_w@mail.gmail.com>
In-Reply-To: <CAGsJ_4wTFHJxzuiRDBcuevdULMcD+se6SuPbzWKA8wsUAG80_w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 9 Nov 2026 16:08:12 +0800
X-Gm-Features: AclHuK-rg_Epjx8c_oIR5RKRDfprNqzR2T_gknTk1R87bd-Y63IPVOAg_lUq4r0
Message-ID: <CAMgjq7Atry0zRc_-xbrL_VubxTBQOT8R2_aumghXQaO9uTANHg@mail.gmail.com>
Subject: Re: [PATCH v4 15/17] mm/mglru: make folio_inc_lru_refs lruvec lockless
To: Barry Song <baohua@kernel.org>
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
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	zhaozhengzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 5:48=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
>
> On Fri, Oct 16, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> > concurrent aging from corrupting the size counters.  This is no
> > longer needed: the per-generation counters are atomic, and the
> > active/inactive ABI counters are updated per folio and linearized by
> > the CAS on the folio flags, so concurrent aging can no longer corrupt
> > them.  The same argument already allowed folio_reset_lru_refs() to
> > drop the lock.
> >
> > Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the RCU
> > read lock around the lruvec lookup, and drop the spinlock entirely.
> >
>
> Yes, this is cool. We have two paths calling
> folio_inc_lru_refs() or folio_inc_lru_refs_walk().
>
> 1. folio_mark_accessed() from syscall access
> 2. walk_update_folio() from page table walker or look_around
>
> For the latter, we can't actually cross multiple
> lruvecs/memcgs, because of get_pfn_folio() as shown
> below:
>
> static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *=
memcg,
>                                    struct pglist_data *pgdat)
> {
>         ...
>         rcu_read_lock();
>         if (folio_memcg(folio) !=3D memcg)
>                 folio =3D NULL;
>         rcu_read_unlock();
>         ...
> }
>
> Consider a common library file used by 100 memcgs, with
> its folio residing in the root memcg.
>
> When walking the 99 non-root memcgs, even if the folio
> has been accessed, we won't get a chance to call
> folio_inc_lru_refs_walk() for it. As a result, this folio
> may eventually reach the eviction rmap path. With a high
> mapcount, folio_referenced() could become quite
> expensive.
>
> That's what I was trying to point out here as well:
>
> https://lore.kernel.org/linux-mm/20261102213915.57805-1-baohua@kernel.org=
/#t

Hi Barry,

Thanks for the review, I saw that too, very interesting approach! And
I believe it will helpful.

> For the former, you can get the lruvec with:
>
> lruvec =3D lruvec_live_lock_irq(folio_lruvec(folio));
>
> I'm wondering whether we could eventually unify them
> so that both support cross-memcg inc_refs.

Definately, actually for that link you posted, combined with the code
snip above, after FG, I think we can further simplify that, no need to
check mem_cgroup_is_descendant, we just do:

- folio_inc_lru_refs_walk: if the folio belongs to the lruvec being
walked, the batch stays in walk->lruvec
- folio_inc_lru_refs: if the folio is a remote one, per-folio, no batch

non-descendant folio sharing across memcg are actually quite common
e.g., libc and shared mapped memory, this could be more helpful? And
it seems fast for the walker.

folio_inc_lru_refs_walk follow the same rule as folio_inc_lru_refs
(with MAPPED flag), just faster, skipping RCU and the speculative
check afterwards as the walker owns the seq it is advancing, and
caller handles the batch update of counter. While folio_inc_lru_refs
only requires the caller to hold an reference to the folio it heavily
relies on RCU / CAS conventions, not easy to batch things there, but
it's still accetablily fast already (e.g. the fio read test showed
almost no performance penalty).

And I think the main reason MGLRU can't operate cross memcg was, lack
of a protocol to stablilze the memcg's gen and holding a lock is too
costly, now folio_inc_lru_refs handles that, and FG
 lives on top of that. So we can try that out right after the FG series.
