Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF826277029;
	Mon, 23 Jun 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697406; cv=none; b=oAJ5cMGcbSMBlsb/72m6CXpo+gJKd6m9JBCG5kjgpzDZviYC0PPRRcEiguKwX23rRCzfORfwR7wCqjNlN+c0iALN4KUrnO5v9+Rg8XYJNAEiNSIJYKr3Vrx1lcmvKELwiy+6tjnR3r7REbtAC1VTrGe0lsPSu3AzVksHSH16gmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697406; c=relaxed/simple;
	bh=ixzNiYvSohABEP65EJQJpxD1tvXomrgSMaFRGU3G4rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G++isjDGC+viRIMOJQyY6CdDAYTBuIl835axVH5x5fl9c33dm0cpYbvjUs+YG8tSRJyLHWp7RR0u/jXs9K5+ntEw1be0Y8Lc5RGe2v4VwDR4S3zKMqnq5C9X9flAVNBQSOJxhdjIEQr4dYIv/2kwIhmsjWMLRe7pMla4Mrec+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSkFswit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSkFswit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BE3C4CEEA;
	Mon, 23 Jun 2025 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750697406;
	bh=ixzNiYvSohABEP65EJQJpxD1tvXomrgSMaFRGU3G4rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSkFswit9LNxWkHNZYRaVCPYGDIC4iLRpVVVwTIJo/1jVx/Kh4FPassaWhLJBLYbF
	 fMk8Wn0unQumPpjSqdYdOBBiJYVoAzvZdfWRQqv9EjSAx5Upbid6JWDW56KZu73foU
	 ha24bwGZLbCq/KhjnMM7ag4/nfxS7L3H+6HVaql+v4EmAaGfPg0Hv+AXqMKCiDJIUT
	 2v9c6ShuwW+DG63DNnh/ZRSCUtLTexj7M/9bT0Un+fx0T/EFxiZ3cdnZbCv3IsIDZd
	 X/8726K3K7T4d5IZpkXfG76TZ5RaKy+6zHWp3M0rnPCbVPFJ9ynTaoVYEB+rpNLZhR
	 LEaO5vymAty/A==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
Date: Mon, 23 Jun 2025 09:50:04 -0700
Message-Id: <20250623165004.43394-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623140808.2479244-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 07:08:07 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Sat, 21 Jun 2025 11:11:27 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Sat, 21 Jun 2025 11:02:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > [...]
> > > I'd hence suggest to implement and use a simple weights handling mechanism
> > > here.  It could be roud-robin way, like weighted interleaving, or probabilistic
> > > way, using damon_rand().
> > > 
> > > The round-robin way may be simpler in my opinion.  For example,
> 
> [...snip...]
>  
> > Actually, probabilistic way may be not that complicated.  Maybe we could to
> > below here.
> 
> [...snip...]
> 
> > But damon_rand() might be more expensive than the roud-robin way, and arguably
> > roud-robin way is what usrs who familiar with weighted interleaving may easily
> > expect and even prefer?  I have no preferrence here.
> 
> Hi SJ,
> 
> If you have no preference here, I would like to add some thoughts : -)
> 
[...]
> I think that code complexity aside, round-robin may be the better choice for
> a few reasons. Like you mentioned, I think it is what users might be used to,
> if they are coming from weighted interleave code. Also, I think a round-robin
> way will prevent worst-case scenarios where we get a long stretch of allocations
> on the "wrong" node (but maybe this isn't a big deal, since it is so unlikely).
> 
> Finaly -- If we run workloads with mempolicy wet to weighted interleave
> *and* with the weights already set, then pages will be allocated in a
> round-robin fashion. I think it may be best to try and minimize migration costs
> by trying to keep these weights in-sync. That is, if we have a 2:1 ratio,
> we will have the following allocation:
> 
> node0 | oo oo oo oo oo oo oo ...
> node1 |   o  o  o  o  o  o   ...
> 
> Using a probabilistic migration, it might change the pattern:
> 
> node0 |   oooo oo o ooo oo ...
> node1 | oo    o  o o   o   ...
> 
> That is, the ratio might be preserved, but we may be doing unnecessary
> migrations, since a probabilistic allocation isn't aware of any underlying
> patterns. With a round-robin allocation, we have a 1/total_weight chance that
> there will be no additional migrations, depending on where the round-robin
> begins. I also want to note that weighted interleave auto-tuning is written
> to minimize total_weight.
> 
> I'm wondering what you think about this. Perhaps there is a way to know where
> the "beginning" of round-robin should begin, so that we try to keep the
> allocation & migration pattern as in-sync as possible? I have a suspicion
> that I am way over-thinking this, and none of this really has a tangible
> impact on performance as well ;)

The theory makes sense to me.  I also not very sure how much visible difference
it will make on large scale real workloads, though.  Since at least the theory
makes sense and we show no risk, I think taking the round-robin appraoch would
be a saner action, unless we find other opinions or test results.

> 
> Thank you as always SJ, have a great day!!

Thank you, you too!


Thanks,
SJ

[...]
