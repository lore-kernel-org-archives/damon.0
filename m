Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2733161BB
	for <damon@lists.linux.dev>; Mon, 12 Jan 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253789; cv=none; b=HAU04wA01UG/anYUT0iI4QaV8jTukyGwMOfqbZ77JpCsTfT0T6k9M6N2Tu8LvWNDIitV+xNW4gJCIByDGUC49l+pjbE3zlvb29aK+j8TtQDV1Oeuzut+/PvJViGMkNNLSktDqqIiUisd+yxWMin5sC6pZaEuwAyhDp+IvGmbvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253789; c=relaxed/simple;
	bh=JRHRyYV/O3DnaieVuW9WQbLrDAUMyJJpI/o1z8oEpZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk/8Lrb6sTG+qOi7nsholJY5gh2T1FzxgOFFbixmAflCoUeOIQLqD+k8Wcvn8xYLITRpJ+LClHwebGDeZWuISYfVWjlxr5WgqmFAvRiNRDZotx/sR81kurQoVZrBzc/umD+I+QjASPwWLmBk7HLNHyJiZOMBbMi8R9oc2cf4o+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m9m5QVTT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m9m5QVTT"
Date: Mon, 12 Jan 2026 13:36:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768253784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3BjtoAAstlY6b/etRhy75SWXFb2D/YEwMqRuShF6b4=;
	b=m9m5QVTTu18qp8eRE/apJolgPvKzpkMqNnIXlpc3SbPa2JdSjsDVvGS7ImBzThOacvugFB
	MwqB5jlAH93aGBWWWUL7ptUT9Qf8SUsLwB+ebL0V/ezVEw5FPfiB8/5r5ta2NYtf6qsTUN
	XG58PScDJPtcXLX1t8Dn445oIXrPFWk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Message-ID: <flkqanhyettp5uq22bjwg37rtmnpeg3mghznsylxcxxgaafpl4@nov2x7tagma7>
References: <20251225232116.294540-9-shakeel.butt@linux.dev>
 <20260108045954.78552-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108045954.78552-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 07, 2026 at 08:59:53PM -0800, SeongJae Park wrote:
> On Thu, 25 Dec 2025 15:21:16 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 3e7d69020b39..5a1161cadb8d 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> [...]
> > -struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino);
> > +struct mem_cgroup *mem_cgroup_get_from_id(u64 ino);
> 
> Nit.  How about renaming the argument from 'ino' to 'id'?
> 
> [...]
> > -static inline struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
> > +static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
> 
> Ditto.
> 
> [...]
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3615,7 +3615,7 @@ struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
> >  	return xa_load(&mem_cgroup_private_ids, id);
> >  }
> >  
> > -struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
> > +struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
> 
> Ditto.
> 

Thanks a lot SJ for the review and suggestions.

Andrew, can you please squash the following fix into the series?


From 7bf26690649ab9c555d17a2acb7215e768232d13 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Mon, 12 Jan 2026 13:34:27 -0800
Subject: [PATCH] memcg: replace ino with id

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 538fddd3ef77..b6c82c8f73e1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -835,7 +835,7 @@ static inline u64 mem_cgroup_id(struct mem_cgroup *memcg)
 	return memcg ? cgroup_id(memcg->css.cgroup) : 0;
 }
 
-struct mem_cgroup *mem_cgroup_get_from_id(u64 ino);
+struct mem_cgroup *mem_cgroup_get_from_id(u64 id);
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
@@ -1293,7 +1293,7 @@ static inline u64 mem_cgroup_id(struct mem_cgroup *memcg)
 	return 0;
 }
 
-static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
+static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 id)
 {
 	return NULL;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d4ac9b527f91..bd2ab72386d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3615,7 +3615,7 @@ struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
 	return xa_load(&mem_cgroup_private_ids, id);
 }
 
-struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
+struct mem_cgroup *mem_cgroup_get_from_id(u64 id)
 {
 	struct cgroup *cgrp;
 	struct cgroup_subsys_state *css;
-- 
2.47.3

