Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47773A963C
	for <damon@lists.linux.dev>; Sat, 30 May 2026 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140505; cv=none; b=HcBaiy0r6tQzzuRpMF8hwGCdWUBlkBCksrcB0SNriegPKugH+Djgjjo/5igthLaaZSVaFhLmfGI4Fmj88SpniX6rInvLMGUU8Q0YHTKkhQCLcAx/tzH09JHn8S0SBG7SxDyYQIWIz8ptG+vOrSHHFFuD/rFMH4rOBD7waflz0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140505; c=relaxed/simple;
	bh=eNVjiDtoALomYsclT0hUpRMM3pr0rt7mXonemwgAJbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liQoyN+1QeCowO1u+CKLGzK6dRH2tx2dwN4KFtvKCc4gyCdB2GSA+kQWSn6GUA7xhdXtL5R0/2SWfaBL3lbul3m+auUKXR4nhyDjH7VefuQ5BpeX37X+eJdq2hHwMkq3obZMBSVtc52VEY6u+7kC27Ms29Aiwi9kN1WVmpuqW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDIWChJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDIWChJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A36E1F008A0
	for <damon@lists.linux.dev>; Sat, 30 May 2026 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780140504;
	bh=sq2iLDCXi6pDren51u1cQUzgAX9nwmLUuBb8+qFvt4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JDIWChJZ5HBvxKRLY86aQ4mCtPB3mchD3+6j9CO4V3Zfldriy00F20T5l3/KrTzEY
	 4iR2RT0/j4sFVS1dQZ/Kbkfjh+fEolP841WKNsjUJFg8pH7aW7wVjF2094d8vdd0yT
	 HfLx9I2ayMHn6z3e0AlbCQldDW0lN2gN+c90HvIUP+7aJ7IsKwQGIOKBSeqTjRsoBI
	 ko7ERB7kigumw4pkHRSD43tDFRqmRP5JBD5hbwk+j2P9SMScEXjdbJq2rCbpw0pIli
	 7OftayBRqrL6XlN3WhscSpvzvxc1T1f7oK8QNIhax3GHkFLgbDcsu2J8qGGruoUQ+p
	 p14DeXvsONWtg==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91541fa94aaso59822885a.2
        for <damon@lists.linux.dev>; Sat, 30 May 2026 04:28:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8cd2bqqPCMtVqpBFLZaXsEw4+sXH+Z3mpXLnCeIcoacF8XSNKXTTdyu7uTqqX1+tf0epL75w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfcjM8SKu3aq24C6UUZFv2s+9ayDMZzlSEJx+UKxpo6XMweAlC
	qJLZVxU60LfsICFRifpOco1MiCf3PGwMv4YucodyZqMFQZ/T7zHnwdaQ14R494b3n3Uu2fXKQE7
	TH8ntImEmYLSVKYkXdzkCa1/DVNbG/tc=
X-Received: by 2002:a05:620a:45aa:b0:914:c246:ac9d with SMTP id
 af79cd13be357-9153d9f76eamr544656885a.28.1780140503550; Sat, 30 May 2026
 04:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com> <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <87qzmu2r0t.fsf@trenco.lwn.net> <ahmzXSN_sQYmq2Jp@lucifer>
In-Reply-To: <ahmzXSN_sQYmq2Jp@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Sat, 30 May 2026 19:28:12 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yDek3neUQ_Le8nWr1XA7YrqZDKXZJX+u5f9kvv9=d0vQ@mail.gmail.com>
X-Gm-Features: AVHnY4LYmPGlt-SyUQzP7ovTfzzfgSTVLh1_UKbg7JbyXYbDT08n9Dn5EUIKOuU
Message-ID: <CAGsJ_4yDek3neUQ_Le8nWr1XA7YrqZDKXZJX+u5f9kvv9=d0vQ@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, wangtao <tao.wangtao@honor.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org" <liam@infradead.org>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:40=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> w=
rote:
>
> On Fri, May 29, 2026 at 09:07:30AM -0600, Jonathan Corbet wrote:
> > Barry Song <baohua@kernel.org> writes:
> >
> > > After coming back from Zagreb, I kept trying to find one or
> > > two full days to read Lorenzo's code and slides carefully and
> > > write a blog about them. Unfortunately, I have been completely
> > > busy with other work. Sigh... we always seem to have too many
> > > non-upstream tasks.
> > >
> > > If possible, I'd really appreciate it if you could take a
> > > deep dive into it and write a detailed blog post. I'd be
> > > very eager to read it and better understand the overall design.
> > > Otherwise, I'll try to find some time next week or later to
> > > go through it myself.
> >
> > It's still somewhat superficial, but in case it's helpful:
> >
> >   https://lwn.net/Articles/1072378/
> >
>
> I found it to be great as usual :)

+1
Thanks very much, Jon. That's really helpful.

>
> > jon
>
> Cheers, Lorenzo

Best Regards
Barry
