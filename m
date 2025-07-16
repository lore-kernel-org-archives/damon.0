Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F0374D1;
	Wed, 16 Jul 2025 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752634281; cv=none; b=QExbqZYGk7Glb6njcWwmLzmkQKSxrTJKcACc8fCHd6TfEp5aHKgHSAprYe9qKGdQmXTfXail5GtIseIrndSZTy0tlDXXOmmpN7RSe0563DgcRJrlsK6g8nXjYaxWFPllRyOJ3ZdsUrwJ5acWHnynGWC4kX6IhFgju7SsPGJ2BDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752634281; c=relaxed/simple;
	bh=d+O5NiaQs+zx9yRlpf28fAQcJ8qetUFQCeuXtqJaeKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbCNJPXtL5R+4Veku7NFTBE/YPOoflfZ2a/QKIhckn8WW2UFyJt5JRxs4pKgBt1ayLkymibgaF6i1a5P6IY12wDzQFlNO0J4Ldzi5nU9a8pvUGK2S1qG7HYoEqjrJN6489pXQt9Qg2Ew/3XQhT+YEbW5y0mXXkYe03qw0Lf/vDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOX9ZdPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOX9ZdPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A9CC4CEE3;
	Wed, 16 Jul 2025 02:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752634281;
	bh=d+O5NiaQs+zx9yRlpf28fAQcJ8qetUFQCeuXtqJaeKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOX9ZdPai/j9Cng6NxjH2iKFhdAIGa6B4z7xP99jRkvB+yAobcc2tzZGO7nBtHhqO
	 zZbzMxEMvqyc9AhrsrT/fmvgQ7PFnMEwORNXP+tDfxjjUI2lJPJFGdyPvS1Ask+eQh
	 0HQdLSIV2/YYM156SGajMMACqYWD4Cy5O0i1jUv1IIWbeLbbhW7NCUZHThH6GyP2Kx
	 I6VMl1dOkIs6Q3H9jnF7S43iT3fbj8NlDy7xgXbcIZ9i7eyKhwXQ8Rh+ieVeVU9Qkj
	 De3Wg/XzWphS6eZOpINBBgLuHcKLHz9lIolZDVYmUpRVe4a90SNNiP1khJyI2cvyCu
	 Yi2+/HDKCNjcg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: support periodic and automated stats update
Date: Tue, 15 Jul 2025 19:51:18 -0700
Message-Id: <20250716025118.92544-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <5d1aa6f2-fa5f-4cc2-a3c7-3b5144391524@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 10:58:06 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On 7/16/2025 8:43 AM, SeongJae Park wrote:
> > On Wed, 16 Jul 2025 07:20:57 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> >> Hi SeongJae,
> >>
> >> On 7/13/2025 5:46 AM, SeongJae Park wrote:
> >>> DAMON sysfs interface provides files for reading DAMON internal status
> >>> including DAMOS stats.  The content of the files are not automatically
> >>> updated, though.  Users should manually request updates of the contents
> >>> by writing a special command to 'state' file of each kdamond directory.
> >>> This interface is good for minimizing overhead, but causes the below
> >>> problems.
> >>>
> >>> First, the usage is cumbersome.  This is arguably not a big problem,
> >>> since the user-space tool (damo) can do this instead of the user.
> >>>
> >>> Second, it can be too slow.  The update request is not directly handled
> >>> by the sysfs interface but kdamond thread.  And kdamond threads wake up
> >>> only once per the sampling interval.  Hence if sampling interval is not
> >>> short, each update request could take too long time.  The recommended
> >>> sampling interval setup is asking DAMON to automatically tune it, within
> >>> a range between 5 milliseconds and 10 seconds.  On production systems it
> >>> is not very rare to have a few seconds sampling interval as a result of
> >>> the auto-tuning, so this can disturb observing DAMON internal status.
> >>>
> >>> Finally, parallel update requests can conflict with each other.  When
> >>> parallel update requests are received, DAMON sysfs interface simply
> >>> returns -EBUSY to one of the requests.  DAMON user-space tool is hence
> >>> implementing its own backoff mechanism, but this can make the operation
> >>> even slower.
> >>>
> >>> Introduce a new sysfs file, namely refresh_ms, for asking DAMON sysfs
> >>> interface to repeat the essential contents update with a user-specified
> >>> time delay.
> >>
> >> Thanks for working on this, but I have a few questions.
> >> 1. Could you please list up what are the "essential contents"?
> > 
> > Thank you for asking this.  The contents are auto-tuned monitoring intervals,
> > DAMOS stats, and auto-tuned effective size quota.
> 
> Thanks, but I meant the specific list of damon knobs refreshed.  If there are
> too many knobs, then don't have to list them all.

I guess you are saying about sysfs files?  Yes, I think listing those all is
unnecessary.

> 
> > I will add these on the next version cover letter.
> 
> Thanks.
> 
> >> 2. Does it mean that it is different from writing "commit" to "state"?
> >> 3. If not, then is there equivalent action to writing something to "state"?
> > 
> > "refresh_ms" works same to other DAMON parameter files.  You can set it before
> > starting DAMON, or "commit" new values (including 0 for turning this refresh
> > off) in runtime.
> > 
> > I'm not that confident if I understood your point very well, especially what
> > "it"s mean.  Let me know if I'm misunderstanding something.
> 
> I mean writing "commit" to "state" refresh all knobs,

Assuming "knobs" mean sysfs files, this is incorrect.  Writing "commit" to
"state" passes the parameters written on appropriate files to running kdamond.
It doesn't update any sysfs files until a "update_*" keyword is written to the
"state" file.

> but it seems "refresh_ms"
> internally refresh paritial knobs so I was wondering what are refreshed and what 
> aren't.
> 
> Regarding the "equivalent action", I was also wondering if there is a command
> that works same as "refresh_ms" internally does among the command below.
> 
>    update_tuned_intervals
>    commit_schemes_quota_goals
>    update_schemes_stats
>    update_schemes_tried_regions
>    update_schemes_tried_bytes
>    clear_schemes_tried_regions
>    update_schemes_effective_quotas
> 
> https://docs.kernel.org/admin-guide/mm/damon/usage.html#kdamonds-n
> 
> In other words, if there is the same command listed above, then users might be
> able to run a script that regularaly write the command to the current "state"
> even without this "refresh_ms".  I know having "refresh_ms" is much better
> though.

Thank you for this nice question.  Yes.  Enabling "refresh_ms" is roughly same
to periodically writing
"update_{tuned_intervals,schemes_stats,schemes_effective_quotas" to "state"
file.


Thanks,
SJ

[...]
