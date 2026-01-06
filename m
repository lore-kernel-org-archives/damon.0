Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84693376A5
	for <damon@lists.linux.dev>; Tue,  6 Jan 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695168; cv=none; b=RJjnYLLyvJCUfgICK6JuDy/3A82St8w1T0xpVJq8WCbrNOP7LqjNEARa+5WOudGiesPt3S0K70PbTy5DjToswUotl9rv301hkdzOKSxyq9eOlvXeqgPWrBXK22YReZVnWaueBp3o1O1UwEUEjF6CfCK1I8In1I889mzvYk8KWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695168; c=relaxed/simple;
	bh=AaFPGrqWLPKAMN+xtCBNy3vJEkpmfJZ2G74GxmBelnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8f5QRuP2A2+T+TJ3BhzBJjlBiGCBvMqBi8oqVK87NB4h5hI0ofWYke5hV6Ybc7mlkgmU0+xVKcq94EBA809I+8cN3nFsFUl9NKMi322CighODlyoSq2waTzi6ljhfxcYS+leCS0CaERvmx9/mI625J2JOIBruKpUKALobJmNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QP0WtB30; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QP0WtB30"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso5815325e9.1
        for <damon@lists.linux.dev>; Tue, 06 Jan 2026 02:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767695161; x=1768299961; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrYlgSs3aSLf4OO6JdIXAa9ZB/yG8lk++eER1aaE778=;
        b=QP0WtB304v4lzcBHiYvqmqnc/Kd40apHZWN/p2stdGUZVZZ7sOwS6wxrZqPlGRcs3O
         2ZSlOhCjdO/MwmEj4poTOY6GY+NYJSXN31a85wU+F/TN6Ts0AodTNUkiYx7o7kZTBfUW
         uXlPBqqBe78Vi4rMg91mmNckdUwFtrxok4YlxCUs3zug/q3vJOgu6gMoPQgneiJdFkY2
         clFubWb8DP/Re7pYKJRQkUBsj1GVvRN3Q5Fj9EtKclUPAxQjGapLvwudIMq4V5cYtgcO
         3oT97peoX4bUz8EwWCXwewQAJCBUrCTm55aDRnRkDy96QnBdk6rRxAmlmNlDzSw26N/O
         Eeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767695161; x=1768299961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrYlgSs3aSLf4OO6JdIXAa9ZB/yG8lk++eER1aaE778=;
        b=rmjy757kCOF49AyIxCemvzXmSZt2LomigXTVGUyj3k718Ng3k9VE1O0VFTDGj4mxQF
         6BCv4+jfzXCLB4mkKuKOp4Wlb408Havi7sqyybOVsd0TtCPTEQUg41F5yNmpf7tRMZ2E
         jnoGbmy+xJi+xD3p5+3wuPQ9aDa2Li96QLhUQy7kXjPLhq8KdXN/4H3RqQiuvI6XjDY/
         F0piJc6om2bPCxf+MVNMaRPpqsWP8AciIqRJQHdVudM78KjAg93dlsy8VVaHIt63+1yE
         3knLCBzf/BcsJvye3tDzYvu0B+DxP7kV1q6jH+y6Mp8W6ZsFR1YmMpnd9ISympSSLrI2
         TOaA==
X-Forwarded-Encrypted: i=1; AJvYcCV7pGGOfbYRYHi3kBm1xyUTWXvTsao2UePa+/W+34D4sD4v4N8oVALuc1C/eQEX8F2KdDS1YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwroHn5XS3HIXFwTo+5763jZ3EycpMSMU1uBgkSP5izxidChcB
	MyPxivHjmBLTdbMOImKq7xbYT7acyCT88siIP5ilK6I426YOacVn8YVeSJ0GmhdoCE1E72+wYJQ
	GDQsVpnM=
X-Gm-Gg: AY/fxX7JtTtUZkmVLtVHp1g2aUPzibh61rbyrx49iRfmVE1yFCiF3hfyAnXPYVt5Xcd
	89mkeetrrn5Cg1tlqwgajjXo36JrV1MlAVN5AtlV4RBZN6CgXVa0XwwczlP/0j4jWOq2MeDxe46
	FvKmq+uym9CUdwhupR2hhSet2eGZbATg3IxtKTbbj2NPdFaUh1HymkJi0Gejsxnt0mMOoO/rvDJ
	c/Cgf8ZuqCMqsyfAH0bhMWbM3yyJt1JXpbnbbo6eeqHSHswMb20T6NFQTTRYf1gBDReBe6Qyxfu
	tLwTlTnvpzXGB/atQCciY5Oykk2GFafpsRGjBeQv+vP1n7vxobKWlti+5dW2trXUfsnIECFy/op
	r2bunU7NAKkL7XarW9+h9plflroLFFNyuLCczzd3HqMi3/JHj+uRQv6aKpinYtsoqFSmykKFPmL
	M5FriVQxzBspz+GHnnQevyT2Em/TR1dVZurmw=
X-Google-Smtp-Source: AGHT+IFb++SFH+rzxjUyOLzVtbAwCNpIM3DiqRn405rjEU6hdyHt22A9JWXC6Ev1mua/rT+52Ubpuw==
X-Received: by 2002:a05:600c:3484:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-47d7f06dc14mr27492355e9.8.1767695161240;
        Tue, 06 Jan 2026 02:26:01 -0800 (PST)
Received: from localhost (109-81-90-116.rct.o2.cz. [109.81.90.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm3571930f8f.21.2026.01.06.02.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:26:00 -0800 (PST)
Date: Tue, 6 Jan 2026 11:25:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] memcg: separate private and public ID namespaces
Message-ID: <aVzjN5z3w114fNB4@tiehlicka>
References: <20251225232116.294540-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225232116.294540-1-shakeel.butt@linux.dev>

On Thu 25-12-25 15:21:08, Shakeel Butt wrote:
> The memory cgroup subsystem maintains a private ID infrastructure that
> is decoupled from the cgroup IDs. This private ID system exists because
> some kernel objects (like swap entries and shadow entries in the
> workingset code) can outlive the cgroup they were associated with.
> The motivation is best described in commit 73f576c04b941 ("mm:
> memcontrol: fix cgroup creation failure after many small jobs").
> 
> Unfortunately, some in-kernel users (DAMON, LRU gen debugfs interface,
> shrinker debugfs) started exposing these private IDs to userspace.
> This is problematic because:
> 
> 1. The private IDs are internal implementation details that could change
> 2. Userspace already has access to cgroup IDs through the cgroup
>    filesystem
> 3. Using different ID namespaces in different interfaces is confusing
> 
> This series cleans up the memcg ID infrastructure by:
> 
> 1. Explicitly marking the private ID APIs with "private" in their names
>    to make it clear they are for internal use only (swap/workingset)
> 
> 2. Making the public cgroup ID APIs (mem_cgroup_id/mem_cgroup_get_from_id)
>    unconditionally available
> 
> 3. Converting DAMON, LRU gen, and shrinker debugfs interfaces to use
>    the public cgroup IDs instead of the private IDs
> 
> 4. Removing the now-unused wrapper functions and renaming the public
>    APIs for clarity
> 
> After this series:
> - mem_cgroup_private_id() / mem_cgroup_from_private_id() are used for
>   internal kernel objects that outlive their cgroup (swap, workingset)
> - mem_cgroup_id() / mem_cgroup_get_from_id() return the public cgroup ID
>   (from cgroup_id()) for use in userspace-facing interfaces
> 
> Note: please apply this series after the patch at
> https://lore.kernel.org/20251225002904.139543-1-shakeel.butt@linux.dev/

Makes sense to me. Originally I was not supper happy about the private
interface as this should be really private to memcg proper but then I
have noticed the lru code needs this outside and dealing with that would
be quite messy so an explicit name is probably better in the end.

Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> 
> Shakeel Butt (8):
>   memcg: introduce private id API for in-kernel users
>   memcg: expose mem_cgroup_ino() and mem_cgroup_get_from_ino()
>     unconditionally
>   memcg: mem_cgroup_get_from_ino() returns NULL on error
>   memcg: use cgroup_id() instead of cgroup_ino() for memcg ID
>   mm/damon: use cgroup ID instead of private memcg ID
>   mm/vmscan: use cgroup ID instead of private memcg ID in lru_gen
>     interface
>   memcg: remove unused mem_cgroup_id() and mem_cgroup_from_id()
>   memcg: rename mem_cgroup_ino() to mem_cgroup_id()
> 
>  include/linux/damon.h      |  4 +--
>  include/linux/memcontrol.h | 26 +++++++----------
>  mm/damon/core.c            |  7 ++---
>  mm/damon/sysfs-schemes.c   |  6 ++--
>  mm/list_lru.c              |  2 +-
>  mm/memcontrol-v1.c         |  6 ++--
>  mm/memcontrol-v1.h         |  4 +--
>  mm/memcontrol.c            | 60 ++++++++++++++++++--------------------
>  mm/shrinker_debug.c        | 13 +++++----
>  mm/vmscan.c                | 17 ++++-------
>  mm/workingset.c            |  8 ++---
>  11 files changed, 68 insertions(+), 85 deletions(-)
> 
> --
> 2.47.3

-- 
Michal Hocko
SUSE Labs
