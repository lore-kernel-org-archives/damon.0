Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657A3806C6
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441446; cv=none; b=XDuV896qqX2o4ezLjBKb3LOqA07r1SldBwP8ybvLVhnD/u9IGkaSvV2SSYRSFdMH7DLkloqN49nAitV4eeVQFRhJ6Z5n9voWlVsKkEmPNRYoKdP/UpVdFnxLl0BpiE9Xlr1/0hVzoENnpEjClYd0tBcUNrXaaZTx74yUlaLPQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441446; c=relaxed/simple;
	bh=fGzDjuAvcIt9jSsrnnmZfYKA/ydyZfYEEoZeMj6ExQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0YMb6WyRtwNwatmkrvMOwZdFjxMt1dbUJRCABhniNUC2ZdYLWCbg9xP4xZgTsjz/zw1WRxmLeYmOyeanRlfOkcQ091w94oiqgQTh41/cw5ZuuQxiDC1oyMZwT6rYCUCorXTzcFxUa3i9jwjmsCvn4xJ042F/AKY6sJgISnx9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvUCuuQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvUCuuQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E691F0089C
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441445;
	bh=fGzDjuAvcIt9jSsrnnmZfYKA/ydyZfYEEoZeMj6ExQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EvUCuuQfxIVQtKdieJ/ojTw7O5oTpN+1v4wSoySeJnSQ77XhNPBL4s0Qq/Y1kunRy
	 O/1dguz4EY6tg69/ld8u0YuxKtsGscTfoE3p7hvpY29oeTAInBfr4YsW9C4LSpW/dQ
	 o+FniKL/AHjEv2g5G3bwTIAbht7mdo5l8J5i+nXwa5dKa5BmC1NhTBV5ulufIVzVX9
	 GVUoQKkCgBsmCpKp4KXyQuW2FsNpAb6Pi5BgbcfO5gqv0Q59eu3/Alp+/1nEb8AWH5
	 eJqUb/x3HgusCNWLkaE9PXVaih58QSkPAATsny3gUFg84kl8gPINK1abjlxx8KyOx1
	 Z84I6M8uqEUcQ==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158c621ebbso18130285a.2
        for <damon@lists.linux.dev>; Tue, 02 Jun 2026 16:04:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ//XwJtDc0zRJh5h5G+Vlukr62uxf5ikO2zirQYNsxucaAwziPqB+9cBv8guSFryWg7HZjz0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoFM76gyZDRQ+CGKpsDWaWAJFkjtBrV/KX1glPmdzAmZ7E1w8Z
	cvUf0yTLUhNB2K21laqUgwTw1LrzQyp+4Lj9D5xKmGZzEdpu1FImfkYyp/gahZhfyAjhpQjrXhQ
	Vpile2Th54pYVA1DE/HTRLO25FTG8GNA=
X-Received: by 2002:a05:620a:25cf:b0:912:8fd0:4a5d with SMTP id
 af79cd13be357-9158a8430eamr187006285a.55.1780441444405; Tue, 02 Jun 2026
 16:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com> <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com> <ahlzj--3Gm5pD9ge@lucifer>
 <a90bcb0fa3a044588350e92a78258a09@honor.com> <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
 <2e9175ab-f9be-44c6-bf1a-a82aeed18f98@linux.dev> <ah71gjj21rLIuTnb@lucifer>
In-Reply-To: <ah71gjj21rLIuTnb@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Wed, 3 Jun 2026 07:03:53 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yKtEnCEyLVpzKUNDDw0AwttnFhB7c1sicBpjecBxATQw@mail.gmail.com>
X-Gm-Features: AVHnY4Khgdh1OvPc32I3tWzQ7qSOu8BOGvT2qrR5LpDulZJiDfW5EMOXKL2Djq8
Message-ID: <CAGsJ_4yKtEnCEyLVpzKUNDDw0AwttnFhB7c1sicBpjecBxATQw@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, 
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
	"xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
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
	"dvander@google.com" <dvander@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:37=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Tue, Jun 02, 2026 at 10:46:35AM +0800, Lance Yang wrote:
> >
> >
> > On 2026/6/2 10:15, Barry Song wrote:
> > > On Mon, Jun 1, 2026 at 9:46=E2=80=AFAM wangtao <tao.wangtao@honor.com=
> wrote:
> > > [...]
> > > >
> > > > You said discussion was welcome, yet when someone offered even a
> > > > small comment, you refused to continue the discussion.
> > > >
> > > > If I had known you would be this inconsistent, I would not have
> > > > replied to you in the first place.
> > > >
> > > > This will be my last reply to you. I will not respond again.
> > > >
> > >
> > > Hi Tao,
> > >
> > > Please don't walk away from the linux-mm community. I read your
> > > patchset and found it quite valuable. It not only reduces memory
> > > overhead, but also eliminates rmap costs for exclusive folios.
> > >
> > > Since I'm not very confident discussing technical topics in English,
> > > I wrote a blog post in Chinese about your patchset:
> > >
> > > https://mp.weixin.qq.com/s/k00tzhTl8HbL3k4G6ev4SA
> > >
> > > I have to admit that I found the implementation quite complex and
> > > in need of significant improvement. However, I think the underlying
> > > idea is very interesting and worth exploring further.
> > >
> > > I'm looking forward to seeing a v2 RFC with a cleaner and simpler
> > > implementation while preserving the core concept.
> > >
> > > Regardless of whether it ultimately gets merged, I hope the discussio=
n
> > > can continue.
> >
> > Same here :)
> >
> > Tao, please don't let this thread get you down. No first RFC is
> > perfect, and the idea still looks worth discussing :)
> >
> > Thanks for working on this!
>
> Guys, this isn't helpful.
>
> We aren't extending anon_vma, and I am working on replacing it, that's th=
e
> bottom line.

Not trying to challenge your bottom line. As explained to Harry, I
have no doubt about your expertise in rmap and many other mm
areas, and I deeply respect your work on rmap.

With more discussion, we might gain additional insight and
inspiration. What Tao has inspired me with is the idea that if we
assume most real-world processes are leaf processes, could we
simplify parts of the design?

This is why I suggested a v2, to improve the clarity of the cover
letter and make the code easier to understand, and to see whether
there is something worth considering further, even if it is not
suitable for merging.

>
> I have presented compelling evidence suggesting this is AI generated. In
> response I got more AI-generated nonsense. There's no trust, the code and
> analysis are all wrong, end of discussion.

I am not an AI expert, and I do not really use AI in kernel work,
so I am not really sure what counts as AI versus non-AI. Sorry.

>
> >
> > Cheers, Lance
> >
>
> Thanks, Lorenzo
>
> P.S. maintainership is utterly thankless, and I don't really expect much =
in
> return, but honestly reading this, given the case I've made here, was
> really quite disappointing.

Understood. I see your position, and I personally have great
respect and appreciation for your work on maintenance. Sorry if
my words came across as disappointing.

Best Regards
Barry
