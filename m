Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398FC8BEC;
	Tue, 21 Jan 2025 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484267; cv=none; b=dIwFWQWf4ToeSUxOUcecGlLOL2IHZ89mcarARnws5zn+GL5l4u1S0+O5f6p+QERmrT34T1QyJVANEHeVQH5KMXAvBl+iHYdLme+YoryMabMGjOGtQYfsWK4kxLK39+SQhEXoNNLQhsgfOxXpyFu8aWzUH/cmWpmbdiJZMpQq5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484267; c=relaxed/simple;
	bh=3QK29OxTAWfOE3Bh19Uk+uWELwGskeUDh7NhxreP0gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=he2QtCtkKMD2ZQisiKckdKJ2lw/mft40rd8kobwSQaNHUcYqCx9OX1qM0O04hO8SK318SJvTbBLqgaWG0Aepc67R/hivbLyt+Wa6qQEZWkFvhgPSje25JhY3Vqo+8EuYTe6QM8MdM6vCc7K7QmlC++iPvGljLQLv5+7KEsZoBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZE0klih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZE0klih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E629C4CEDF;
	Tue, 21 Jan 2025 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737484266;
	bh=3QK29OxTAWfOE3Bh19Uk+uWELwGskeUDh7NhxreP0gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZE0klihaNkrx0B0f7zUZtcZg98jjQgFzow5JKwqwz/0cuWIxKdqJn6yAhqfUzxsA
	 IH6+mTJ5HhG++fj5iZNinJAHeTMoWpdEIx6okj5yZc7aGzgku4XIdt2BAnvovlaFEm
	 ryZsA3ZP8Jea/rthmYoXkH8r5ivXZTMwtyQ9PzkFTZiurNZTOCZxeNbWRx2iwEjqzU
	 8nCB0X7T+w8LICiJRw8fiWSCRIavsT/Xz6BvjQyzW4Dz4nEh+VedG0gYe8VwP82JRL
	 qlOFTxLXtz/o0mO1NjOiPtj9+3VrsaliqIAp4h1yTSviUT2NBoG5nJG4bjC9fakPtx
	 eC0DU6NUiq7Bw==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Monitoring Parameters Auot-tuning and Memory Tiering
Date: Tue, 21 Jan 2025 10:31:03 -0800
Message-Id: <20250121183103.42877-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250121100145.0000398a@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

On Tue, 21 Jan 2025 10:01:45 +0000 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu,  2 Jan 2025 14:23:17 -0800
> SeongJae Park <sj@kernel.org> wrote:
> 
> > Hi all,
> > 
> > 
> > We started sharing and discussing DAMON's current status and future plans from
> > LSF/MM/BPF 2023.  Thanks to the constructive feedbacks from the discussions, I
> > believe DAMON is continuing the evolution in right or at least not
> > controversial directions.  To continue getting the benefit and avoid it becomes
> > an unexpected "demon" in early stage, I'd like to share and discuss followup
> > updates and new plans for DAMON once again on LSF/MM/BPF 2025.
> > 
> > Major topics and currently expected materials to share on the session include
> > below.  Of course, some changes could happen.
> > 
> > First, followups on work items that we discussed on last LSF/MM/BPF.
> > 
> > DAMOS auto-tuning based tiered memory manamgent.  No many progress has made so
> > far.  But I recently gained an access to a tiered memory system, and setting up
> > test environment.  Hopefully I will be able to share early RFC implementation
> > and evaluation results by the session.
> > 
> > Access/Contiguity-aware Memory Auto-scalging.  No progress has made so far,
> > too.  I'm pivoting this into reliable huge contig memory occupation
> > mechanism, though, since it is smaller scope that we can make faster.  It can
> > also be used for not only memory hotplugging based auto-scaling but also
> > contiguous memory allocation.  Hopefully early evaluation of a part of the
> > work, probably access-aware partial compaction, will be shared by the session.
> 
> Hi SJ,
> 
> I couldn't immediately identify the huge contig memory occupation mechanism proposal
> in last year's slides. Perhaps a brief summary here?

The idea is (too) briefly described on slide 45.  Thank you for asking more
clarification.  The idea is to proactively and gradually occupying contiguous
memory regions starting from cold ones, and then use the occupied huge contig
region for other relevant use cases such as contiguous memory allocation pool.
For example,

1. Find 1G coldest region of the memory that not yet occupied.
2. Find 2 MiB coldest region in the 1G region, and try alloc_contig_range() it.
   If alloc_contig_range() succeed, keep it until other kernel components (in
   this example, contiguous memory allocator) ask it.
3. repeat 2 until the entire 1G region is occupied.
4. repeat 1-3 if more 1G contig regions are needed.

For more advanced implementation, we can also do 1-3 in parallel, set the
occupying candidate nearly-located, let limited number/size of holes in the
contiguous occupied regions, etc.

> 
> > 
> > Please refer to last year LSF/MM/BPF slides[1] for details of the above two
> > projects.
> > 
> > And new projects that currently in their early stages.
> > 
> > Page level properties-based access monitoring.  We are extending DAMOS filters
> > that works in page level properties to further be useful for monitoring
> > purpose.  RFC patch series for the essential part[1] is already available, and
> [1] seems to be last year's slides?  Was that your intent?

No, that was not my intent, sorry.  The latest version of the patch series is
available at https://lore.kernel.org/all/20250106193401.109161-1-sj@kernel.org/

It is also now merged in mm tree.

> > user-space tool support[2] is made.  By the session, hopefully the patch series
> > will be merged in mm tree, and I will be able to share followup plans for
> > making it more lightweight and useful.
> > 
> > Extending DAMON for memory bandwidth monitoring.  We aim to extend DAMON to
> > support not only access pattern snapshot generation, but more general access
> > pattern information, like memory bandwidth usage.  I expect only rough idea
> > will be shared on the session, to make early alignemnt of the future shape, or
> > abortion.
> 
> 
> Where does this fit alongside hardware aided solutions (resctl  - MPAM on ARM,
> similar stuff on x86?)  Idea to do it at sub process granularity?

I have no good answer at the moment.  I need to further research.  Hopefully I
will give you a better answer by LSFMMBPF.

> What are the use cases for that?

It is a very early stage, but I'm thinking about using it for helping CPU
scheduling, and page migration.

> 
> One other topic, can we differentiate read access from write accesses?

This is one of DAMON's todo item.  Actually there were non-public requests to
implement this, though unfortunately it was not prioritized so far.  There is
also an RFC implementation that uses soft-dirty mechanism:
https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@gmail.com/

My current plan is to use PROT_NONE page faults or AMD IBS-like features
instead of soft-dirty.

> The promotion costs for the two may be somewhat different if we can keep the
> old translation live until the copy is in place for read only. Taking that
> into account in promotion decisions may be useful.
> 
> Being able to track separately is one thing the hardware tracking units
> do well subject to tracking resource constraints.

Agreed.  I'm planning to play with AMD IBS in specific.  I may start from
PROT_NONE page faults first for early prototyping, though.

I will try to share an RFC prototype, or at least more detailed design by
LSFMMBPF.


Thanks,
SJ

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Please let me know if you have interest in status of other projects that I
> > shared on last LSF/MM/BPF session or somewhere else.  Depending on that, the
> > topics and time portions can be changed.
> > 
> > Note that I proposed[3] yet another LSF/MM/BPF topic for DAMON.  If both are
> > accepted, please schedule this one before the other one.  I believe this
> > session can make the other session deduplicated and faster.
> > 
> > [1] https://github.com/damonitor/talks/blob/master/2024/lsfmmbpf/damon_lsfmmbpf_2024.pdf
> > [2] https://damonitor.github.io/posts/damon_sz_filter_passed/
> > [3] https://lore.kernel.org/20250101222039.74565-1-sj@kernel.org
> > 
> > 
> > Thanks,
> > SJ
> >
