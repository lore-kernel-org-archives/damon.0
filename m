Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAEEEC3;
	Wed, 16 Sep 2026 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518106; cv=none; b=Lgtzkzunt5An/vLmjrUMHtB1k65EHA5OPF5+0tiy86Gbib5UoKzvm96O/wl1jTe8IEFvIULQzlqM3EUHAoq+zEzOUvfxrXewblAVfZhQnFZp2mg5al/Suf9UjDnIp1hUgYhISPjqJcWnt9ECDvFwJ6asyLPh1y6m4zmzwevP2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518106; c=relaxed/simple;
	bh=PNX3JszDIxlUZBDCC/I74/uD3IxHmY2sRGm87S7EsT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj4pNOdqRmzlVNtTHwlscXKhfvSwgwqinzpt1+tByRjsqOI5epqNXuXIrXaqs8TKZv3PDbpVrecTBRUN8+Fa/9oZdv655heZZk/ki9ciKKCeW1i0h2X1qAXEaXHoRO+nq8OMngBQDlmmcfOi5/RBTFu3b5CVnhjM7ncq6pGkDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8uyB34Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8uyB34Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4563C1F000FF;
	Wed, 16 Sep 2026 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789518104;
	bh=G4LowGoWNcdFj3OSfkotqiKzOTNUTztLfprpysOi+bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8uyB34Yay2zuDDBEnWmf6i9iYa0SBIDA+SwSJ8zI2PeKeWIewnl2eoVqeJgo6I6k
	 X2WYvc+6po4JPforGzAWrO6IljvYaL6duWElvitQSNLuY9TOzKFvYa0Wk3kJ47Z+Fc
	 kNlZNUYmma+CW3DQ2FRWTUd24BCMJDPn1LS9/aphG24Uew66N8dBiv9CJxw3nCwW/Y
	 O3VKZT2glvNxOZS8WOpJGk/PcBuzn6hkR0qUKb7bNQFMnc8ledAwA5UVYzxAbm8Ivr
	 +RtmiiW6mcSKrDEOGx7wx/fdhxhWts5OrUrEzbHWrRTskBtus+jJUKJnx9SfM49Yvl
	 e5I7ljHeqATWg==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test PSI goal rounds under the temporal tuner
Date: Tue, 15 Sep 2026 17:21:36 -0700
Message-ID: <20260916002137.101195-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915060937.3423-3-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 08:09:37 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> Exercise a PSI quota goal under the temporal tuner on its first
> round, its next measured round, and after a goal commit. Use
> ULONG_MAX as the target so the goal is not reached during the test.
> Then check that a measured round which does reach the target sets
> the quota to zero, and that the consist tuner keeps its quota over
> an unmeasured round.
> 
> Without the previous patch, the first and the post-commit checks see
> a zero quota.

Thank you for adding this test.

> 
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 69 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index c01e6a75cadc..2b9b24ce7dad 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -889,6 +889,74 @@ static void damos_test_commit_quota_goal(struct kunit *test)
>  			});
>  }
>  
> +/*
> + * Unmeasured PSI goals must not disable the temporal quota.
> + * Keep sz * 10000 within a 32-bit unsigned long.
> + */
> +static void damos_test_set_effective_quota_temporal_psi(struct kunit *test)
> +{
	[...]
> +	/* fresh goal, first tuning round */
> +	damos_set_effective_quota(c, s);
> +	KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);
> +
> +	/* second round: last_psi_total is initialised now */
> +	damos_set_effective_quota(c, s);
> +	KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);

So, this test depends on the memory pressure level of the testing system?  I
concern if that could make the test result not very reliable.  Maybe we could
split out the corner case handling logic to explicitly receive the current
memory PSI total time.  For example, like what I suggested in the reply to the
first patch of this series.  With it, we could build a kunit test for only the
target logic, without depending on the test system's status.


Thanks,
SJ

[...]
