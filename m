Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795614725;
	b=A8pldpooPFaCjX0B9AAqdpY0SJc4RkXm8O3D1FHgEqh+21Ud4oQJsmu7XfKsjFVoYskQ
	 OigSX43f6sy5u9/MYWkcpqKq1tcBC7iZBWh6+KJYBjk+ED7oOhW4axCYRzFE6BhG3fcRr
	 of9WagHunV2p+P7vzFtxqm0tI/NQ0PxDEaTTzJDT7uD38T/2Ff3IFdRiZj2CKYZaP9gjy
	 CChL1uwBxY9ZfiRicyU7d347xckR/dYsD8drxYdNNXeJyXXn6UlH0yz4j22LFY+1GzFgd
	 b3Eia8HARSPFIC848edaNuVenQZdm/tHLkEYNCGNgWs5V/GmT8imd1o1q89sKqq+KWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5FkHuxjNkBWcpazSUQh3/1ocxLfgOD0ATmjtxGIbMcI=;
	b=rUwBWPlgpJdQFgqXeQboE3kzyB6RZrOSiN9qQPU+h3v1Uj4hoEwAtZQ0lwcFqtqLJkEJ
	 P8jzUhcVMi7wslMHvtOsdsgY3udLc0zyJ843+iup2ExvpiJt8q+u0Jbq9UxZVwW9k1HeA
	 HLqTtSwQdYWFEVgY8fCSohTr5tSYHgY8apiwNgQf8lXAcKmhm2zmOR1h1e1K27udJjz40
	 oE1cyTfSuKImTluc+qBZM//xNwttiRh/eURSI8WkYBnjQ3Lm9RAeHB8Oxse2j9rzM/dPn
	 +FMom/RaQGkTE6tNIOgeWJm2wzT+QcAnrhK0qnH7VQYdjpx/d+YmHcQsCQJTelMBREw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvL4cF2v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4492606A335
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 13:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4492606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvL4cF2v
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b88bc47e23so7439937a12.2
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 05:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795614723; cv=none;
        d=google.com; s=arc-20260327;
        b=a8HWkE76oetH2eum4hMlvue5z0ptHhCojjjVzS632smjM1pBtCDiHt9CfOeuKZif0m
         pGoGiF0beKStCvIGx5sD+K+7BEEn5qxw5DSW6lT8w6XvblcgjSHTXnOg2s+lFQcUmQYk
         SqWs1XvE7cEnCYuoqTA+ko1RO5vEuO/zAvmDwcZBNW4P+k8wBfp4Y8FCmA5NJ+atpXzS
         Ha6MBcjAegabAK+jRS++/PjzJgRPV0SC2kn6qVhJmHN93v8IKZWAbxM2FRvZZ0yq+dt/
         V/mXNJaU0SkaJWAl7ePTPAQSkxOjwgfCEkSIfbVc6NWyHenGQqgOmoWg5i0G3ZPDX5Pc
         uMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5FkHuxjNkBWcpazSUQh3/1ocxLfgOD0ATmjtxGIbMcI=;
        fh=SQiEn88rVlcbTzX+juZ00KVxgJkjRRk3PQWS3Hh5oIk=;
        b=GHFyR82x1IbU6iXx0iwMUlZv0oqIin5lhLqMkrNGQ1zHPuF7ZfHjJ9QkjsoODTGYib
         q7JHmPvjgt060XiczoNFmJoq97GLH/8f4GvHGlqryefyBAqxLWzf25XWxD2u5LRkhwF8
         pmC5QICfrfuyc0Lq0xOEAoAegS4JbPotE29m3j1Zm1dD1NkshTNhvy7DlIPu6LXnEusK
         gwtA8RO+BEK2N9GUDqf8sLWw3rUHoM9/qNUJcFX4spf9+ZKys26+Uo5IJF6HfOafZS4V
         824eZQE3iHTKwlphiDjwyev03jwG7AMGzzYS/fNRuV6AUPcsoPj+rZyM+9FDHwDp8nzJ
         WqgA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614723; x=1796219523; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FkHuxjNkBWcpazSUQh3/1ocxLfgOD0ATmjtxGIbMcI=;
        b=fvL4cF2v0HxKgZL4ZgW2sxwbXlICGIsxRx/WuZsgSrGRw7yonC3oEu74BVXQBpdaQ9
         L2W/QP14qsQ+wPDI98+Qk9VnF5OwqHQD6SvsZOqKGXUgATK5x6dZCWXNzU9hFJ/4g2f0
         OtSV2L97c2L37V9PdxgwWK31D+HuJZyzw8m/Vws+ykFE1UEw3JhbBMtX5Uob4AiPjA7k
         6WoqFEIfIcL/Cf6dH4sRjtNsQRXACv5sMLTrcqTk7LCJstrnAA+ADoR5QW4jw1hAcG45
         Zm59SciC1fk78Cj47Us9+BvYtU2LxgTrbyrt/tb5rtPXAgZOeMy2AQy0LkztwvEW8Ny6
         mFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614723; x=1796219523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FkHuxjNkBWcpazSUQh3/1ocxLfgOD0ATmjtxGIbMcI=;
        b=OyxG5cdgy0GAinGRVCbaOjGYsWlO+Nnpc1t0/5fIqnLvYYeNJwEfTLHVL4FSh2rThN
         Mxyu7MQpqX7hfmiq3HXhiqxiBgrTogsWbfmhxckKUn82GH0lrWBm/AxjtYWZaN67f7h7
         hGyxj9PeXAJw7QvUfhd95Po7J8tvhbHe55v4k1fvrZcEhqgxZDUx0iw9gd8Ksr3na7ki
         KhRHCmwSSUKMBZgDPvBlje2QU+nETlFqcv5Z2wcoJUQjEs1DbVwL1+EmX+mXu6gXmvXI
         5Gpf8KUE37Q/yrOvTAVcEZajEKOEIR0bpBtitykofQxOhhnwPArTq7l/rytDjKnw7XtR
         ZJyg==
X-Forwarded-Encrypted: i=1; AL+hErFojleapRRSobj9wL2K4IQgfwiEkK74YWEO21TogvYJIV4H3AK8YnaQWQ9H2+RJq7n2NVLLjw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+zjyjOqIkX04kSpkqjk3vxgQGF0fF3IeSIRxhZ0Mn9/1oig4U+
	WUUjOMNqUOvNWp40ehFvwUpp6f7eRxzFoCvLkg+UWiq2pBcZjkitgoPuUdZrRKQSKmHIURQPGUR
	sWDhl6HEXHkpOYc8R6SaKpbQ7LkMUVrY=
X-Gm-Gg: AZFdTZfO1k9+/B9bqpQWHaToCx5Kr93ek2rTus5k3IEX1tTHtO2wzfTTWHWInk5KptE
	ii3VrcRyWGTaBgSUfjxjWPvw7PDBO7jA6neMsOtwQGdBbABnz7YucOZBPmDyIeKrdxiHQv7tkSx
	DEP/E+PeR4rjdIgZS/iXN9eCvrngiW6u4h5w/oVjqKLSpOzCz+VtfLEAYsOM0b2SE5i9sRvD+0E
	Qs+02+62FS+1n5Bru86jWOMVYB7KtlvWtx4jdJI512A2NRG/swn8RGRez1Idf72wzgsBbuqGha9
	nE11jUvxhK3xj4E98De8ALbQLrarvDcY2olD3ZS5Isz1WbBlWG+cawgHzsNDmmr1b2SQSeIZokM
	gdIENfEvnL5cGUpT670cTiWILIkTasGMCkZTfNtyFlUQJmmJWJj7rzdQ8Rr4ZsM5V42lnSg==
X-Received: by 2002:aa7:d355:0:b0:6ba:3867:42c8 with SMTP id
 4fb4d7f45d1cf-6ba38674444mr9425076a12.30.1795614722953; Wed, 25 Nov 2026
 05:52:02 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-13-8ffea39934a6@tencent.com> <43abc7c4-c435-48a9-8dc2-616095105d45@kernel.org>
In-Reply-To: <43abc7c4-c435-48a9-8dc2-616095105d45@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 25 Nov 2026 21:51:25 +0800
X-Gm-Features: Aa3M54qvnrtyAcMz5ZXrISSFgrUyQOGr2UM6VAg_EqnvxKpfk2xtM5m2ePfgGd4
Message-ID: <CAMgjq7CQkhA94QxVcdHzq=DD-6LCihA+psL1n-K05sxCffBOVg@mail.gmail.com>
Subject: Re: [PATCH v6 13/18] mm/khugepaged: convert to LRU refs based
 operations for MGLRU
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 6:11=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 11/23/26 19:53, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > For MGLRU, PG_referenced is only the lowest bit of the folio LRU refs
> > count, so folios with nonzero even refs no longer have the bit set.
> > folio_pte_referenced() testing the raw bit misses hot folios at
> > refs 2, 4 or 6, under-counting the referenced folios of a candidate ran=
ge
> > and aborting otherwise good collapses with SCAN_LACK_REFERENCED_PAGE.
> >
> > Test the refs count directly when MGLRU is enabled, mirroring the
> > smaps conversion.  The classical LRU keeps the plain bit test.
> >
> > Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Tested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/khugepaged.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2dc4245814df..5e768481ac22 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -579,7 +579,9 @@ static bool folio_pte_referenced(struct folio *foli=
o,
> >               struct vm_area_struct *vma, unsigned long addr, pte_t pte=
val)
> >  {
> >       /* The folio was referenced previously ... */
> > -     if (folio_test_young(folio) || folio_test_referenced(folio))
> > +     if (folio_test_young(folio))
> > +             return true;
> > +     if (folio_check_lru_refs(folio))
> >               return true;
>
> Why separate lines?

I thought separating them would make the git log easier to track if we
changed one of them again in the future. I can change it back if it's
not helpful.

> Also, is there some way to abstract this that core-mm has to worry less a=
bout
> the details?

Let's just move folio_test_young into folio_check_lru_refs() then,
PG_young is page idles's hint for LRU, so doing that makes sense.

And with FG, I think we will soon be able to retire PG_young
completely, page idle's feed back can just call
folio_inc_lru_refs(folio, LRU_REF_MAPPED), save one page flag. But
can't do that yet, need to cover the CLRU case.
