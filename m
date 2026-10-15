Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF993033D8;
	Thu, 15 Oct 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072892; cv=none; b=X/Z72njbpJzrq3Z65eAcX1tEwEc5jBr4icMLbSDNNpuwIJfgSDA9Ekld+tVpBVWusM/PBtCJQPSTvKvig/V71O9MhSOq036WaNEqWl5xtE8B8X3uDPOQOJLSNKei1A0sXP+qC4d4r0NMRZswUp0hOIfDfubllccdBtm7fF0AlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072892; c=relaxed/simple;
	bh=PxPkj8P6sFCU6I5bcGPXvDOZAOCbk8lGJaiHBkYxc6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctl9p2i3pvJnuaG0wPstkQXYZiLSLDotE9lPgY97FdANT1JybrQagFLtt0gUPbjRyGSzpQMvlYymiYJU2RIYjJNf7tlVVVQ35/xVkllQQJ+j7Dr+tYvPkH5sFAW/z+2G4J87sYbAbMebmW/Oi9jj5Dd4vVXVF3NtlRSt9ne22KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT4XHyFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT4XHyFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9621F000C4;
	Thu, 15 Oct 2026 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072890;
	bh=F5GxbzSSJJMmmoCWuuAA7PdJJ+sbINi80CfgoWLf4j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UT4XHyFtHBGn1rRrXjn9SLpSN9MVXDIPuD1KNe/4nwRcGEzR+c7aUSdS6GUbecIjC
	 3RATCfSZhqo1tNCBC6m3Xae6tuUpHgG0LxkW3ihof7Q6/CHgT4dKyqTKBKX/XpI5MO
	 JSC7CDgVddkHyBX6/oEO78op/tAsukNv42hSo5OoCdriN/LHd6ZR6HEGUMdztiDySX
	 kzmMwYaEVGCP/NmbEvih3tL+UxjlvkMdDuHnMu81CNA8cjSK5eWbgk9ErXz/rkpNca
	 pp7PpaFKCTTZdsQWS4q7ShOTCailDTbgcaBG5x5DveBb69I+N02abVxnw0g0DOI8qT
	 AkegIM4UEYbZg==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
Date: Thu, 15 Oct 2026 07:01:21 -0700
Message-ID: <20261015140122.87808-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015080623.808458-2-manuelebnerli@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 10:06:23 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Fix tenses. Replace 'set as' with 'set to'.
> Rewrite complex sentences.

Let's put two sentences in one line, while breaking it for the 75 column limit.

[...]
> @@ -113,8 +113,8 @@ quota_sz
>  
>  Limit of size of memory for the reclamation in bytes.
>  
> -DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
> -window (quota_reset_interval_ms) and makes no more than this limit is tried.
> +DAMON_RECLAIM recordes the amount of memory which it tried to reclaim within a time

s/recordes/charges/  or s/recordes/records/ ?

I'd prefer charges, but my English is definitely bad, so looking for your
suggestion.

> +window (quota_reset_interval_ms) and stops when this memory limit is reached.

I feel like readers might wonder what is stopped.  How about "stops trying
reclaiming memory when ..." ?

>  This can be used for limiting consumption of CPU and IO.  If this value is
>  zero, the limit is disabled.
>  
> @@ -125,19 +125,19 @@ quota_reset_interval_ms
>  
>  The time/size quota charge reset interval in milliseconds.
>  
> -The charge reset interval for the quota of time (quota_ms) and size
> -(quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
> +The quota reset interval of time is quota_ms and of size is
> +quota_sz.  That is, DAMON_RECLAIM does not try reclamation for more than

I think this change is just wrong?  quota_ms is not quota reset interval of
time.  Which part of the original sentence was difficult to read?

>  quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
>  milliseconds.
>  
> -1 second by default.
> +1000 (1 second) by default.

Isn't this (1 second in milliseconds is 1,000) easy enough to infer for
readers?

>  
>  quota_mem_pressure_us
>  ---------------------
>  
>  Desired level of memory pressure-stall time in microseconds.
>  
> -While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
> +While keeping the caps set by other quotas, DAMON_RECLAIM automatically

How about "caps that are set by ..." ?

>  increases and decreases the effective level of the quota aiming this level of
>  memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
>  per quota reset interval (``quota_reset_interval_ms``) is collected and


Thanks,
SJ

[...]
