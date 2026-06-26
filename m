Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375A3E559A
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464390; cv=none; b=rWoGBXob+CiJwat474O+PQYluibnnXVyESDFqgBSCvYgK2cPUelX/oLt4DUmQEpoZsbVH00qfH2uhKgMLGjCp33bmoJjWeRWKxaERfNYygUdfmjyTMLzpCPCW1SfVcu0SnHidLMbp1kNdNfTy4V0VCSA8xzsL4KfkOj5jLZoDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464390; c=relaxed/simple;
	bh=SsWznP14x4ZdUjlBza70O6kMJ2eH0GZOe9spY7aKzE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZWWFn0VZjgna+QRR1esO8It7oIf/h5kUfPnI1wzUWRDdJcG1aA1/yS8tmgb97wGpZ5OQR47DXqemgbzk1aO1AkPPUwR3YEumW0mbG/D6bw5got82hfICPT1+NsxOWkXwn40WcuSFzmXo3x7SW1s3R3AsctDhJgtVIW6gngY6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nNwYgbHD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nNwYgbHD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782464384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Btdrgv+2MYn8HqFl/2dPPY1UPaNThih8AbcIgKdCzc=;
	b=nNwYgbHD3alMle7JcMKnIFN2udtNhz3R7njzknZnJQKa1+YVM+/1w17vrd+tN1sp9D0uDK
	VcEQ6wltXoyGV8LZy44qi5p3LlghwCipWLXbV19SO3chnyLrt/OFGER+JT6GsLlX6I4wWP
	o1rlqV+ejZIDIEkfXIGxPexpm5B7H5E=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: jiayuan.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/damon/core: detect internal variation above max_nr_regions/2
Date: Fri, 26 Jun 2026 16:58:36 +0800
Message-ID: <20260626085851.70754-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sorry for the late.

kdamond_split_regions() bails out early when nr_regions is already
above max_nr_regions / 2.  A large region that picks up new internal
variation after that point never gets split, so we lose visibility
into its hot/cold structure.

We hit this with damon-paddr on hugepage workloads and damon-vaddr
on processes that mmap a large anonymous range.

Example with max_nr_regions == 1500.  A target ends up with 799
small hot/cold regions plus one big region (an earlier merge
collapsed a uniformly-accessed range into a single piece):

H:hot
C:cold

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|

    nr_regions = 800  >  max_nr_regions / 2 = 750

Now a cold subarea shows up inside r800:

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|

The small regions can't merge with each other (their access counts
differ), so budget never frees up.  r800 can't be split because
nr_regions > max_nr_regions / 2 returns early.  The cold subarea
stays invisible.

Patch 1 keeps refining on this path: when nr_regions is above
max_nr_regions / 2 but still under the maximum, it splits a fraction
of the regions instead of returning.  The fraction shrinks as the
remaining budget shrinks, so the count approaches max_nr_regions
smoothly.  A useless split is undone by the next merge cycle.

Patch 2 adds a KUnit test for the case where nr_regions is already
above max_nr_regions / 2.

Thanks to SeongJae for the suggestion to drive the split fraction
from the remaining budget rather than an age-based filter.


v1 -> v2: Some feedback from SJ.
v1: https://lore.kernel.org/damon/20260521045236.115749-1-jiayuan.chen@linux.dev/

Jiayuan Chen (2):
  mm/damon/core: split a fraction of regions when nr_regions exceeds
    max/2
  mm/damon/tests/core-kunit: test split above max_nr_regions/2

 mm/damon/core.c             | 49 +++++++++++++++++++++++++---
 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 5 deletions(-)

-- 
2.43.0

