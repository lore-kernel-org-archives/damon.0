Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128552FAF
	for <damon@lists.linux.dev>; Mon, 30 May 2022 16:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397C9C385B8;
	Mon, 30 May 2022 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653929810;
	bh=D0OLsrOL0CSZt0TW+pAzxo6uAd6kEtYLd7cEs1qfllU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RD4I0Tq4cVWE338ctzZB15LZHOxGr6Eoc1UIM6WFCB4/4s+yLSoQH2IWN/2XQICf5
	 2p6kX0/xkzZLIQc6WyVXmTyGypmRltZmBslh3LOWHLfKPieFA8OTLonvOfhSW1qNmk
	 ndC+WohUtRkBPt2VkyLvD5fH1IjPvJg1+KbWTPeheXTBtQOKt4O9glBI1FJqACtPVl
	 9zTKJcV9OZgH398Lsm7uaYBJup+LbVifWbaFK3IRKbMuw9eG8FjhR6WwOIZ7cB++8w
	 q9Z4zoVgsutKdZV90TjmsICUcniwPmoXtCMAxRvITQuvX/BgMD/RaX9XBRMy93ZOHI
	 oxdsiMSMG8TQg==
From: SeongJae Park <sj@kernel.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: remove obsolete comments of kdamond_stop
Date: Mon, 30 May 2022 16:56:48 +0000
Message-Id: <20220530165648.2921-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530022016.11771-1-zhouchengming@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chengming,

On Mon, 30 May 2022 10:20:16 +0800 Chengming Zhou <zhouchengming@bytedance.com> wrote:

> Since commit 0f91d13366a4 ("mm/damon: simplify stop mechanism")
> delete kdamond_stop and change to use kthread stop mechanism,
> these obsolete comments should be removed accordingly.

Good point, thank you!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  include/linux/damon.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 7c62da31ce4b..fa1c2968b1dd 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -397,7 +397,6 @@ struct damon_callback {
>   * detail.
>   *
>   * @kdamond:		Kernel thread who does the monitoring.
> - * @kdamond_stop:	Notifies whether kdamond should stop.
>   * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
>   *
>   * For each monitoring context, one kernel thread for the monitoring is
> @@ -406,14 +405,14 @@ struct damon_callback {
>   * Once started, the monitoring thread runs until explicitly required to be
>   * terminated or every monitoring target is invalid.  The validity of the
>   * targets is checked via the &damon_operations.target_valid of @ops.  The
> - * termination can also be explicitly requested by writing non-zero to
> - * @kdamond_stop.  The thread sets @kdamond to NULL when it terminates.
> - * Therefore, users can know whether the monitoring is ongoing or terminated by
> - * reading @kdamond.  Reads and writes to @kdamond and @kdamond_stop from
> - * outside of the monitoring thread must be protected by @kdamond_lock.
> - *
> - * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
> - * @kdamond_lock.  Accesses to other fields must be protected by themselves.
> + * termination can also be explicitly requested by calling __damon_stop().

'__damon_stop()' is a static function, so mentioning that here makes no sense.
Let's mention its wrapper, 'damon_stop()' instead.

After the change, you could add

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> + * The thread sets @kdamond to NULL when it terminates. Therefore, users can
> + * know whether the monitoring is ongoing or terminated by reading @kdamond.
> + * Reads and writes to @kdamond from outside of the monitoring thread must
> + * be protected by @kdamond_lock.
> + *
> + * Note that the monitoring thread protects only @kdamond via @kdamond_lock.
> + * Accesses to other fields must be protected by themselves.
>   *
>   * @ops:	Set of monitoring operations for given use cases.
>   * @callback:	Set of callbacks for monitoring events notifications.
> -- 
> 2.36.1
