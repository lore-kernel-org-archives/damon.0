Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0635975
	for <damon@lists.linux.dev>; Thu, 26 Jun 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951636; cv=none; b=u2FDaX4EVWqNwt1HRpRdWXL0Wrmm7VbWbqlQ9AvhRNfRYppiy3aO9sRpHkaCXKw/j1+MY5qVW0A4Gr414F9uUwk83XVmh0hMzowdy5DLATHnN09R721/1NYpB0yTl0nMF8LApz3I+JcEPAHhfHvsia1xo7+SSGNkgHOIjIZ0y4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951636; c=relaxed/simple;
	bh=7bEQjpoE3Zx5yVy9HF7Vo3sOAzETOsPIYEhDfTzYJ2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0aMqF6Tc7schC6DtsWTxzinbVm0nAuqP5+p9aDSAQecaPmWYOSub7ArWcMb9pzS8Nz4tOD8BSE+VflEJXTTYpJks6UIed+9Ub/mBzeDlSlO6Hq4FVpt/ytVYAbOqIhsdFS7PmxU9HqP/JzJzp/8nAK+0gUDojKrCzD4Q0vxdiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cai0sXOs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cai0sXOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EDEC4CEED;
	Thu, 26 Jun 2025 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750951636;
	bh=7bEQjpoE3Zx5yVy9HF7Vo3sOAzETOsPIYEhDfTzYJ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cai0sXOsyySQh7hrHfTuGgoPeGqZlpttfsnYMIceh1HIDWKllKXbTUtd4pXziSGQb
	 gWJebCySEEZmqpqR2CUMT4Wr409JCC94uFtinUe1YBS3/qIQglg1VyYaX8mWhJrBjv
	 8S6t9OrD1QiJLWOXls0kJj/9th4MP20Azr6LiD3tE9tiuBFkyCoQ20dEKj8NMhmbkS
	 y/FMZBi//jyZd4jZ3ad0DUzFtkhoWJDR1EOuuUNef2IG0GUB+bgfCZYXsyy2oPC701
	 rd2aD15mBPg2jGeF4Q3rdBGu6EJIwLQy7M/QXkD0ItuzvYYaDVpkB7/WQdzDgq4Qud
	 mM4LhdHQZq9+w==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 1/3] mm/damon: do not allow creating zero size region
Date: Thu, 26 Jun 2025 08:27:13 -0700
Message-ID: <20250626152713.333339-1-sj@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <697aed09-80ff-41d4-b1cb-321c9fd9ff23@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 07:24:14 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Sorry for the late response.

No worry!

> On 6/24/2025 3:03 AM, SeongJae Park wrote:
> > On Mon, 23 Jun 2025 11:58:53 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> > I mean, something like below.
> > 
> > @@ -1449,6 +1449,7 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
> >                  }
> >          }
> >          target_access_events = max_access_events * goal_bp / 10000;
> > +       target_access_events = target_access_events ? : 1;
> >          return access_events * 10000 / target_access_events;
> >   }
> 
> I actually didn't mean the code, but just wondered if setting 
> "target_access_events" to 1 makes sense in this context.
> 
> I now think that it doesn't make any difference because applying DAMOS actions
> to zero size regions as it's just no-ops.  So I can take your change.

Thank you for clarifying, looking forward to your fix! :)

[...]
> > I still prefer fixing the found bug on the spot.  I don't think having zero or
> > negative size regions is really somewhat we always prohibit.
> 
> I can split "target_access_events" change patch from this regardless of this
> with "Fixes" tag.
> 
> But I don't get why you think zero size region is acceptable.  Do you see any 
> benefits or have special reasons allowing zero size regions?

In short, I don't anticipate special benefits of allowing zero size region.
But that's smae to this change.

I even have small concern about this change.

This change might make people assume any damon_region would have non-zero
positive size.  I think that's wrong assumption.  Any DAMON core and API caller
code can set the start and the end addresses with arbitrary values.

I think making the assumption true could be beneficial since it will help
writing code with less corner cases.  But to make the assumption true, we
should first check if any existing code is violating it, and if any existing
code that written with current assumption (region size can be zero) can be
broken.  After that, we should also prevent future code violating it.

And if the assumption becomes truth, we get one more rule.  I, at least, prefer
having as less rules as possible.  My taste may be weird, but this is my humble
feeling and opinion.


Thanks,
SJ

[...]
