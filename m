Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D41E884B;
	Mon, 21 Oct 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528400; cv=none; b=icPBFC3MorkOO0vJ8VkCEsvLfPH26V1B20Z6/K1pg5NQtQD6QbkyHWVr7Tp4h9G3m11trIaBR1hCjvr6ONMOstt+XP7tUiJwyJyTP9d33iUpVoBS9GEWDRcrg8TzL6bGNoIN8+KHR6aMnJPef3mE9RlgVmsiUCsOivSKR+Qkms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528400; c=relaxed/simple;
	bh=6OcdKlmewqXrz4uXGX4rgtHpk/lWg7eQivdJwig1cwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tj7FJUbychSin/XpqBoTeOv79Kp/PoslKrZiYy2+hex7gEP6qKFrsNOchHw/7Fg5jwbLT+OQlK5sjHts7+dmJ7d+Ew3d8LWALiEZAtVsi3NVeQrG2OJcHMQGCB33HILb4i6rlwUGGOBRCxyw4rQ8f54q8LF0pX3xgoyI2LogDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPbJ92H4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPbJ92H4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA75EC4CEE8;
	Mon, 21 Oct 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729528400;
	bh=6OcdKlmewqXrz4uXGX4rgtHpk/lWg7eQivdJwig1cwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPbJ92H4sZ4GCwx+UOw/7Wqy+pyL1SIgnRAUiB7fVoE3kBefIQL8kPigJXdJf2QJj
	 yqlI7WWqKFmlVCzlGSFb3lO2G7u1tnIJb8QE3keqe7qkLEw/WlG9TBkqmB+KLGVMsL
	 YJI5RQ875GgAxvOSJJgmxAwj6jKs2syQQOlxuFMC7gArgryENwxq8dY5A9gSRslET6
	 1rYG5V35iQz+hmf691MjijLWyWO+fVE0pwBZaCKBr5MD13FLyTab3Fj3NESudx7P7i
	 DPKh2wCCySiG8DkWJ9S6Yaq+8s5XY+h45HbxpkLV1i3STrdjPteiviSLUENTJgLXJT
	 l2CsPBJWRqGeA==
From: SeongJae Park <sj@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	sieberf@amazon.com,
	shakeel.butt@linux.dev,
	foersleo@amazon.de,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ye Weihua <yeweihua4@huawei.com>
Subject: Re: [PATCH] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Mon, 21 Oct 2024 09:33:16 -0700
Message-Id: <20241021163316.12443-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <186f770b-925f-3541-2ca7-fa6ee6f0caf6@huaweicloud.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 11:56:04 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> On 2024/10/19 02:33, SeongJae Park wrote:
> > Hi Zheng,
> > 
> > 
> > Thank you for sharing this nice finding and fix!  I have a few comments below.
> > 
> 
> Thanks for your review!
> 
> > On Fri, 18 Oct 2024 11:53:04 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
> > 
> >> According to the logic of damon_va_evenly_split_region(), currently at
> >> least following split cases would not meet the expectation:
> >>
> >>    Suppose DAMON_MIN_REGION=0x1000,
> >>    Case1: Split [0x0, 0x1100) into 1 pieces, then the result would be
> >>           acutually [0x0, 0x1000), but NOT the expected [0x0, 0x1100) !!!
> > 
> > Nice finding!  However, as long as DAMON_MIN_REGION is respected, [0x0, 0x1100]
> > region could not be created.  So, the problematic case cannot happen in real?
> > Please let me know if I'm missing something.
> 
> Currently when DAMON_MIN_REGION is defined as PAGE_SIZE, and both vm start
> and end are commonly page-aligned, then the [0x, 0x1100) could not be created,
> but I'm not sure either.

Thank you for confirming.  If there is a way that DAMON could generate
[0x, 0x1100], that's a bug that deserves its own fix.  So let's assume it
cannot happen for now.

> 
> > 
> > And, why would someone call the function with nr_pieces 1?
> > 
> 
> damon_va_evenly_split_region() is called in __damon_va_init_regions(), and nr_pieces
> is calculated by:
> 
>    `nr_pieces = (regions[i].end - regions[i].start) / sz;`
> 
> Above regions[i].start/regions[i].end/sz is determine at runtime, and sz can
> beaffected by minimum number of regions, user can change that, am I right?
> Then nr_pieces can be 1 !

You're right, thank you.

Now, the next question would be, could that ('damon_va_evenly_split_region()'
being called with 1 'nr_pieces') trigger some issues?  Based on the code, I
don't think so.  Please let me know if I'm missing some corner cases.

> On the other hand, I think damon_va_evenly_split_region() itself should
> handle the 'nr_pieces == 1' case, or if we make sure that case is unreal,
> would it be better to add some assertion?

Nice suggestion, thanks.  I agree that making it be handled is better in terms
of maintenance.  It would make the code much easier to read.

It wouldn't be for a fix of a bug, but for making the code easier to read.  So
I think posting it as a separate patch is better.  If you don't mind, please
post a patch.

> 
> >>    Case2: Split [0x0, 0x3000) into 2 pieces, then the result would be
> >>           acutually 3 regions:
> >>             [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
> >>           but NOT the expected 2 regions:
> >>             [0x0, 0x1000), [0x1000, 0x3000) !!!
> > 
> > Nice finding!
> > 
> >>
> >> The root cause is that when calculating size of each split piece in
> >> damon_va_evenly_split_region():
> >>
> >>    `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`
> >>
> >> both the dividing and the ALIGN_DOWN may cause loss of precision,
> >> then each time split one piece of size 'sz_piece' from origin 'start' to
> >> 'end' would cause:
> >>    1. For the above Case1, the 'end' value of the split 1 piece is
> >>       aligned but not updated!!!
> >>    2. For the above Case2, more pieces are split out than expected!!!
> >>
> >> To fix it, in this patch:
> >> - As for the expect to split 1 piece, just return 0;
> > 
> > As mentioned above, I think this is not needed, since the problematic case is
> > unreal.
> 
> I think this case exists, as above reply.

A case that damon_va_evenly_split_region() is called with nr_pieces of value 1
exists.

A case that the function is called with DAMON_MIN_REGION un-aligned region
doesn't exist (unless there is a bug).

I was saying about the second case.  I still agree doing the nr_pieces check is
good for readability, so please post a patch if you don't mind.

> 
> > 
> >> - Count for each piece split and make sure no more than 'nr_pieces';
> >> - Add above two cases into damon_test_split_evenly().
> > 
> > Thank you for adding tests!
> > 
> >>
> >> BTW, currently when running kunit test, DAMON_MIN_REGION is redefined
> >> as 1, then above ALIGN_DOWN cases may not be test, since every int
> >> value is ALIGN-ed to 1.
> >>
> >> After this patch, damon-operations test passed:
> >>
> >>   # ./tools/testing/kunit/kunit.py run damon-operations
> >>   [...]
> >>   ============== damon-operations (6 subtests) ===============
> >>   [PASSED] damon_test_three_regions_in_vmas
> >>   [PASSED] damon_test_apply_three_regions1
> >>   [PASSED] damon_test_apply_three_regions2
> >>   [PASSED] damon_test_apply_three_regions3
> >>   [PASSED] damon_test_apply_three_regions4
> >>   [PASSED] damon_test_split_evenly
> >>   ================ [PASSED] damon-operations =================
> >>
> >> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> >> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> >> ---
> >>   mm/damon/tests/vaddr-kunit.h |  2 ++
> >>   mm/damon/vaddr.c             | 13 +++++++++----
> >>   2 files changed, 11 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> >> index a339d117150f..b9a03e4e29e5 100644
> >> --- a/mm/damon/tests/vaddr-kunit.h
> >> +++ b/mm/damon/tests/vaddr-kunit.h
> >> @@ -300,6 +300,8 @@ static void damon_test_split_evenly(struct kunit *test)
> >>   	damon_test_split_evenly_fail(test, 0, 100, 0);
> >>   	damon_test_split_evenly_succ(test, 0, 100, 10);
> >>   	damon_test_split_evenly_succ(test, 5, 59, 5);
> >> +	damon_test_split_evenly_succ(test, 4, 6, 1);
> > 
> > If my above assumption (the first problem is unreal) is not wrong, maybe this
> > test is not needed?
> > 
> 
> As an unit test, damon_va_evenly_split_region() itself should be able
> to handle the 'nr_pieces == 1' case, right? I think this testcase can
> be added in case something goes wrong one day.

I agree.  Nonetheless, let's make it be separated with the real bug fix.

> 
> >> +	damon_test_split_evenly_succ(test, 0, 3, 2);
> > 
> > Nice.
> > 
> >>   	damon_test_split_evenly_fail(test, 5, 6, 2);
> >>   }
> >>   
> >> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> >> index 08cfd22b5249..1f3cebd20829 100644
> >> --- a/mm/damon/vaddr.c
> >> +++ b/mm/damon/vaddr.c
> >> @@ -67,10 +67,14 @@ static int damon_va_evenly_split_region(struct damon_target *t,
> >>   	unsigned long sz_orig, sz_piece, orig_end;
> >>   	struct damon_region *n = NULL, *next;
> >>   	unsigned long start;
> >> +	int i;
> > 
> > Purpose of this variable is counting the number of splitted regions, and
> > comparing it against 'nr_pieces', right?  Because nr_pieces is 'unsigned int',
> > let's make this 'unsigned int' type, too.
> > 
> 
> Well, yes, I'll do it in v2 after all the discussions for this version are complete!

Thanks :)

> 
> >>   
> >>   	if (!r || !nr_pieces)
> >>   		return -EINVAL;
> >>   
> >> +	if (nr_pieces == 1)
> >> +		return 0;
> >> +
> > 
> > As mentioned above, I don't think this is not needed.

As mentioned above, now I think having this is good for readability, but let's
make it an individual change that separated from the real bug fix.

> > 
> 
> 
> 
> >>   	orig_end = r->ar.end;
> >>   	sz_orig = damon_sz_region(r);
> >>   	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
> >> @@ -79,9 +83,11 @@ static int damon_va_evenly_split_region(struct damon_target *t,
> >>   		return -EINVAL;
> >>   
> >>   	r->ar.end = r->ar.start + sz_piece;
> >> +	/* origin region will be updated as the first one after splitting */
> > 
> > I don't think this comment is easy to understand.  Let's just remove it.
> > 
> 
> Thanks, I'll remove it in next version!
> 
> >> +	i = 1;
> >> +	n = r;
> > 
> > Why we need this? for 'nr_pieces == 1' case?  If so, I don't think we need to
> > take care about the case for the above mentioned reason.  Please let me know if
> > I'm missing something.
> 
> Yes, this is for 'nr_pieces == 1' case, and if we have above `if (nr_pieces == 1) return 0;` line,
> then this is not needed since nr_pieces > 1, and following loop will at least two times
> 
> > 
> >>   	next = damon_next_region(r);
> >> -	for (start = r->ar.end; start + sz_piece <= orig_end;
> >> -			start += sz_piece) {
> >> +	for (start = r->ar.end; i < nr_pieces; start += sz_piece, i++) {
> >>   		n = damon_new_region(start, start + sz_piece);
> >>   		if (!n)
> >>   			return -ENOMEM;
> >> @@ -89,8 +95,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
> >>   		r = n;
> >>   	}
> >>   	/* complement last region for possible rounding error */
> >> -	if (n)
> >> -		n->ar.end = orig_end;
> >> +	n->ar.end = orig_end;
> > 
> > Maybe this change is related with the above 'n = r' line?  But, I don't think
> > we need that, as commented there.
> 
> Yes, they related.

Thank you for confirming.

> 
> > 
> >>   
> >>   	return 0;
> >>   }
> >> -- 
> >> 2.25.1
> > 
> > 
> > Thanks,
> > SJ
> 
> -- 
> Thanks,
> Zheng Yejian

So, let's add the 'nr_pieces == 1' check, but as a change that separated from
the real bug fix.  I'm looking forward to your next posts, Zheng :)

Nonetheless, please note that the real bug is not somewhat critical for users.
It only has a potential to slightly degrade the best-effort accuracy of DAMON
in corner cases.


Thanks,
SJ
