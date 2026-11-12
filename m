Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501830;
	b=I352Go//tdHc7ftQbqZr5mnQzn00xyKOep7hK+MShWenTXq4avGuU4nO3b4XOWBZsuyY
	 EneJl1ibnJGpYbAm3Dga8IbuYkukR4fiWE03R3WnbMP86qC8BtsrYf1OhNWs1ZJM2v2yv
	 jluzX781+BYWQSMfyhrREYzAWX/DaZlFKb1UqfH6H/FFNbBXtPiSHK9I69sDMfRhY/DIr
	 9yPo3ymoYfvKELY/YJHFermmKbFFHxywOQPtxOAjWHV9sacQrWPC2e9vr5DKv4boQO8vM
	 AWW5qxhjhiH+ugNfzpO/VehIqGfHyOwJrSqsNHCCXl+uhbgdNvJdy5ww0JKnZJaXFZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OT3KyYwDV0pkmmBWZVaURf9TIcCa5HYu6d3239mcr10=;
	b=rCFnKpJxFGGS0vQshubk6u64KWAXrfYNFFDlTquWrheMxEl4yKx5d2uADv8PkcLY9gZs
	 /TcD9thP6CIbhi80mbxR0l7aIeH2dcffHalAa9CNWScdORrhQuQ12q3xDXgb6flm6n+Os
	 16AYa1lDig0ikwIw6wfOPiJocYGA65vHue3rHDHEMgym43QlihZQ7JMdWVXsarvnoYZz5
	 Dsx7eP3OCNC+qkL8JMjXNBHFUcxIc/ipgcB4RZ+y/co202/3lIbB+yF0YOWvg20jPUWqD
	 yRxzDA4Qgwl1DxpqqBczCsk1WuaqBLArBEB1BHPhddyn89juHdB+yjv7FQ48OsUoyVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=QVVMykKG;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7A606A32A
	for <damon@lists.linux.dev>; Thu, 12 Nov 2026 16:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFF7A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=QVVMykKG
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b31448caccso807237b3.1
        for <damon@lists.linux.dev>; Thu, 12 Nov 2026 08:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1794501829; x=1795106629; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OT3KyYwDV0pkmmBWZVaURf9TIcCa5HYu6d3239mcr10=;
        b=QVVMykKGTPEiQoyihgoFj+3eKGOY7DHm/KL5Rk7fVjcB7C9q1aEdtWQ+1SB0f/s9/B
         4VUt2eY5I8A0FnLDkM3ptnzReI2+2viGZTCbzdbLBeLnWE2Aa1q0PT0pIzDiRq4NSlSs
         z0BHIcLvAJn6OrN4ubtffhbaztRwcDKHvs++JQw9RcvQU2Cq4jhiiRqz/tSOPjX5tnpH
         6xWf3KKeSWYvykXNBokZeMS5lHhK+9WCBU0I1Cv0ytFmQsML4b27mdsrULVv0l7vKi3X
         8ppgh5ed9gAF0odLDLR0Gpm079ukliR5u62O2YWQpQ87845/qZn9YPPgLo1lmVHrjm0b
         ZoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501829; x=1795106629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OT3KyYwDV0pkmmBWZVaURf9TIcCa5HYu6d3239mcr10=;
        b=YZD9vJLzUs1lLMLSZxOJDwKlNnqr10Ojqd1ZglnyhuaziPLoEtrc6nmSBxVDgYh8jB
         Bp/0PnBwx4QzxxpRVEBQKnOW1yZmlK4w50UlZsadURf7Jck6DgJ3WMWanZT3B5NOEmZb
         WJimMlfJua+kVMhDujcgE5eMjivSCkKFcIvK0GPKfgJFYc6/wR4sPW6ujzZgX/P8MNKB
         NlOBl8aYtEU6mOvykpmzxc6GG1TjY230cLWe7MOIYFbiBQH320U/ty/WbBxWFQMOZUrj
         BqppxYYe1m1HEpvaN8a9wXusqqkUXg2sX6eNbfR4R29KlvLCc17+1Q/ovjRXYHMZWZiw
         nMkw==
X-Forwarded-Encrypted: i=1; AL+hErHTUwwsKgTA3Z2X6AuTrVepBVIuJJNnKXcDOiwbGh82JoE40zdgh5lS0POauCY5nPxCUprHLQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QlUCLgjJ4ey0YwP92QJGlpeCGoJ+wwvkoAJNqUY7U4oJCx99a
	T+/LlwoMYkF6oifNus2+2JlqdKEEc5ShGYL++oLR4zqmY99bF7vH1oSFJnlWtwlRao0=
X-Gm-Gg: AYBFou0fyRcPA+Bftz72KWvb+XzJZVNJARbvId4YnpT8ZzkvrqMEbG/Nxha9vWqT5gS
	iE6pV5t+giK5nQxmOypopG7uIFQFjSIBY8LKcQ+WxkLAnSzUHerrUtjGJb/c0nW1q6DMYnqFBVJ
	RODC1JB63QqF2yfUeybErC2OYWxwrxk/SMZwzf7P/UGVY3ay0LJuuoVgutmpE4N3vU4LlwAcH5V
	JIP9XVJ+Ua8MF4gAR1owi4U8C1v4KZ2Y1XUGfDa1ljPBOHentKdeWY6eWQ4UfCDvmqEHPC2r6eE
	qeh9N6AEANuJRdj4ftIH3ILNSiHALGmSJxiKk/TMwed4INzLwCFoVGkvIwY1pj7ldqoB7WHbVyg
	5mLQJvBi507LpQauwZ+6nVhnggeXQSuAZJdW0UL1asrdQWP8DtNlmw9U+tamIXtcVUTPr8QV5zv
	a/5XUmBlDlh8rbT4T/sgFaqpCxVFlYwUqmYxFSXqyn2Oe/Hdd8VYKF1hpdgU0zRlmv+GQcJCHkx
	J08WdMeV836ut1zHj58VMOTrmd8rta+jWvpLv2CYE7xW2K8bq0enyEydqhJmxUprQSih9oOx3pl
	2QlgQFZkscTCXdpbvIK6K4T2TOa0PHbRoZ4sF1WzmrehXgRq4Q==
X-Received: by 2002:a05:690c:e1d3:20b0:8b3:4f53:91c4 with SMTP id 00721157ae682-8b4aa326b49mr620977b3.29.1794501828827;
        Thu, 12 Nov 2026 08:43:48 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933fb45fsm73764697b3.25.2026.11.12.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:43:48 -0800 (PST)
Date: Thu, 12 Nov 2026 11:43:47 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, yosry@kernel.org, shakeel.butt@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org,
	david@kernel.org, ljs@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 1/4] mm: zswap: fix shrinker count for the root memcg
Message-ID: <avXsw9ZJHOkFG4Ll@cmpxchg.org>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
 <20261110015321.611093-2-joannelkoong@gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110015321.611093-2-joannelkoong@gmail.com>

On Mon, Nov 09, 2026 at 05:53:18PM -0800, Joanne Koong wrote:
> zswap_shrinker_count() scales the number of freeable entries on a
> memcg's zswap LRU by the memcg's compression ratio. That compression
> ratio is computed from the memcg's MEMCG_ZSWAP_B and MEMCG_ZSWAPPED
> stats.
> 
> However, for the root memcg, the zswap entries owned by the root memcg
> itself are never accounted for in the stats (obj_cgroup_charge_zswap()
> skips the root objcg, and before the root memcg had an objcg, its
> entries weren't charged at all). The stats only reflect the entries
> owned by the root memcg's descendants. When the root memcg's descendants
> have no zswap entries (eg when the whole workload runs in the root
> cgroup), the shrinker reports nothing to reclaim for the root memcg, and
> its zswap entries are never written back by the shrinker. When its
> descendants do have entries, the root memcg's entries are scaled by the
> descendants' compression ratio instead of a ratio that includes them.
> 
> Fix this by using the zswap pool-wide counters for the root memcg
> instead. The zswap pool-wide counters cover every zswap entry, including
> those owned by the root memcg.
> 
> This also gets rid of having to flush the root memcg's stats, which
> flushes every cgroup in the system.
> 
> In a VM running a reclaim-heavy workload in the root cgroup with the
> zswap shrinker enabled, the shrinker wrote back no pages before this
> change (zswpwb stayed at 0) and 1016 pages with it.
> 
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
