Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B470803;
	Fri, 21 Feb 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100188; cv=none; b=KI+3BDwuBjRlhAAX28mKHuwktxxME2sJs0M1zWj09DY+5CE+/CqacdESBeHkyIu+WEFQ0OX02E15qhORQCLC/0yLc7jKBMyBdzGqyRUXsJ20EfWEkSeEMtA4zuC2x6j9nsxCZxPj/5Q1hQ47uFbby4jhv1O4lTpG/pnXVFal7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100188; c=relaxed/simple;
	bh=FXVRulunC3wqJ1fgi01DQJm3OVjZa45dNnmystm3rDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hrj7W8tL6A3xB9Wn8/m5aJ9b8spiAYZaQ6FyhVYOQsaLq1AKBoWS+16CYNlCNavXVXEwXyboGTq0+bu64HasAKB68sAbAu/f2G6+dC0ATCvH6K3byf50jjRPhYNxomqaPBmtjnlitRc7J4bIauwteNyLht7EIqZZBv9ni2J8uKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiBCLOx4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiBCLOx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87D5C4CED1;
	Fri, 21 Feb 2025 01:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740100188;
	bh=FXVRulunC3wqJ1fgi01DQJm3OVjZa45dNnmystm3rDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiBCLOx4Aax3YcIDiwPnOhNjtpqwmigZnCNGLzO8W2babK0oMVOqovPyiArugctyW
	 Vs+xZhITFIfOALSqXDVaznWz4lPZN0EOIatr58G6M/FE7VR+jdrc1nBJ75bTXfzBRc
	 qgcZhz5tY39vow1PuBrLn6CJz+wfAqTmvERHUH3Gc2GhGKF/CfOjAKRYUElLcrqfKC
	 +aAhd62gba85E3JxsCHHFuYWjMkJJM8Ub3AYuT0VaQ+i3Aa1Z8uFO0hCYxScbcPkXg
	 Htk8TD44PhhLRSGuKc/WRTD7DihwxbZs2iU3gmF7/3Hjntdf1K+LvUUQyk2yR7c4yq
	 cE0kkldNgI3GA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] mm/damon: auto-tune aggregation interval
Date: Thu, 20 Feb 2025 17:09:44 -0800
Message-Id: <20250221010944.40257-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 17:44:30 -0800 SeongJae Park <sj@kernel.org> wrote:

> DAMON requires time-consuming and repetitive aggregation interval
> tuning.  Introduce a feature for automating it using a feedback loop
> that aims an amount of observed access events, like auto-exposing
> cameras.
[...]
> Aim-oriented Feedback-driven Auto-Tuning
> =========================================
[...]
> we design an automation of aggregation
> interval tuning, in a way similar to that of camera auto-exposure
> feature.  It defines the amount of interesting information as the ratio
> of captured access events to total capturing attempts of single snapshot,
> or more technically speaking, the ratio of positive access check samples
> to total samples within the aggregation interval.  It allows the users
> to set the target value of the ratio.  Once the target is set, the
> automation periodically measures the current value of the ratio and
> increase or decrease the aggregation interval if the ratio value is
> lower or higher than the target.  The amount of the change is proportion
> to the distance between current value and the target value.
> 
> To avoid auto-tuning goes too long way, let users set minimum and
> maximum aggregation interval time.  Changing only aggregation interval
> while sampling interval is kept make the maximum level of access
> frequency in each snapshot, or discernment of regions inconsistent.
> Also, unnecessarily short sampling interval causes meaningless
> monitoring overhed.  The automation therefore adjusts the sampling
> interval together with aggregation interval, while keeping the ratio
> between the two intervals.  Users can set the ratio, or the discernment.

I received a concern about a corner case of the metric (positive access check
samples ratio) offline.  In short, DAMON might find a few discontiguous
extremely hot and small regions and let those achieve the target positive
access check samples ratio, even with very short aggregation interval.

I was able to show the corner case indeed.  It started to increase the
aggregatiopn interval at the beginning, but it gets reduced as time goes by and
region boundaries get converged.  It was showing a few very hot 4-8 KiB memory
regions that showing maximum nr_accesses even with the low aggregation
interval.  They made the target samples ratio on their own.  So most of other
regions looked pretty cold.

This means the logic is implemented and designed and work as expected.  But,
the resulting snapshot is not what we wanted.  We wanted the snapshot to show
practical amount of differences between regions that we can utilize for better
memory management, not the dark and cold space with a few flaming but tiny red
dots.  It might seem ok if that's the true access pattern of the workload.  And
that's true.  Some workloads would have really biased access pattern that we
cannot make useful memory management decision.  But, if that's the case,
according to our tuning theory, the logic should have maximum aggregation
interval.

I also worried about this corner case when starting the design.  I hence
considered[1] having two feedback loop goals, namely the positive access check
samples ratio and total size of >0 nr_accesses regions.  But I ended up making
this RFC with the first metric only for starting with simpler design.  I'm
still bit skeptical about having multiple goals, and looking for a better
single metric.

Now I'm thinking observed total access events ratio might make sense to be used
instead.  That is, DAMON's regions concept assumes every byte of single region
shares similar access frequency.  For example, having a DAMON region of size 4
KiB and nr_accesses 20 can be interpreted as DAMON has observed 4 * 1024 * 20
access events.  For example, below diff on top of this patch series would
explain what I'm saying about better than my text.

I will do more tests and share more findings on this thread until I post the
next spin of this patch series.


diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3c1f401fcbbb..0635882751cc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1428,19 +1428,20 @@ static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long nr_regions = 0, access_samples = 0;
+	unsigned long sz_regions = 0, heats = 0;
 	struct damon_intervals_goal *goal = &c->attrs.intervals_goal;
-	unsigned long max_samples, target_samples, score_bp;
+	unsigned long max_heats, target_heats, score_bp;
 	unsigned long adaptation_bp;

 	damon_for_each_target(t, c) {
-		nr_regions = damon_nr_regions(t);
-		damon_for_each_region(r, t)
-			access_samples += r->nr_accesses;
+		damon_for_each_region(r, t) {
+			sz_regions += r->ar.end - r->ar.start;
+			heats += (r->ar.end - r->ar.start) * r->nr_accesses;
+		}
 	}
-	max_samples = nr_regions * c->attrs.aggr_samples;
-	target_samples = max_samples * goal->samples_bp / 10000;
-	score_bp = access_samples * 10000 / target_samples;
+	max_heats = sz_regions * c->attrs.aggr_samples;
+	target_heats = max_heats * goal->samples_bp / 10000;
+	score_bp = heats * 10000 / target_heats;
 	adaptation_bp = damon_feed_loop_next_input(100000000, score_bp) /
 		10000;
 	/*

[1] https://git.kernel.org/sj/damon-hack/c/b01238ded409828bc427cd037095686483d39faf


Thanks,
SJ

[...]
