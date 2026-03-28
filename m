Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E63A4F59;
	Sat, 28 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774717210; cv=none; b=HZLEzTBtqPfJLYg+ytzxZ1NQlGUnk0VvI8lpmlzLyeHh7uPDn23M3OCxpOxBtiV7LDgTLYpHbO9R8dSbx4WgpcLagtAUtVeplSXdzzx8btA+GTjzk2se38JZj8yjrFVBcJgBu/2+yT6AdzhDj8da/3neEgyvRQ5M0EwqXbUmedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774717210; c=relaxed/simple;
	bh=s68sSmfGQcwxwE2rGybfBstgYbqH0EAa4djt29SiEG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKX+5YmzBzVOZhASm0emY9DcgI+RNwmA5JD+11/e+0mhihK5RJeFoUi1uZOKad3eY3soUq6PiphcDRp96biigMdycfkohHJUu3UiSPqihNEwhKr6H0gwOgjijjKJCifK5Y3JUf2PFfFV/9oey2QrhfPE+1Yn3zLLST5qC5mxlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDd9S5Ou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDd9S5Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489B6C4CEF7;
	Sat, 28 Mar 2026 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774717210;
	bh=s68sSmfGQcwxwE2rGybfBstgYbqH0EAa4djt29SiEG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDd9S5OuJ+XrVdbfEldX/D5gVlsDPXciDaB1qqqwyNrhejtaEG/W63bYL7YREGfc6
	 x9EdpA1Z5El9Ry9v58C9/tUiM2LYjGAHcHCGzf11Z7CPel/bNsFSZV/GtftxE6gJ0p
	 dtanvwnVTu82ChFGI0CpFcq+LOdntane5xR+FPSXAMTOJgu5ZVtOtpT5ZNqHo0nrHK
	 wV999tiuK0kEtoJFAxoByRTmVCWi2Gae/fjqQw3BYDTx5XeDsW/F+jgLSU0tWxRfb1
	 lcwufXWgJ7wvW18xAlOVsh9S70s5JMDIHehLEZAMNW2iYljQEXNh3dRq76MhcZw5x5
	 bV1ywA0yA8yfw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon/core: use time_in_range() for damos quota window start
Date: Sat, 28 Mar 2026 10:00:08 -0700
Message-ID: <20260328170008.48144-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328163930.47096-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260328163930.47096-1-sj@kernel.org
# start of sashiko.dev inline review
commit 2ee07f5a4fcf25b39aeac61c6b88fe3fdfd0c9b6
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: use time_in_range() for damos quota window start

This commit attempts to fix a stall in DAMOS quota charge windows when
a scheme is deactivated for more than LONG_MAX jiffies. It replaces
time_after_eq() with !time_in_range() to properly handle the extended
time wrap-around.

Link: https://lore.kernel.org/20260324040722.57944-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..8e47183473d3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2452,7 +2452,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  	}
>  
>  	/* New charge window starts */
> -	if (time_after_eq(jiffies, quota->charged_from +
> +	if (!time_in_range(jiffies, quota->charged_from, quota->charged_from +
>  				msecs_to_jiffies(quota->reset_interval))) {

Does this introduce an off-by-one regression that extends every quota charge
window by 1 jiffy?

time_in_range(a, b, c) evaluates the inclusive interval [b, c], which means
it returns true when jiffies exactly equals the end of the interval. The
original code used time_after_eq(), which correctly triggered the new
charge window exactly on that jiffy.

By replacing it with !time_in_range(), the reset evaluates to false on that
exact jiffy and is delayed until the next jiffy. For small reset_interval
configurations or low CONFIG_HZ values, this 1-jiffy delay might alter the
effective quota replenishment rate.

Would using !time_in_range_open() preserve the exact original timing
semantics while still fixing the wrap-around stall issue?

>  		if (damos_quota_is_set(quota) &&
>  				quota->charged_sz >= quota->esz)


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260328163930.47096-1-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260328163930.47096-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
