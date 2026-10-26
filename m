Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019201;
	b=DiBUGi+FbjgeBAcLEuehCONQoTaDQksmqFAFKzdnQb7zgywOZvJDUXF0Vme1wf12J+mz
	 IE3l5a5ZIi/Hvz8wPBFvyfDz8DeJ2LQyLI5dM4tPYR1d2/QOUTY3FL//arXRRJIdeN6Fl
	 zCJzY9i0BPI+ButoPNTTA7kmq/AMj4hyybBxRnzXugKtWv1h1ih/WhmJBbvMYTThw9FN0
	 KJ1AOmipX/a2X8CQ7V+LRb7Z40dkozA7Yk8RjYzgCwR0uENiwWi5Et0hwTx8TpCMLGoqE
	 Ixs9nzzU0GiC34Hh4E2fHx6CDxikGjzuJt+O7qlkOTSOPqAUnZIU4SGt4AWrcx6GPQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019201;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VIxTiNRgypXMaqJ3sKqKWSTzccttj631MPKMikg/mfI=;
	b=jC2WplTwVV9X3jsQjkcXUWBszv8RGlm2p85C/G3pjBN3yrjUMeMMRm+ZuNaL6+FSjUPL
	 xgfiEpnWOZ4xVj72BiC72UvW8BAd/tEjBw6xJsy4Q6BI09muXSrGz2dFim9LxwgHIQu6b
	 7KOkbsMTpdTcLL8OGOPhCt1h4Hf78wJa9Q5wBS7lbwFj0VyBqjZcdmZMO0+nC1nn7KTHb
	 7gUwQ2EU4pWXI0qq4bOb5+2+FqI+Va7O3kZEeEcKNMB1EhNXjzBElxGUzXWPgi9QBCkOJ
	 Jda1YUGYpE4QPCnsEnmBfmTDdV+44rEqcjCjziIthsa3XjnERIsficOMmwAZGUFrFdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gp/6q80U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50857606A31A;
	Mon, 26 Oct 2026 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gp/6q80U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FF21F01825;
	Mon, 26 Oct 2026 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019200;
	bh=VIxTiNRgypXMaqJ3sKqKWSTzccttj631MPKMikg/mfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gp/6q80UQa7H3T+mI9Qp2Mly9TnA3bLnYUSDuIVxjJPVzooXT1imqeZ1sxvuWbIOG
	 LYVKUiqdbq7fCSyHHUCaasxU212uwFC+l8Guh7izu7tVOVGfz7y5ILaAhaBKVpzBFC
	 a8FcnusT7OWdWh8zf2VYD/mfncAaOAM1jML9Ey9nmbN09VZoqub54qzT4Z6atUX4eG
	 HsAMGyjYnmp7WTD4GFYCLrtlfcCjUsRvyYrIP9cJoB7eQeQOsmHY6LZ9TC5ineBii+
	 KueuN8O9SJSwwR3j5yjgAsM5CdCWy8/Z2qoW1lKaGMjwwZ3rScf+H5hw51T4/5Flnd
	 CzmxNfeNYudqg==
Date: Mon, 26 Oct 2026 13:53:12 +0100
From: Gao Xiang <xiang@kernel.org>
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Jialiang Huang <huang-jl@deepseek.com>, lance.yang@linux.dev,
	baohua@kernel.org, damon@lists.linux.dev, david@kernel.org,
	kunwu.chan@gmail.com, lianux.mm@gmail.com, linux-mm@kvack.org,
	mst@redhat.com, ryncsn@gmail.com, sj@kernel.org,
	virtualization@lists.linux.dev, xueyuan.chen21@gmail.com,
	Matthew Wilcox <willy@infradead.org>, xiang@kernel.org
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Message-ID: <at9NOPA2VqV54yan@MacBookPro>
References: <20260925054408.10431-1-lance.yang@linux.dev>
 <20260929123241.1408414-1-huang-jl@deepseek.com>
 <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
 <AA71E56E-F29A-44B2-B5A0-7806CD684B21@linux.dev>
 <ary5Nn9le4xG7_-N@MacBookPro>
 <CEE47F27-874B-486A-995F-E223249659FE@linux.dev>
 <arzlfSOgtC-CLoZt@MacBookPro>
 <8839b7e4-a830-4c88-9e7d-dd35757c5167@amd.com>
 <at9LyF8xIIPKcLSD@MacBookPro>
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
In-Reply-To: <at9LyF8xIIPKcLSD@MacBookPro>

On Mon, Oct 26, 2026 at 01:47:04PM +0100, Gao Xiang wrote:
> On Mon, Oct 26, 2026 at 01:35:44PM +0100, Gupta, Pankaj wrote:
> > 
> > > > > Anyway, it'd be better to get some numbers with RL or agent workloads
> > > > > (especially the host memory is under reasonable pressure) before
> > > > > landing all these new infras upstream if proceeding in this way.
> > > > At least for now, as far as I'm concerned, I don't intend to land all the
> > > > features mentioned here. The first thing I want to address is on-demand
> > > > allocation of struct page.
> > >  From my point of view, on-demend allocation of `struct page` for FSDAX
> > > is indeed useful and can be landed upstream, mainly because `struct page`
> > > initialization takes much long time for large FSDAX devices even a small
> > > range is used, that impacts the guest startup time a lot.
> > 
> > Would on-demand allocation of 'struct page' from the device itself (a
> > variant of the altmap case) solve this problem?
> > 
> > For virtio-pmem, since device memory is backed by host page cache. So, in
> > the worst case host will provide memory for all the 'struct pages', but the
> > guest itself won't OOM.
> > 
> > Just sharing this idea. Anything I am missing? It could be another
> > optimization on top of Muchun's work.
> 
> I know virtio-pmem struct page can be allocated from the device itself.
> 
> But I don't think it changes too much, since guest kernel implementation
> shouldn't imply anything of the host. So that the pmem and struct page
> can be backed by anonymous memory or other types of memory, and it can
> still cause unexpected large amount of memory on the host instead. But
> allocating on the device is sightly better than allocate struct page in
> the guest.
> 
> The problem is it's hard to make sure the on-demand allocation is always
> successful since the guest knows nothing from the host, so that it
> exposes security risks like denial-of-service or more.
> 
> If this security concern is not resolved (e.g. implement a reclaim path),
> my thought is I think we shouldn't overcommit the struct page since it's
> a functional defect if virtio-pmem is reasonably large.
> 

But I agree that allowing on-demand `struct page` allocation from the
device (rather than allocate using the guest memory) has lower risk,
maybe allowing this can be the first step to enable on-demand
allocation (actually it's not an overcommitting from the guest view
since the whole pmem memory range for struct page is reserved).

Thanks,
Gao Xiang


> Thanks,
> Gao Xiang
> 
> 
> > 
> > Thanks,
> > 
> > Pankaj
> > 
> > > 
> > > But in order to make it safe for production, I suggest reserve the
> > > guest memory in advance for the worst cases of `struct page` at the first
> > > stage, otherwise it could cause unexpected issues for many guest workloads:
> > > it's hard to perdict if the guest memory is still enough, it's unfriendly
> > > to system designers as well (that would completely based on their
> > > experience and hard to ensure the service quality beforehand.)
> > > 
> > > Since the guest memory for `struct page` is touched on-demand, the memory
> > > over-committing on the host is still workable, the memory reservation
> > > can be removed after the reclaim path is done.
> > 
