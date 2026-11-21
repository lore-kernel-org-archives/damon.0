Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226012;
	b=WOYWBp8ZBYxdYWl0gRIvFiG+VM/M7ELYS40amw5OLWYmhzXm9zSGUmcLM4Lof2CEG6F4
	 g/kPlnYeuvIvz34zF95GOhmRgXuBGVaqYhR5K/JM4sWGcDrd+AjaIsYC+/jzhyfQp66WF
	 QRnBdWspT/xnwEXR7CgFqfcuf4cH+NW4YoduGFgHVUASJ+uvt6gPsFvheVUpNszw2+f98
	 quPh+f+CeA1JhapoQmkbvk54Mw/Zi38zXoz9OZsKthYRU33DmQHfnGpXveQcuIxOgo7ej
	 Imp7saW06W9HDZLtJgCwmNWI3oAj3A1I7feRpvGzlizqZhyC+CXY8BYQQLpjD6fndVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EFeLlw2MWa6op+6humMbJWZtrLF8Qga0uCnT3clDGps=;
	b=iuOnr7a79OzhGpzj7dS8XddBXCzdqknS1hX5i2VBP3FOle3ubcjlvT6p+arFRaxGIGJV
	 qvkz8LSCaYH6YsijVjuuq4yq23YuC4DB4ZVgcwCj8g+nX75ITQ++qEvyYp5ipcznT9TOL
	 o3DugbN5+3z62Sg5xlETiffLQcNslbVgVnfunigTmC8KvoLrRT0ejujqfFTZRltvC5dxB
	 JWB10Vgd3FJZg86AzhVH9L+Fi6DzuXNlnEpV6WTMCPAuCVVZJNKBkfvTN8l6XX0FHydeI
	 cbsuc0vWxYahwdsKab0VgFTxM428zu7M4/SI8M5qQuzh0tQOzKwy82G0XrL92I49v3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4Wb4ArS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBD606A6A5;
	Sat, 21 Nov 2026 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4Wb4ArS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8415F1F000C0;
	Sat, 21 Nov 2026 01:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795226011;
	bh=EFeLlw2MWa6op+6humMbJWZtrLF8Qga0uCnT3clDGps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4Wb4ArSVa1bTRJA0LEoIpw/y9SHCqlT4fV6u493WAyH0spPqZOE0/xx5WpZCkmn8
	 7HHSlJYJC+MPYvfbMUMAhoad19ediwAhBaL7lKwaWS48a+VimJo1wdXRTFSbgtriDZ
	 56Uq5Lh8632q2i3T+26xtjcaNakNYVUpZsAemJx6VL6VTpBxT7x92H3+VU6i2A0+Kw
	 M4qO63Du6AYfalTfY7jwGbgcJHGRaauUrHOZ582ZsntX1upuv79y3poRs3doKvmdHR
	 QOevGbEwLMPn9s+ddbM5O4cumr5a47DAFPL4QQySWTHylhRkzq2RDiwMg2/jlc1DKa
	 E4FHZlepGAUEg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	arijit.desaii@crusoe.ai
Subject: Re: [RFC PATCH 0/4] mm/damon/reclaim: enable auto-tuning features by default
Date: Fri, 20 Nov 2026 17:53:23 -0800
Message-ID: <20261121015324.83753-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120060741.92121-1-sj@kernel.org>
References: 
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

On Thu, 19 Nov 2026 22:07:34 -0800 SJ Park <sj@kernel.org> wrote:

> The initial version of DAMON_RECLAIM was supposed to be used after
> manual tuning of its parameters.  Among the parameters, the monitoring
> intervals (sample_interval and aggr_interval) and the coldness threshold
> (min_age) are particularly important to be optimally tuned.  The optimum
> values for the parameters tend to be highly dependent on the workload
> and the system.  Hence no small amount of tuning efforts are required to
> each DAMON_RECLAIM use case.
> 
> To reduce the tuning efforts, we recently introduced two auto-tuning
> features.  Intervals auto-tuning (autotune_monitoring_intervals)
> automatically tunes monitoring intervals to provide practical and
> efficient monitoring results.  PSI-driven quota auto-tuning
> (quota_autotune_feedback) automatically tunes the coldness threshold.
> 
> Because the auto-tuning features were introduced after the initial
> version, the features are disabled by default.  That is to keep the
> default behaviors unchanged.  However, enabling the auto-tuning features
> is only expected to provide more benefit to the users.  Disabling those
> by default only makes the adoption of the features slow.  Also, it is
> difficult to imagine real users who use DAMON_RECLAIM with its default
> parameter values.
> 
> Enable the auto-tuning features by default.

My colleague, Arijit, found this is not a good idea.  He is now working on
proving the theory and making a patch.

DAMON_RECLAIM receives the coldness throughput via 'min_age' parameter, which
has 2 minutes as the default value.  DAMON_RECLAIM converts that into the
number of aggregation intervals for the time, and set it as the min_age_region
of the damos_access_pattern for its reclamation DAMOS scheme.  DAMON_RECLAIM
does the conversion when it starts working, or a parameter is updated online,
using commit_inputs parameter.  It doesn't update the min_age_region value when
the aggregation interval is auto-tuned.

This patchset enables the intervals auto-tuning features so that the
aggregation intervals span from 100 milliseconds to 200 seconds (up to 2,000
x).  As a result, the effective min_age can span from 2 minutes to 4,000
minutes.

In usual real workload, the auto-tuning converges the aggregation interval to a
few seconds (20-200x).  The effective min_age will be about 40 minutes to 400
minutes.  Even on long term real world workload, that could be too much
threshold.  The user will show DAMON_RECLAIM is reclaiming only unexpectedly
small amount of memory.

PSI-driven coldness threshold auto-tuning can make the effective min_age only
longer, so it doesn't help.

One strightforward workaround would be setting the min_age a small value, like
2-4 aggregation intervals (200-400 milliseconds).  Then, in usual case, the
effective min_age becomes 4 seconds to 40 seconds.  It might feel like too
small threshold.  PSI-driven coldness threshold auto-tuning will make it
better.

Yet another workaround would be monitoring the auto-tuned interval and update
the min_age online, using the commit_inputs parameter.

We introduced age_ms DAMOS filter type [1] to fix this kind of issue.  Long
term solution for DAMON_RECLAIM would be modifying it to use the age_ms DAMOS
filter instead of the aggregation interval based min_age_region.

My colleague, Arijit, is working on the long term solution.  Until it is
arrived, I will keep the RFC tag of this patch series.

[1] https://lore.kernel.org/20261106020559.98352-1-sj@kernel.org


Thanks,
SJ

[...]
