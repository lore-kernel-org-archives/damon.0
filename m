Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CC7E
	for <damon@lists.linux.dev>; Tue,  6 Sep 2022 17:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9BEC433D6;
	Tue,  6 Sep 2022 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662486935;
	bh=H4cmrH6o9Pb/823cCz/RdiQngDRmnmPWtaXJaP+dm+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBASf0Me/dsm20HGEKdXRvzvDI5+ZP6gwhcpeOXEPgqLtckapkYIAoZN2LJiTw7ep
	 SM2gCcS61vUCwh77vFw8pmymikjN+GBVoQVIc8rrBsVymUCZVPTN/AyRtBq7FVYvlC
	 1LLKdcBqS0xJNT7g88w/ZnrJfq+AQtF7kEcNPgzL/jZdT9ixl6btYgAYU5q/xFh8Rl
	 AvIBo2hGm8MX0wLZVDRl3dA7ai9uP9zK+zITT8PrEGLSHlRngsLtpZexFEeM7EV4/q
	 TstFMUntLMs7Jpz4D6NgxKOxZkOh5E4K1IKxkKjXrnqvht4vbXDpJyESqObG7qEURW
	 rXwweU6o1sT0g==
From: SeongJae Park <sj@kernel.org>
To: Yun Levi <ppbuk5246@gmail.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev
Subject: Re: [Question] About damon_set_regions function.
Date: Tue,  6 Sep 2022 17:55:32 +0000
Message-Id: <20220906175532.157099-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAM7-yPTjEa0Av8nrqqQ5vmBTg2fv26mzXReLOBFaRxViGXvF+Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Levi,

On Tue, 6 Sep 2022 12:19:07 +0900 Yun Levi <ppbuk5246@gmail.com> wrote:

> Hello damon community.
> I'm a beginner of damon who want to use it well :)
> 
> While I'm reading the damon core code,
> I have a question about the "damon_set_regions" function's features.
> 
> Comment said that
> "This function adds new regions to, or modify existing regions of a
> monitoring target to fit in specific ranges".
> 
> But I don't know if it's correct in the case below:
> 
> Suppose, target already has 2 ranges one of them is 4K to 16K and the
> other 24K to 32K
> And someone calls damon_set_regions with a range 8K to 28K.
> 
> In that situation, damon_set_regions function will modify existing two
> region like
>     - first as 8K to 16K
>     - last as 24K to 28K
> 
> base on below code snippet:
>          } else {
>               /* resize intersecting regions to fit in this range */
>               first->ar.start = ALIGN_DOWN(range->start,
>                       DAMON_MIN_REGION);
>               last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
>          }
> 
> But, I don't know the reason why the region having 16K to 24K range
> isn't added to the target region list and it's correct or not.

Good finding!  Right, the code assumes the regions are always contiguous, which
is wrong!

> 
> In my thinking,  there should be the code adding the region like:
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7d25dc582fe3..f755efca71b2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -225,6 +225,15 @@ int damon_set_regions(struct damon_target *t,
> struct damon_addr_range *ranges,
>                         first->ar.start = ALIGN_DOWN(range->start,
>                                         DAMON_MIN_REGION);
>                         last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
> +
> +                       if (first != last) {
> +                               newr = damon_new_region(
> +                                               first->ar.end,
> last->ar_start); /**< already aligned. */
> +                               if (!newr)
> +                                       return -ENOMEM;
> +
> +                               damon_insert_region(newr, first, last, t);
> +                       }
>                 }
>         }
>         return 0;
> 
> Am I wrong?

This would fix the specific case, but there might be more than 2 regions that
not contiguous.  I think we should also handle the case?  E.g.,

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -194,6 +194,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 {
        struct damon_region *r, *next;
        unsigned int i;
+       bool found;

        /* Remove regions which are not in the new ranges */
        damon_for_each_region_safe(r, next, t) {
@@ -235,6 +236,24 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
                        first->ar.start = ALIGN_DOWN(range->start,
                                        DAMON_MIN_REGION);
                        last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+
+                       /* fill the holes between first and last */
+                       found = false;
+                       damon_for_each_region(r, t) {
+                               struct damon_region *next;
+                               if (r == first)
+                                       found = true;
+                               if (!found)
+                                       continue;
+                               if (r == last)
+                                       break;
+                               next = damon_next_region(r);
+                               if (next->ar.start != r->ar.end) {
+                                       newr = damon_new_region(r->ar.end, next->ar.start);
+                                       damon_insert_region(newr, r, next, t);
+                               }
+                       }
+
                }
        }
        return 0;

Of course, the code should be cleaned up (e.g., would better to use
list_for_each_entry_from() and factor out to a separate function).  This is
only for a PoC.  Is there anything I'm missing?


Thanks,
SJ

> 
> Thanks.
> 
> -- 
> Best regards,
> Levi
