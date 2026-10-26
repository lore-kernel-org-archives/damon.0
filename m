Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018832;
	b=Z71QbO4BeymBqwprl2zdg9xzcPL3RyPI3E8CJMvEOHjwVBsBsguae5xFjLKZIXwG7EDg
	 ERuLfe9XZCpDt3VlN2iXmn3GjKs4DgG3LNHvKh/1hyOE7kc8WLZUW0b6mIWioqzLM4AM3
	 nSlVWHfGdkErmMDV4JO/E+xayMa2dQCsPBhLL4xTG3QVsMWmeJDVMYP/dHP9jZwhSnlU7
	 6qxagMD2yoK0D9s9XOikUVqmG5u3n1D66diucfdSvlgYZ0YWtl3uPFUhoTCr1pDxiS7Qf
	 vof0aMGBm27QKj62yGmxF0YWBStk3ZUJ1XwKu11v7NzhaA+16e5xb4b9B4tY+Th5skA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018832;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MY2/oE50ls4sLwiugB1GPOFn3VQZXmVjO2YcQdI0xoI=;
	b=jBtT7cwOnkWKMlxWh/VzC6hpqwZZyg8e6jrtJeMTbV+1eUid0fPXzs5DfgrXoc7Frs4z
	 S6Vcy4Pu8aXgM6LVSM6EjGlCMJ9GFsgL9zGbixAbh8UOewd/kQVI5P67Z5oMOBM1tkiNb
	 fYd0sxUM+Ju2PDDyvk4HFJIxV8+jQHnACr2JbrhN7yH9cn0Pp0N0yz48VOZTuWAKqFq7o
	 cSHTT4j15hg39lAmBy57JU1dWLHk9QDs3zPuph4SPnLExnw2VEBob9k4gfVJ2ZonVpoyB
	 QhF5bZ+k5Md1VKBqAc4qNuuBgDOrxXkM9sR178vZYalT0dCHJ1kXbNhJIjV/TGBzuBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dletiwOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60303606A31A;
	Mon, 26 Oct 2026 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dletiwOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827C71F01825;
	Mon, 26 Oct 2026 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018832;
	bh=MY2/oE50ls4sLwiugB1GPOFn3VQZXmVjO2YcQdI0xoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dletiwOFnOAhUfZUv/7sYjo6kF9eaUxqjsksJHXSMeKqcpQWaT0h1QOTA0PmDAcWo
	 AvMFrGqvq0Dj0apCyec6s3Ke0TvPipmjBslg3NkwHFrqXqOnY0poDJ1Irs51nNWRPn
	 H6Ep82aiaisWDf1WCH9j2UyTBkD28NJxUDvvkJ9oYn0cCTQD9v2T0/EZUTYWTSgNuz
	 JeCWEW//Jfl5osw6NZssDeV9zDDCpYXpMvL1YORr01lHhsdjsR1OcyQKXhox4us3XP
	 xbPAQ5qS87JrgMvFMZ+/Clu1YRDV3mcYpkiUZghMK9W9bAeGEFzZ+vYqDDcdE6mKM5
	 4L5HTBHkBWNNw==
Date: Mon, 26 Oct 2026 13:47:04 +0100
From: Gao Xiang <xiang@kernel.org>
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc: Gao Xiang <xiang@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Jialiang Huang <huang-jl@deepseek.com>, lance.yang@linux.dev,
	baohua@kernel.org, damon@lists.linux.dev, david@kernel.org,
	kunwu.chan@gmail.com, lianux.mm@gmail.com, linux-mm@kvack.org,
	mst@redhat.com, ryncsn@gmail.com, sj@kernel.org,
	virtualization@lists.linux.dev, xueyuan.chen21@gmail.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Message-ID: <at9LyF8xIIPKcLSD@MacBookPro>
References: <20260925054408.10431-1-lance.yang@linux.dev>
 <20260929123241.1408414-1-huang-jl@deepseek.com>
 <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
 <AA71E56E-F29A-44B2-B5A0-7806CD684B21@linux.dev>
 <ary5Nn9le4xG7_-N@MacBookPro>
 <CEE47F27-874B-486A-995F-E223249659FE@linux.dev>
 <arzlfSOgtC-CLoZt@MacBookPro>
 <8839b7e4-a830-4c88-9e7d-dd35757c5167@amd.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8839b7e4-a830-4c88-9e7d-dd35757c5167@amd.com>

On Mon, Oct 26, 2026 at 01:35:44PM +0100, Gupta, Pankaj wrote:
> 
> > > > Anyway, it'd be better to get some numbers with RL or agent workloads
> > > > (especially the host memory is under reasonable pressure) before
> > > > landing all these new infras upstream if proceeding in this way.
> > > At least for now, as far as I'm concerned, I don't intend to land all the
> > > features mentioned here. The first thing I want to address is on-demand
> > > allocation of struct page.
> >  From my point of view, on-demend allocation of `struct page` for FSDAX
> > is indeed useful and can be landed upstream, mainly because `struct page`
> > initialization takes much long time for large FSDAX devices even a small
> > range is used, that impacts the guest startup time a lot.
> 
> Would on-demand allocation of 'struct page' from the device itself (a
> variant of the altmap case) solve this problem?
> 
> For virtio-pmem, since device memory is backed by host page cache. So, in
> the worst case host will provide memory for all the 'struct pages', but the
> guest itself won't OOM.
> 
> Just sharing this idea. Anything I am missing? It could be another
> optimization on top of Muchun's work.

I know virtio-pmem struct page can be allocated from the device itself.

But I don't think it changes too much, since guest kernel implementation
shouldn't imply anything of the host. So that the pmem and struct page
can be backed by anonymous memory or other types of memory, and it can
still cause unexpected large amount of memory on the host instead. But
allocating on the device is sightly better than allocate struct page in
the guest.

The problem is it's hard to make sure the on-demand allocation is always
successful since the guest knows nothing from the host, so that it
exposes security risks like denial-of-service or more.

If this security concern is not resolved (e.g. implement a reclaim path),
my thought is I think we shouldn't overcommit the struct page since it's
a functional defect if virtio-pmem is reasonably large.

Thanks,
Gao Xiang


> 
> Thanks,
> 
> Pankaj
> 
> > 
> > But in order to make it safe for production, I suggest reserve the
> > guest memory in advance for the worst cases of `struct page` at the first
> > stage, otherwise it could cause unexpected issues for many guest workloads:
> > it's hard to perdict if the guest memory is still enough, it's unfriendly
> > to system designers as well (that would completely based on their
> > experience and hard to ensure the service quality beforehand.)
> > 
> > Since the guest memory for `struct page` is touched on-demand, the memory
> > over-committing on the host is still workable, the memory reservation
> > can be removed after the reclaim path is done.
> 
