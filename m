Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F4261376
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230761; cv=none; b=PMZXITLbPKuPIzvkfDKVjdZt2W7YOjH6O+1oU39w4N32VKpfFd21L25ZJntXD1Fi35DKAT1TlwoJY3XkJWQnNhpNzXakHnTbIxnhscwQzUXm1CPTW/iczqIDHDAiWp6s9bLEVwOdCXI3R6bGqUADf6SiPJkInr3As7xitn2Mmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230761; c=relaxed/simple;
	bh=XtC1lnaFlsxPJJUHriOWePwP8yBTmLkmhQe6ny+9TZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enyxpP0ePtn43VNmurpnbv3QRJrTbIlcaAF9tNxR0hNz8wBfR4Oml8YfH1AOEo+c1oh4G4QTPWaieOcwBjpkLFT8RPA5cMJbf01MpAQcFzfUwS7oo2lhripwhPNXKp4af1uL+GcEYrLedl/NY06/N+BIRYjtcsyna8M4j6iOzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO7j7+ya; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO7j7+ya"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c4c9349b3so1320616241.3
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739230758; x=1739835558; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4J5WV+6IR7+S2waApgF1qBwpbiN//GCbixakjmicks=;
        b=RO7j7+yaDSnA1+g5HbZJPA8H3eMtq7KVl2OX61h4X2qKZ5GOaiBUilPN2xTL9gUvZU
         y8IEgE6vMlnEWBhFjFOFNpEkZv4QN6rM7g9LpcLw1y3B/Ywn9xm7j3I6z2RCW/77FEyP
         7oH1rH9ZOTei7FM8FM1W+aHy5GHv87ixeqMw2nnoHIP/o+hQbFnXZpGxQ7AqpVbylCO6
         nL6HayDj0Xm9LUHUfMlMWXEsQGgc0/AmkiIjZ0gDTfzJMmxolKD3Lx2G7yyiSDGLZyYf
         RKrXTL7Yl4NdohOkTvBsPCAbdFPdMTPSpLbsl24TEuxAOQPle8r49YJdL0kBbtNz+CJX
         gX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739230758; x=1739835558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4J5WV+6IR7+S2waApgF1qBwpbiN//GCbixakjmicks=;
        b=gCT2NyUFZHxNoYz6/gNClp9ipVMgncEVEmzMQOZ8RYFuXyJUtv6AimBQMP7UVvibGY
         veGi7CnbAKlx6rjTbLuNz3LljaVJBjQlw6Vv1wdpI063CewlRuxxqsA6JhVyUe1iZl+J
         jjflk+orfItEL/F/f0OWVYRo7FAazj56sjF+qgQNxxmW9STqJNP7utJ+ig/rIHtzR0BI
         B9iQqLkjIJyRfW7qmbTCay/aVkhVwFHX5C2DogiNVKgd+nvbF2z9WkxC7RKDQVSNPweB
         jZfyG3751HPaQ0OePqVbLXPyYHk1780s8Kvu0K2jTmFISqtTdvA0cNuLTsyr4rM5LR7b
         X7cA==
X-Forwarded-Encrypted: i=1; AJvYcCXd6159BYv13UtARIkwMq0EZKjisUqN/WK6TzMOQ4wV6vAIxo++DgcaK8Pi6sFAL3HUy3mmhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1IJgkWV533ySTHgXX+As5oN6tJTcZxHa0YfwooTlhUvtwwMSo
	TIyLnlAVLE5UG0KMIRsdGnPwqs7cS1AjW4YCZVXrYM7U4QuA848CwWZ86lMtr4Lbmt5VrW8dUSQ
	uQB3EO8fhCcKsg/jXDNkXJFxJqsi3iHN/
X-Gm-Gg: ASbGncsTjxoVA4l9BlimphcwyAWdTtnijw1CAAmD/HfGofAwnOtFtAud3huedfSKs61
	/h/jU887CILw/OzC5XOtSBNx92AeiLR38jhCJEA5sZPiTl/z5voo/J4nk/dVrZWerZr8cPrxUPF
	bUA/RHubUoqyrpw16FFDOjWOMgGOaekSQ=
X-Google-Smtp-Source: AGHT+IEzfy3CbplemS9WcnlHDD6MpmxCskJpVqC7I5+Y9/ioGIApBpWu1Deqy+MADOJ9mj0OMU6KQgcPeg0LuaokY6w=
X-Received: by 2002:a05:6102:2b88:b0:4bb:ba51:7d48 with SMTP id
 ada2fe7eead31-4bbba51806cmr4870296137.5.1739230758203; Mon, 10 Feb 2025
 15:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210193801.781278-1-david@redhat.com> <20250210150515.c71078f212ff4661eafc15bf@linux-foundation.org>
In-Reply-To: <20250210150515.c71078f212ff4661eafc15bf@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Feb 2025 12:39:07 +1300
X-Gm-Features: AWEUYZmxTQri2-Cf24uNq3e2oUES2a1ywMTPcjyR3D9qOdCEqwTj81M6L3Eziec
Message-ID: <CAGsJ_4yVkJdKejof1CxJY1hkUSsQ-ziRzCTp9CBXdBJ-4d1HHw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] mm: fixes for device-exclusive entries (hmm)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mm@kvack.org, nouveau@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	damon@lists.linux.dev, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, SeongJae Park <sj@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Peter Xu <peterx@redhat.com>, 
	Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:05=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 10 Feb 2025 20:37:42 +0100 David Hildenbrand <david@redhat.com> w=
rote:
>
> > Against mm-hotfixes-stable for now.
> >
> > Discussing the PageTail() call in make_device_exclusive_range() with
> > Willy, I recently discovered [1] that device-exclusive handling does
> > not properly work with THP, making the hmm-tests selftests fail if THPs
> > are enabled on the system.
> >
> > Looking into more details, I found that hugetlb is not properly fenced,
> > and I realized that something that was bugging me for longer -- how
> > device-exclusive entries interact with mapcounts -- completely breaks
> > migration/swapout/split/hwpoison handling of these folios while they ha=
ve
> > device-exclusive PTEs.
> >
> > The program below can be used to allocate 1 GiB worth of pages and
> > making them device-exclusive on a kernel with CONFIG_TEST_HMM.
> >
> > Once they are device-exclusive, these folios cannot get swapped out
> > (proc$pid/smaps_rollup will always indicate 1 GiB RSS no matter how
> > much one forces memory reclaim), and when having a memory block onlined
> > to ZONE_MOVABLE, trying to offline it will loop forever and complain ab=
out
> > failed migration of a page that should be movable.
> >
> > # echo offline > /sys/devices/system/memory/memory136/state
> > # echo online_movable > /sys/devices/system/memory/memory136/state
> > # ./hmm-swap &
> > ... wait until everything is device-exclusive
> > # echo offline > /sys/devices/system/memory/memory136/state
> > [  285.193431][T14882] page: refcount:2 mapcount:0 mapping:000000000000=
0000
> >   index:0x7f20671f7 pfn:0x442b6a
> > [  285.196618][T14882] memcg:ffff888179298000
> > [  285.198085][T14882] anon flags: 0x5fff0000002091c(referenced|uptodat=
e|
> >   dirty|active|owner_2|swapbacked|node=3D1|zone=3D3|lastcpupid=3D0x7ff)
> > [  285.201734][T14882] raw: ...
> > [  285.204464][T14882] raw: ...
> > [  285.207196][T14882] page dumped because: migration failure
> > [  285.209072][T14882] page_owner tracks the page as allocated
> > [  285.210915][T14882] page last allocated via order 0, migratetype
> >   Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO=
),
> >   id 14926, tgid 14926 (hmm-swap), ts 254506295376, free_ts 22740202377=
4
> > [  285.216765][T14882]  post_alloc_hook+0x197/0x1b0
> > [  285.218874][T14882]  get_page_from_freelist+0x76e/0x3280
> > [  285.220864][T14882]  __alloc_frozen_pages_noprof+0x38e/0x2740
> > [  285.223302][T14882]  alloc_pages_mpol+0x1fc/0x540
> > [  285.225130][T14882]  folio_alloc_mpol_noprof+0x36/0x340
> > [  285.227222][T14882]  vma_alloc_folio_noprof+0xee/0x1a0
> > [  285.229074][T14882]  __handle_mm_fault+0x2b38/0x56a0
> > [  285.230822][T14882]  handle_mm_fault+0x368/0x9f0
> > ...
> >
> > This series fixes all issues I found so far.
>
> Cool.
>
> Barry, could you please redo your series "mm: batched unmap lazyfree
> large folios during reclamation" on top of this (on top of mm-unstable,
> ideally).

Sure. Thanks for letting me know.

>
