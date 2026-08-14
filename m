Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AC47A862
	for <damon@lists.linux.dev>; Fri, 14 Aug 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719265; cv=none; b=N8bJAlC6IdsB1TmWhoUhuKIdDYT4uR+diKWxdu0cOGKbLQ3CuydfiOw0ozkWnzIu7UZdGjhHzBjGtYit6AamfDvzzTBkWxw3pC0nBfCLXFFyM/3sBTvEjxfdBJqY2Fn3pz04pqQnQxFJZuLjL9NXyKN/nhccwz/1XMUQprHDg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719265; c=relaxed/simple;
	bh=Q0NuTg++svUFuAT1lop0YRMxfDKQgG2JLoQp22DrqFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFsMQHJ6q34B/4PXWqoe1O5xRGfiSp4gpVZghG6eE2Yu0Ip/vtUFVpkxkFcoXfsZCixpVFZTr5CGeWDLJ1sOWqh6b8DUGuA/oQej0EBaYqEf4O6P+KZfOyuzsmYpKBrqciAdDmXaEoqwFXWEr0Rgym4zl3TvE6V5bxWspWNCX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icnyz1CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icnyz1CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CA51F000E9;
	Fri, 14 Aug 2026 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719262;
	bh=qVwa9W3wNvZdvVfG8ALjTSZQ2WF5kVRRrPid54ltR2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=icnyz1CSGLfhVWu8Q6+5lvLd76s2TnGEWUy2rjdTTlAmTSseWAQu/6DUgc2s6aljb
	 qY0aiVTtkZV0OKyzUrTA6L+BQgZkEO8TXh7ahZ4MDteEKiPPgLdguI09XzuiZ6zjRD
	 4uHOxM5S6gC7WljO315Gg79Ku0rHeyyh6LWh9e+WLhgJJfst0ZC0CKZXP65n/F238C
	 5LhYOARCXDROeM4cI07mtuw0qy8QOedMM3EPcm2XfI+4wKsD3xSJXwNI59QOt8Flxl
	 aUTlO86JmGUdFrOdHJDh8DJn/kNbks+1jC4A0gAB4yGqqZ++gApp7Kr+mfsVmnbXUR
	 j8Jgv8C/zt/Bw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Helping with alternative for watermarks
Date: Fri, 14 Aug 2026 07:54:13 -0700
Message-ID: <20260814145414.91204-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814084710.39955-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Fri, 14 Aug 2026 16:47:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> Regarding the alternative superior feature to replace watermarks [1], I
> am very interested in helping you design and/or implement it.

Thank you for starting this discussion.

> 
> To share my context: I am primarily using DAMON_RECLAIM on my personal
> laptop.  During my usage, I found that using the free memory rate
> (MemFree) as the default watermark metric is highly problematic for
> modern Linux environments, because the kernel aggressively uses free
> memory for page cache.

Thank you for sharing your use case!

> Therefore, I compiled a custom kernel that
> supports monitoring the available memory rate (MemAvailable).  Since I
> understand that the current watermark mechanism is not planned for
> long-term extension, I refrained from proposing improvements to it, and
> instead focused on understanding why that direction is limited.
> 
> I am very interested in understanding the design constraints behind
> deprecating watermarks.  From my current perspective, watermarks have
> these drawbacks as a run/stop mechanism:
> 
> - Mismatch between local monitoring and global triggers: When monitoring
>   a specific target (e.g., via VADDR), the scheme's run/stop decision is
>   currently tied to global system watermarks.  It is impossible to
>   determine whether to run/stop the scheme based solely on that specific
>   target's memory usage.  Therefore, the new mechanism might need to
>   allow user-space to pause/resume schemes based on custom, target-aware
>   metrics.
> 
> - Lack of diverse metrics: Watermarks currently lack support for metrics
>   like PSI or inactive/active memory ratio, even though such metrics
>   might be better suited for DAMOS auto-tuning goals.
> 
> However, I realize these features could probably be achieved by simply
> improving the current watermarks.  Most of the drawbacks I can think of
> are basically about "not enough metrics/customizability".
> 
> I assume there is a deeper architectural reason why you consider this
> direction unsuitable for long-term evolution.  If you could share a bit
> about those constraints, I would be able to think about the new
> mechanism in the right direction, rather than approaching it from my own
> assumptions.
> 
> My need for a more accurate trigger metric (like MemAvailable) and
> always-on monitoring is exactly why I want to help build the new
> mechanism.  I prefer to invest my time in the future architecture rather
> than adding features to a mechanism that is about to be deprecated.
> 
> If you are open to this, I would be happy to start by reviewing the
> design direction you have in mind, and then help with implementation or
> testing where it is feasible for me to contribute meaningfully.

I think watermarks is bettert to be deprecated due to following reasons.  First
of all, it stops monitoring.  It means the converged region age and addresses
information is lost.  This is the biggest problem.  Secondly, we already have
similar and better features including DAMOS quotas.  For your DAMON_RECLAIM use
case, I'd suggest using it without watermarks but quota_mem_pressure_us.

Hence I want to deprecate watermarks rather than improving it.  If we need a
better watermarks, I think we should improve/extend alternatives like DAMOS
quotas, or implement a new one.  But, we should first understand why we need a
better watermarks.  You mentioned you want to use DAMOS watermarks with
DAMON_RECLAIM on your laptop.  Could you further share why you want to use
watermarks, and what was the problem?  You mentioned it was problematic due to
page cache, and you implemented memAvailable based watermarks.  Why you use
wateramrks?  How exactly the page cache usage becomes a problem for you?  Has
the memAvaialble based one solved your problem? 

> 
> [1] https://lore.kernel.org/damon/20260808000739.1308-1-sj@kernel.org


Thanks,
SJ

[...]
