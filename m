Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9D1DE2D8;
	Fri, 10 Apr 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865337; cv=none; b=TISsi8MGXrxlKndMj5VdjYRugKgdb6tNkxdFIV1li2GE2iVEIQX4dToi/YWybyMRJQIiRm2Iwxlc36SRw+phGZkwF61ddtLGSxgf0n0JQ+KFIC9Es1OSve1P8A8M2/lsm2LFlzEyRdo7F1QESdgO9Lo8CkPIYc0XF7tjJ/5kLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865337; c=relaxed/simple;
	bh=zw2XYHDnlTw0qahEiBS32vzXn4QNwRFUrjs/0wSN/yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXOqsJSb8eCkmP4+p4Dt7teZVEvmbK0R4KFA/NiCISvVvjUBLYtsVL/uGtM2hlmu2Da+m8aj9t7WKW0axb2j1rPVxdQkCaduSvH12KE5QZsvvyHmyaRtwxMQebftcisNfpqnGdQ2j789FpmNrRt9q4Bs/6Eq9jvSXJ+cOjTKLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiCNVA3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiCNVA3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB6BC19421;
	Fri, 10 Apr 2026 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775865337;
	bh=zw2XYHDnlTw0qahEiBS32vzXn4QNwRFUrjs/0wSN/yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiCNVA3po6Yxr8/tG452qobIJP2c2RhkzOCWFUUS/Y4TeXCnBhnZZPHPefmndSb7G
	 o6RZWXMZ2GWPsXRcHxLSvswNhNFaaPx8tO/+oBzqeNDv8wZ7PtndWSP8sSsOnVzq/f
	 DABSpZFfGpj3AuJ6IjSQPBFJ1nx5whO8CpL/4CWc5qSryGLdDIwZTalwl2zNuBzF/7
	 yrhOSbsvYzXeH3nNI2j9itsT9wK2Sww0GKBFBDLbs3e8qL9zR9rlhc1g+XKLxwFaVK
	 L/c69jZGObXUmGOHRD8xVvmse2MPfOvxN6AoEhdxkzRLpuZ1/8LcIJGou4r6Ndc6HD
	 aeFqXDAxPu2dw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 02/11] mm/damon/core: merge quota-sliced regions back
Date: Fri, 10 Apr 2026 16:55:26 -0700
Message-ID: <20260410235527.90900-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found an issue.  I will address that in the next revision.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit ae9f581463db42127fa24541161baf201709d5f9
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: merge quota-sliced regions back
> 
> This commit merges quota-sliced regions back together to reduce overhead.
> It avoids merging regions if their age is non-zero, meaning no scheme
> action was applied to them.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 8dbc365bb8e97..97b375c720251 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > +static void damos_apply_target(struct damon_ctx *c, struct damon_target *t)
> > +{
> > +	struct damon_region *r, *orig_region = NULL;
> > +	unsigned long orig_end_addr;
> > +
> > +	damon_for_each_region(r, t) {
> > +		/*
> > +		 * damon_do_apply_schemes() could split the region for the
> > +		 * quota.  Keeping the new slices is an overhead.  Merge back
> > +		 * the slices into the original region if there is no reason to
> > +		 * keep those.
> > +		 */
> > +		if (!orig_region || orig_end_addr <= r->ar.start) {
> > +			orig_region = r;
> > +			orig_end_addr = r->ar.end;
> > +		}
> > +		damon_do_apply_schemes(c, t, r);
> > +		if (r == orig_region)
> > +			continue;
> > +		/*
> > +		 * If no scheme was applied to the sliced region, the age of
> > +		 * the slice ain't be reset.  Don't merge that back.
> > +		 * Otherwise, the monitored information of the region is lost.
> > +		 */
> > +		if (r->age) {
> > +			orig_region = NULL;
> > +			continue;
> > +		}
> > +		orig_region->ar.end = r->ar.end;
> > +		damon_destroy_region(r, t);
> > +		r = orig_region;
> > +	}
> > +}
> 
> Does this logic safely handle cases where orig_region and r have differing
> ages?
> 
> If a scheme applies to slice r (resetting r->age to 0), but was skipped
> for orig_region (leaving orig_region->age > 0), the check if (r->age)
> will be false. The slice r will then be merged into orig_region, and
> the reset age of r will be lost because it structurally inherits the
> non-zero age of orig_region.
> 
> Could this cause age-based rate-limiting to be bypassed, allowing schemes
> to erroneously apply to the same memory regions repeatedly in subsequent
> intervals?
> 
> Additionally, if both orig_region and r have the same non-zero age
> (e.g., both were skipped), if (r->age) evaluates to true, setting
> orig_region = NULL and skipping the merge entirely.
> 
> Should the merge condition verify that the contiguous slices share identical
> state before merging, perhaps by checking if (orig_region->age != r->age)?

Good finding.  I was thinking the scheme will anyway be applied, once the
quota-split is happened.  But I was wrong, since DAMOS core filter is applied
after the split operation.  Also, age is not reset if the action is DAMOS_STAT.

I will address this in the next revision, like below.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2439,35 +2439,32 @@ static void damon_do_apply_schemes(struct damon_ctx *c,

 static void damos_apply_target(struct damon_ctx *c, struct damon_target *t)
 {
-       struct damon_region *r, *orig_region = NULL;
-       unsigned long orig_end_addr;
+       struct damon_region *r;

        damon_for_each_region(r, t) {
+               struct damon_region *prev_r;
+
+               damon_do_apply_schemes(c, t, r);
                /*
-                * damon_do_apply_schemes() could split the region for the
+                * damon_do_apply_scheems() could split the region for the
                 * quota.  Keeping the new slices is an overhead.  Merge back
-                * the slices into the original region if there is no reason to
-                * keep those.
+                * the slices into the previous region if it doesn't lose any
+                * information.
                 */
-               if (!orig_region || orig_end_addr <= r->ar.start) {
-                       orig_region = r;
-                       orig_end_addr = r->ar.end;
-               }
-               damon_do_apply_schemes(c, t, r);
-               if (r == orig_region)
+               if (damon_first_region(t) == r)
                        continue;
-               /*
-                * If no scheme was applied to the sliced region, the age of
-                * the slice ain't be reset.  Don't merge that back.
-                * Otherwise, the monitored information of the region is lost.
-                */
-               if (r->age) {
-                       orig_region = NULL;
+               prev_r = damon_prev_region(r);
+               if (prev_r->ar.end != r->ar.start)
                        continue;
-               }
-               orig_region->ar.end = r->ar.end;
+               if (prev_r->age != r->age)
+                       continue;
+               if (prev_r->last_nr_accesses != r->last_nr_accesses)
+                       continue;
+               if (prev_r->nr_accesses != r->nr_accesses)
+                       continue;
+               prev_r->ar.end = r->ar.end;
                damon_destroy_region(r, t);
-               r = orig_region;
+               r = prev_r;
        }
 }
'''

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-3-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260410142034.83798-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
