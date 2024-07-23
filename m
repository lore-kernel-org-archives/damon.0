Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4517BD5;
	Tue, 23 Jul 2024 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721736591; cv=none; b=KKMDNG4VNwXBInclUqMjJoAHYDkKCX2sNHvQegIqHRqnrsU3vrAdsSc7/pX+R920UMB4BTiHU3IIEv1loRqfUpnbbmwcTDTXEh0fS2JAWGGT4LyuVeFZykn69ejwfEykfP8siqf5NoHsbQT1Xu6oDS/rxGkVIw73Xu4BoUmESVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721736591; c=relaxed/simple;
	bh=GzdI/su6Ucw1JuPfQUySJpX0Ti6NwAl2vI4cx3OUtIA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=WQ/KE95nr+W75vc0kgIzGJ1m1icexIC0ylahnOr3g/CU6PkXDtGFZAff6nm57Ni61dk/HI1H91qT9f/PmC4xcxBYpy1VsDcNlD+k3XnembHK35CMd3DDXsL8uTiSRMHoSFJbgAnp0rtk/EcCW0iFXvqvGB84fhQZqvCGiG82ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yf+Wo1Nb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yf+Wo1Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98916C4AF09;
	Tue, 23 Jul 2024 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721736591;
	bh=GzdI/su6Ucw1JuPfQUySJpX0Ti6NwAl2vI4cx3OUtIA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=yf+Wo1Nbn5+5Kbqyim0HHHAdT3uV4wAu2gtYm1tbzChr56OvGnae1OAWnVYr/ZDtw
	 8XGduqLWo5X9DuFPrlWm5oT2ZV9iDMcgX3QvMeQ8V9PG1qVuys+RjC06KbqmubOqBn
	 M2Tuw2K003IsR5sIEglCW7bd0y1PfWg3qwGLCUeI=
Subject: Patch "mm/damon/core: merge regions aggressively when max_nr_regions is unmet" has been added to the 6.1-stable tree
To: akpm@linux-foundation.org,damon@lists.linux.dev,gregkh@linuxfoundation.org,linux-mm@kvack.org,sj@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Jul 2024 14:09:26 +0200
In-Reply-To: <20240716175205.51280-8-sj@kernel.org>
Message-ID: <2024072325-eggnog-profusely-f907@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    mm/damon/core: merge regions aggressively when max_nr_regions is unmet

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mm-damon-core-merge-regions-aggressively-when-max_nr_regions-is-unmet.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-60285-greg=kroah.com@vger.kernel.org Tue Jul 16 19:53:31 2024
From: SeongJae Park <sj@kernel.org>
Date: Tue, 16 Jul 2024 10:52:05 -0700
Subject: mm/damon/core: merge regions aggressively when max_nr_regions is unmet
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20240716175205.51280-8-sj@kernel.org>

From: SeongJae Park <sj@kernel.org>

commit 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6 upstream.

DAMON keeps the number of regions under max_nr_regions by skipping regions
split operations when doing so can make the number higher than the limit.
It works well for preventing violation of the limit.  But, if somehow the
violation happens, it cannot recovery well depending on the situation.  In
detail, if the real number of regions having different access pattern is
higher than the limit, the mechanism cannot reduce the number below the
limit.  In such a case, the system could suffer from high monitoring
overhead of DAMON.

The violation can actually happen.  For an example, the user could reduce
max_nr_regions while DAMON is running, to be lower than the current number
of regions.  Fix the problem by repeating the merge operations with
increasing aggressiveness in kdamond_merge_regions() for the case, until
the limit is met.

[sj@kernel.org: increase regions merge aggressiveness while respecting min_nr_regions]
  Link: https://lkml.kernel.org/r/20240626164753.46270-1-sj@kernel.org
[sj@kernel.org: ensure max threshold attempt for max_nr_regions violation]
  Link: https://lkml.kernel.org/r/20240627163153.75969-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20240624175814.89611-1-sj@kernel.org
Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -921,14 +921,31 @@ static void damon_merge_regions_of(struc
  * access frequencies are similar.  This is for minimizing the monitoring
  * overhead under the dynamically changeable access pattern.  If a merge was
  * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ *
+ * The total number of regions could be higher than the user-defined limit,
+ * max_nr_regions for some cases.  For example, the user can update
+ * max_nr_regions to a number that lower than the current number of regions
+ * while DAMON is running.  For such a case, repeat merging until the limit is
+ * met while increasing @threshold up to possible maximum level.
  */
 static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 				  unsigned long sz_limit)
 {
 	struct damon_target *t;
+	unsigned int nr_regions;
+	unsigned int max_thres;
 
-	damon_for_each_target(t, c)
-		damon_merge_regions_of(t, threshold, sz_limit);
+	max_thres = c->attrs.aggr_interval /
+		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
+	do {
+		nr_regions = 0;
+		damon_for_each_target(t, c) {
+			damon_merge_regions_of(t, threshold, sz_limit);
+			nr_regions += damon_nr_regions(t);
+		}
+		threshold = max(1, threshold * 2);
+	} while (nr_regions > c->attrs.max_nr_regions &&
+			threshold / 2 < max_thres);
 }
 
 /*


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/minmax-allow-min-max-clamp-if-the-arguments-have-the-same-signedness.patch
queue-6.1/minmax-sanity-check-constant-bounds-when-clamping.patch
queue-6.1/minmax-clamp-more-efficiently-by-avoiding-extra-comparison.patch
queue-6.1/minmax-relax-check-to-allow-comparison-between-unsigned-arguments-and-signed-constants.patch
queue-6.1/minmax-fix-header-inclusions.patch
queue-6.1/mm-damon-core-merge-regions-aggressively-when-max_nr_regions-is-unmet.patch
queue-6.1/minmax-allow-comparisons-of-int-against-unsigned-char-short.patch
