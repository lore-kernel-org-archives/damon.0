Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638A26B75B;
	Sun,  5 Apr 2026 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430370; cv=none; b=FweURr5+o9L9hDQ5CcSyfcIru6anijUAlsy6Ith5Bze6bRKKT7KAqCHwE3DoP1VSZn5lf7Gz1uHqJ1x5UPHByrXFvcTIxJYK5OICHzk60H8JJ6nixo9VdS+Cev9kC7Hv0kQqTLbDGEblfI2+SQ9siv6KaCTiqtg3IAEFUNBKz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430370; c=relaxed/simple;
	bh=pP6Lsj6XqQDkF7uu3oeV1rYB/xOwRq5U4UDN4zrHvtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUqd4Kbl0mQnVpyHuItSTRk9aT//I0fyOzm0iEaVkq6YHvHq+4Lvq1vaWm4FpLOE/14TGdsnFzRye/li69w6HI64hUaWS0++oBMW8uJIpPMZsAqV3UpSdPJP46T4w9I9Ifd7TsXNYMvwM4U0diwR6dJQ+j0Oxx0bUu+r8QeBZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URmIvhmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URmIvhmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41287C116C6;
	Sun,  5 Apr 2026 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775430370;
	bh=pP6Lsj6XqQDkF7uu3oeV1rYB/xOwRq5U4UDN4zrHvtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URmIvhmrOUP/ERm1/oiysBSdneWuMSjg4ZZWcidG+FATwxXRAl3hP+aNiUKkFhaRD
	 RciBUIYsdyoWuXw8tUXQ8NwdE+B2U27El6OU9rTl7wuOxYVOW7/PPJ1KumY0OC4Mlw
	 JQd8eRgv4FIi2aM4dFhCiqWapwvvo3KRy0ytOCdEx0PtlbhPQ1AhVAWczlbYZMEaiE
	 oCSH0DQ8WO8jWCnfHFzXJPqphIknoiFlwaAnjQmUN4JOR6W2xqTCGRvTCZ2+utlF6y
	 OuxgzzKkKAx8c6iOpW5xhUCSY5VlJvNgT3I/7ps37WoAmeCXlmlpkaqfulEqVz2JSO
	 FMaYYpFjZ3CFg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sun,  5 Apr 2026 16:06:01 -0700
Message-ID: <20260405230602.118036-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402011043.67218-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  1 Apr 2026 18:10:42 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 23 Mar 2026 21:07:21 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 23 Mar 2026 18:28:00 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > Forwarding Sashiko review for doing discussions via mails.
> [...]
> > > Additionally, when the context is paused, kdamond_fn remains in this sleep
> > > loop and skips calling damos_adjust_quota(), which means quota->charged_from
> > > is frozen.
> > > 
> > > If the pause lasts for more than LONG_MAX jiffies (e.g., about 24.8 days on
> > > a 32-bit system with HZ=1000), will system jiffies wrap past the half-range
> > > limit of the unsigned long type relative to the frozen timestamp?
> > > 
> > > If this wraparound occurs, time_after_eq(jiffies, quota->charged_from +
> > > interval) would evaluate to false when unpaused. Would this cause the quota
> > > window to not reset for another 24.8 days, accumulating charged_sz and
> > > blocking the scheme from being applied?
> > 
> > That's a wild corner case, but I agree it is better to avoid the problematic
> > case.  I'm still thinking about the good way for that.  Anyway, I will address
> > this in the next spin.
> 
> The root cause of the issue was introduced before this patch, so I fixed it
> with another hotfix [1].  So next spin of this patch will have no change.

FWIW, I'm planning to post the next version of this series only after rebasing
to the latest mm-new, after the all MM pull requests for next -rc1 are merged.

> 
> [1] https://lore.kernel.org/20260329152306.45796-1-sj@kernel.org


Thanks,
SJ

[...]
