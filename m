Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792871567;
	b=KUZhS/5njHlZ5+JbE4et/Lk8pS5SlKTl5CaIv+3OcySYMIXNFeVluTJf9C/rIwqMXhLa
	 Fhoi+cFFWFN2ozj7Z4x/+yi/XE77hTBuptQ03krA8eNcyqCWtjw0anV5ryRN/zj4EW8fF
	 T4fS4ithfXINc3lH0olBbwZxDasR7gQ0kwvgjQoOOJYFaHUqJSD4LbOUTMee3Aa/zKxff
	 ZeSagY7L5Gqqy8wnCWcE5WnV9GCEYYyFl4hRiP6Ehs9GItPmeLjlIw1DgX066ubbmfhtn
	 PEavNgywkJsHVuTT4WVrSLuvghMSYCRp+0eUrN+QML9F+Tnt/VTmZvnswyGsumOVESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792871567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fbMLNJ8GIZwcr4gCLnTsgDF+nSjrSwkPflLsa6GOuwI=;
	b=eqxSDyK2CSLKaQrSdLn+IXHOuvLrfNthou+lcoaxE2qg6qShKW0z+ZDzZ3v1Bke8OrEw
	 5yyP9bCkM+p798+55Wa+Si4sAVCfLRhykFeu7mFdE7J0kr+p/76HzBYaCEEwdDfcBvMUV
	 alS72KKhqvqZZOJ9nstvTN2H7NE3MqdB5P6EKcAymOQDt/XKI4Sx7vc2G8J3oz5OkG2Wv
	 dxzwOnPGb4TIgvYRp2w59iCRoGoDMNMTz0XaDc3EWQ9ABe+mkGSgzvZ0AozvM1In6N1/5
	 Yj8I47noD1daWJmZhrCtDWGxgv3iNsyUNi5DuTrqtdGsGG4RnDVEWCVmQwtyLT7QUvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObX6vXqH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FD606A31A
	for <damon@lists.linux.dev>; Sat, 24 Oct 2026 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObX6vXqH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8341F01825;
	Sat, 24 Oct 2026 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792871567;
	bh=fbMLNJ8GIZwcr4gCLnTsgDF+nSjrSwkPflLsa6GOuwI=;
	h=From:To:Cc:Subject:Date;
	b=ObX6vXqHg2s/zpUMl4hT+88FaOjdgvQWczA4+X7qW6F7ts1fJSJsiw8lBh9Z5TYI3
	 dcudk6MsM3OxKWWOLm7ETBMEfOSdaz0pEfEzGwtyngFCCmgv5Mr8PUe5Zn9+g2NBdq
	 hnBQcNuqO203gt727JNxTYqikWTiOthGoBR1sSDOkFhyUEb22A1fSlMtCq0VTe5WZJ
	 0EmccuP7/Xyfq2umGhXzIXiXDGQc9KpHL25IaLLfsUy1VcFuWaynsrYeOPIaBzGBRy
	 8g33+tXm3BNslxfou1JVlvwVhbplzjekbe0t1vWoimudekJ3WxDMtu17IZSrr6wGg/
	 ElDBN8+R8te7Q==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>
Subject: [False Bug] mm/damon/core: uninitialized boolean fields in damon_new_scheme()
Date: Sat, 24 Oct 2026 12:52:39 -0700
Message-ID: <20261024195239.87431-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


Sashiko reported a bug that I believe a false positive.  Sharing the report and
why I think it is false in usual mail format, to get help from more eyeballs.

Sashiko report:
https://sashiko.dev/#/bug/linux-b6222b1f-1973-4211-b3cc-048298d29abe

> In damon_new_scheme(), allocating a new Data Access Monitor (DAMON) scheme
> object without zero-initializing memory leaves the boolean control fields
> core_filters_allowed, core_filters_default_reject, and
> ops_filters_default_reject uninitialized.
> 
> Because the underlying allocator (via kmalloc_obj) does not clear memory,
> the allocated struct damos contains garbage values for any field not
> explicitly set. While most fields are initialized during creation, these
> three control fields are missed. Although they are typically populated
> later during kdamond startup,

So, no issue is really happening.

> leaving them uninitialized creates a window
> where early access through sysfs or debugfs inspection interfaces evaluates
> indeterminate state. This results in incorrect state exposure or unintended
> DAMON filtering logic if evaluated before the daemon fully initializes them.

I understand this is not a report for a real bug, but a recommendation to
initialize those fields to prevent possible future bugs.  I don't really feel
needs to do that for now.  In my opinion, doing something that not really
necessary in favor of preventing something could only confuse code readers and
hide real bugs.  We can revisit if any real bug happens.

> 
> // mm/damon/core.c:689-728
> struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
> 			enum damos_action action,
> 			unsigned long apply_interval_us,
> 			struct damos_quota *quota,
> 			struct damos_watermarks *wmarks,
> 			int target_nid)
> {
> 	struct damos *scheme;
> 
> 	scheme = kmalloc_obj(*scheme);
> 	if (!scheme)
> 		return NULL;
> 	scheme->pattern = *pattern;
> 	< ... >
> 	INIT_LIST_HEAD(&scheme->core_filters);
> 	INIT_LIST_HEAD(&scheme->ops_filters);
> 	scheme->stat = (struct damos_stat){};
> 	< ... >
> 	scheme->migrate_dests = (struct damos_migrate_dests){};
> 	scheme->target_nid = target_nid;
> 
> 	return scheme;
> }


Thanks,
SJ
