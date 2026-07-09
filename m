Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41ED38D40A;
	Thu,  9 Jul 2026 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783557482; cv=none; b=oohXT+Qxbn+uIVH3iWSy6W+wWj2kQBse0ZN/NcuZxOIakSNBDJAOwwV/ibsA8JORb1wY0KzCwix8i6oBjzeqex+3JH4dmdvuf4pNXORbMUEA3H7xqjfq419wdBci+86Tv3Jh/qa7u08T/+mSQOzHX74G55SUQlQ1QVYOUeKN/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783557482; c=relaxed/simple;
	bh=k5oxB/eI5GE2ArMxC7XCF1MOWxwhuSZy7jCE4hIoX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/qRXHfdSGLKX/HjtV1lsB1BVpdTatLanGNo7CgYvB0tCco5NPuYJHEHOBcR6GnVkZJGh0VNsPqsuEppMNSlIHMS+5dhWPhvzmmmDCqYM5VrbLtg0o4ehMsAw61lXGkkUqIctBLSzdhg/Tjw4bvxdZ1QeNBmq6RQADGjEAJcAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCQRopgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCQRopgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A911F000E9;
	Thu,  9 Jul 2026 00:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783557481;
	bh=RENAVN6va6uTjcNLhj+4No96sH1HBb8IuOBXBZj+j0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nCQRopgmzMF9+fu5Z+cWag8f3rAUgxSI/1etATZktL7ZGEZcVpeSSDqdagb4xGVpm
	 zK9xuQhCTH0c3ME71pFMGugXQb/WpYMLpW4tuA/bEAOBYdIRHM38VoN2Ql4w8afu4v
	 vjB59u85W4NZrqWQKLDj0z5vObwx4osUJIR+eD1ke3d7eO7W6FC5ccDBPcdy8hvSP1
	 Hklc2PadiBIdTviR2xXnAgu9KsufWlRwz2Aazrsa58V5XQyIdplfDi/uV3SXufeSn8
	 eUFMTqEj85PrLDN4u80kMAiMNI6HjLCzkToCm7vMIRs2LgxGDZC3eKaBJ4yrnEOnSH
	 Nem/y/mMSREKw==
From: SJ Park <sj@kernel.org>
To: Jiahui Zhang <jiahuitry@outlook.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH] mm/damon: prevent migration fallback to non-target nodes
Date: Wed,  8 Jul 2026 17:37:51 -0700
Message-ID: <20260709003752.127954-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To:  <BY5PR02MB6642569E180FF82F147E7880B5FF2@BY5PR02MB6642.namprd02.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Honggyu for origin intent of not adding __GFP_THISNODE

On Wed, 8 Jul 2026 10:55:05 -0700 Jiahui Zhang <jiahuitry@outlook.com> wrote:

> Hi SJ,
> 
> Thank you for the review.
> 
> On Wed, Jul 08, 2026 at 07:11:33AM -0700, SJ Park wrote:
> > So this patch is introducing a small behavioral change.  May I ask
> > why you think the new behavior is better?  Have you find some 
> > negative user impacts from the current behavior?
> 
> Consider a two-node tiered system, where node 0 is the fast tier and 
> node 1 is a CPU-less slow tier, such as CXL memory.  Suppose node 0 
> is nearly full and the user wants to promote hot regions (which reside
> on node 1) to node 0 with a command like:
> 
>   sudo damo start --ops vaddr --target_pid ${workload_pid} \
>       --damos_action migrate_hot 0 \
>       --damos_access_rate 70% max
> 
> Without the __GFP_THISNODE flag, when the memory allocator finds that
> node 0 is nearly full, it can fall back to node 1 without waking up 
> kswapd.

Have you considered or tested running demotion-purpose DAMOS scheme together?

> Then the pages allocated for migrate_pages() are still on node 1, 
> and the regions that are expected to be promoted to node 0 are only moved
>  to different physical pages on node 1.
> 
> As a result, the NUMA node placement does not change, but the following
> command still observes successful migrations:
> 
>   sudo bpftrace -e '
>   tracepoint:migrate:mm_migrate_pages /args->reason == 9/
>   {
>       @succeeded_pages = sum(args->succeeded);
>   }
>   interval:s:1
>   {
>       time("%H:%M:%S ");
>       print(@succeeded_pages);
>       clear(@succeeded_pages);
>   }'
> 
> I've also checked other page migration paths, such as alloc_demote_folio(),
>  alloc_misplaced_dst_folio() and do_move_pages_to_node(), all of which set
> the __GFP_THISNODE flag.
> 
> I am not sure whether the original design intended to provide only
> best-effort semantics,

To my understanding, it was initially trying to reflect what
demote_folio_list() does.  Because it doesn't have ___GFP_THISNODE, this
function also ended up not having it without a very serious reason.

My mental model of DAMOS_MIGRATE_{HOT,COLD} nowadays is like move_pages().
And I find do_move_pages_to_node(), which is used by move_pages() is also using
the flag.

So I think adding the flag is ok.  Cc-ed Honggyu for a case he has different
opinions, though.

> but I found this behavior very confusing in my
> experiment.

Thank you for sharing this pain point.

I agree this can be very confusing for inveestigations.  Not just confusing but
makes investigations of this case nearly impossible, iiuc.  DAMOS provides its
own stats for succeeded and failed operations, but that will again not be
helpful since migrate_pages would returned success in this case.

So, yes, let's add the flag unless someone else has a different opinions.

> 
> > We as the kernel community disallow [1] anonymous patch submissions.  Is zjh
> > your preferred identity?  Also, it is not a strict rule, but we as the mm
> > community prefer using a formal name if that's ok.
> 
> Sorry I did not notice this.  If you think the GFP flag should be added, I will
> send a v2 of the patch and correct the Signed-off-by issue.

Yes, please give others time to comment on (say, one day?) and proceed to v2 if
nobody disagrees to.

On the version, could you please add the clarification of the pain points you
encountered, and how this change made it disappeared?

Also, let's change the subject prefix from mm/damon: to mm/damon/ops-common:


Thanks,
SJ

[...]
