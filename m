Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F74A484C;
	Tue, 15 Sep 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483864; cv=none; b=IT3Laf2RCzUJP6oZFiOZVd6/GWscnpmyN33ncdFNfOL9crsRLAQ0BKD41lpkjn7JNbticdCuZa7T1ydN0V9sGft5kZ5ZTKW8fsi329yTqbljpOc6lVPIOrEsBffkhD26FOEuh/tF+DAWeAw6bp4mI+1Jo7OwEWF+jAPdGIyGBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483864; c=relaxed/simple;
	bh=GbbSyHr2WPdiNTlzMyjhdorNjYuq0aryqVOrAU+oFk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6MvmCcWb9kIItCUFgqBDnkTP37viZtj2RF1fuE+uEvwiOm6EzRgHyqiBMV7feNBdlWR6AHQjG0HEFAYtSBCkOykg3als6wMfszhijyfKyjaPWMQ7gqK8iYOr0EaXY4tKWtTviPDfXgTTpp5GEirQ+hDE/I/qs/ZKGnBV8AtZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdc+2Vi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdc+2Vi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37571F000FF;
	Tue, 15 Sep 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483862;
	bh=ttqsgjewLy0H5CGwDqwjIgtkd7bY0dbIELIdhgGk55w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wdc+2Vi/1ypQiG51/JO+tXV3pbsxO/NkGqUD3tomIqmzQmzze/n+eKqveNmAxgCau
	 NqMPFkksYyxt6HPqFVdb/EPHgprhxg0kM/JgjAOVv77Z608felCme8bXd6wj63gTLY
	 MHYHTZ645nB5OseiQk8KF1BvVL1UTO+0c2B9XERzr59c4KenAifLD/fHEpWhqUL9Ix
	 ACFCu4ok6KqS88NKR0jJnoc2EG7B3H647q7XN/d56TIzHmcFzCWBP4ukICBUJXw1QJ
	 UhsjEix0AGf91Ce3xRC4pEq3grND5Pi3EjlHxGM+ciQfyGge3J/POPwOwSyXEYGvzb
	 QGCmWjvlxVT/w==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not achieved for the temporal tuner
Date: Tue, 15 Sep 2026 07:50:54 -0700
Message-ID: <20260915145054.92001-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915060937.3423-2-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Karl,

On Tue, 15 Sep 2026 08:09:36 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> A newly created or committed PSI quota goal has no previous sample.
> Commit a68878f83ae6 ("mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total") scores the first tuning round as
> achieved to preserve the consist tuner's quota, since the feedback
> loop returns its input unchanged at that score.
> 
> The temporal tuner sets the quota to zero for an achieved goal. This
> skips the first charge window and the window after each goal commit.
> Committing the PSI goal before every tuning round keeps the scheme
> idle indefinitely.
> 
> Score an unmeasured PSI goal as not achieved for the temporal tuner,
> so a new scheme can run in its first window. Keep the consist tuner's
> behaviour unchanged.

Good catch, thank you.

> 
> Fixes: a68878f83ae6 ("mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  mm/damon/core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 06cf2ab7e97d..e6d87fd3992e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3161,12 +3161,18 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  		break;
>  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
>  		now_psi_total = damos_get_some_mem_psi_total();
> -		/* uninitialized last_psi_total; make no effect this round */
> -		if (goal->last_psi_total == U64_MAX)
> -			goal->current_value = goal->target_value;
> -		else
> +		if (goal->last_psi_total == U64_MAX) {
> +			/* uninitialized last_psi_total; make no effect this round */
> +			if (s->quota.goal_tuner ==
> +					DAMOS_QUOTA_GOAL_TUNER_TEMPORAL)
> +				/* an achieved score would zero the temporal quota */
> +				goal->current_value = 0;
> +			else
> +				goal->current_value = goal->target_value;
> +		} else {

The intention is to make no effect this round.  Setting current_value to zero
to temporal tuner means it will now have highest quota it could have.  If the
effective quota before this was zero, it gets an effect.

Ideally, we should somehow remember what was the last esz and keep it.  I have
no good idea for doing that with minimum change.  This is a corner case in my
opinion (correct me if I'm wrong) so I want to keep the change as simple as
possible.

If there is not easy way to do that, I think just keeping the behavior but
making it explicitly explained might be better.

What do you think, Karl?


Thanks,
SJ

[...]
