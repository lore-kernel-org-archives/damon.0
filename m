Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E622BE621;
	Tue, 24 Feb 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771912493; cv=none; b=s0Hd63MqIsnNOpo+XjrD71TcEUDMiTlFSsCuh1YypfmuZKsC3GfgXvBibsw9OVjOxFLoYcpO2SvCMqTYgRFqbU9NQ6SZL7U/j8KHiYvr3SR+01sRRyLJ9dGmsf1ChSiuZG4JjbmAYXrEGUkVPxSMVJp5vtfCaJiXdzjZH0RXWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771912493; c=relaxed/simple;
	bh=A971HzHUjZoXdUvGH9DGwBSAmjxDqW/p+VKNITvjlNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/pONL12Nlf0nfa8xnsn7K8MmiG4g67brbx9KY1IpifF6LBJMe1PsFWHymYqN+U0Dr24br37R34w703epMITPps7RUrVKwywlDIA+QrCmiM+w4pooZ7WbUOWNqgp55zRQ+VL2ms8w11MSLt3wK2mWkjNCECYIbMeioZ7g2cNjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvhkAx8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvhkAx8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CA8C116D0;
	Tue, 24 Feb 2026 05:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771912493;
	bh=A971HzHUjZoXdUvGH9DGwBSAmjxDqW/p+VKNITvjlNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvhkAx8ocOQznuXujhwJUQMmfHgdoCMJR/7N75VR42dvyn68v8tpEsAQvt7WoUkIk
	 Wn53BLn6+Up+ZNLlNn8GN4r5YsWeMgbhTBNgRutwYtixXnkui4xACL4B4WZ+xCDo4A
	 Y2kk0fOSNNHMIwss3Y9tsIdARPOnW5NbzjqLVsd7+BtbGu6FrXgJoDIFWJngYKChp8
	 HV3/qGvKs1ZtJYzg369yYOCPK4qrtJlhNjMJpOFBA4IbYhG4vkeOk/iEajNCe/ujGq
	 4DgAyDFmwTdec4a9+rsCCMc3MgZYghhAEP6EApUGQgl91jOHS0BuVWLducMC5FLASb
	 aUiifcISYu/dA==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v4 4/4] mm/damon: add PA-mode cache for eligible memory detection lag
Date: Mon, 23 Feb 2026 21:54:50 -0800
Message-ID: <20260224055451.58713-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223123232.12851-5-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Feb 2026 12:32:32 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> In PA-mode, DAMON needs time to re-detect hot memory at new physical
> addresses after migration. This causes the goal metrics to temporarily
> show incorrect values until detection catches up.

I agree this can happen, and could be problematic on some setup.

> 
> Add an eligible cache mechanism to compensate for this detection lag:
> 
> - Track migration deltas per node using a rolling window that
>   automatically expires old data
> - Use direction-aware adjustment: for target nodes (receiving memory),
>   use max(detected, predicted) to ensure migrated memory is counted
>   even before detection catches up; for source nodes (losing memory),
>   use predicted values when detection shows unreliable low values
> - Maintain the zero-sum property across nodes to preserve total
>   eligible memory
> - Include cooldown mechanism to keep cache active while detection
>   stabilizes after migration stops
> - Add time-based expiry to clear stale cache data when no migration
>   occurs for a configured period
> 
> The cache uses max_eligible tracking to handle detection oscillation,
> prioritizing peak observed values over potentially stale snapshots.
> A threshold check prevents quota oscillation when detection swings
> between zero and small values.

But, I feel this might be too overfit solution for a specific setup.

> 
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> ---
>  include/linux/damon.h    |  45 +++++
>  mm/damon/core.c          | 421 +++++++++++++++++++++++++++++++++++----
>  mm/damon/sysfs-schemes.c |  30 +++
>  3 files changed, 460 insertions(+), 36 deletions(-)

The size of the change is quite big.  I'm now curious if the problem is
significant enough for this size of change, and if this solution is only the
single and the best one.

First of all, I'm curious if the problem is that significant.  I assume you may
seen the issue from your test setup that you shared with the cover letter.
From my understanding of the cover letter of this patch series, however, you
are testing this on a setup having two complementary schemes.  And you use
TEMPORAL tuner.  The motivation of TEMPORAL tuner was for setup that not having
a factor to move the quota goal value without additional intervention.  In
complementary schemes setup, the schemes becomes such factors for each other.
In the case, TEMPORAL tuner might be worse in terms of the size of temporal
oscillations.  I don't know details of your test setup, but I suspect the use
of TEMPORAL tuner might made the issue bigger than real.

I also assume the real world people may use DAMON with auto-tuning mostly
because they don't know the access pattern of the system and assume it will be
dynamic.  In the case, even if we perfectly solve the issue, some of
oscillation will happen.  So, I think the issue in the real world might be
smaller than that we can find on some specific test setups.

Meanwhile, the node_[in]eligible_mem_bp concept makes sense to me.  I'm worried
if this patch is unnecessarily delaying the progress of the main change.

So, unless we have clear evidence of the significance of this issue, I'd prefer
dropping this for now.  After that, if the issue turns out to be significant or
this solution is proven to be significantly beneficial, from your next more
realistic test setup, or from real world usage after upstreaming of the main
change, we can revisit.  What do you think?


Thanks,
SJ

[...]
