Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E213A4F4A;
	Tue,  7 Apr 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571177; cv=none; b=tIEH5eMjsjNqZvDjT8sfP3vL86OJgLPOTSZWlLYg7szOEv1E0IY7EvWWMI4Fki66mBpTyBtoLQdK9+PEAgZyHexgL5IfFCawzk5RroMfX78N6WeOS2aNO5m6XqM/9ecMee5jnLeEX7ISy6EfqJyOsVsnHpSMg8qg3pnDM6in7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571177; c=relaxed/simple;
	bh=MS0m8nMGspG08RoJrEU0oKcfTPJQs58xLWX4xYfRgMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+VtD+jkA+Ck61jFl+8SU6i1RTltPEb8UxZr1wUORAUUZ3HDYz59VuwPxE7sxx3CrR5iWXJvmiln9BxevrkuwxhtJ7ihJU8mFYJdzg4SVDkq14orkPNJpYuTWNXdALTacexgQ0GCcd8QImw1fCtEIsmkALppxlgD60r7YysKjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdGdYFEa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdGdYFEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E159CC116C6;
	Tue,  7 Apr 2026 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571177;
	bh=MS0m8nMGspG08RoJrEU0oKcfTPJQs58xLWX4xYfRgMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdGdYFEa6gghQfdbhVjD7GqBJ9B+eFgrZ5chI8Mk8EA7pJyWesIGoPvGAwLOKrOpR
	 1Q51jMk7ilzE0PUsy/wU2WhjDHcvwyyJ7VXwYHUH9gOztcXwGz91fNdh/Ogr1El6Qh
	 sGW92pUd6uuP0HLM6hPt+HApVou5eu6pCrEHnZRXQ+B1M6stCAvxa7azVzx7shJSNm
	 J4czQZLZetFbMlpUlcK9lmZh3Jis7qVHVW3e9FnFBJf5IdaHab1hBk0sklmb63y2dr
	 Biau05eSnwXxtcXBFxpLstqY8Et4O64Ogs9vuYoSN4RA4MavCHIbLp7Fye/NDd91ZV
	 vqSqBOYpNr+GA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v3 01/10] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Tue,  7 Apr 2026 07:12:46 -0700
Message-ID: <20260407141247.86747-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko made a good suggestion.  I will address that in the next
revision.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260407010536.83603-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 3657261e42ea1ce93233b322fabf0d2c5c335a35
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle <min_region_sz remaining quota as empty
> 
> This commit updates the DAMON quota checks to treat a remaining quota of less
> than min_region_sz as fully charged. It introduces a new helper function,
> damos_quota_is_full(), and replaces the existing explicit quota checks with it.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3bc7a2bbfe7de..c29f70bcce894 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2041,6 +2041,14 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
> >  	mutex_unlock(&ctx->walk_control_lock);
> >  }
> >  
> > +static bool damos_quota_is_full(struct damos_quota *quota,
> > +		unsigned long min_region_sz)
> > +{
> > +	if (!damos_quota_is_set(quota))
> > +		return false;
> > +	return quota->charged_sz + min_region_sz > quota->esz;
> 
> Can quota->charged_sz + min_region_sz overflow here?
> 
> Since both variables are unsigned long, if min_region_sz is configured to a
> very large value via sysfs, or on 32-bit systems where memory regions can
> naturally be a large fraction of ULONG_MAX, the sum could wrap around.
> 
> If it wraps around, it would evaluate to a value smaller than quota->esz.
> This would cause damos_quota_is_full() to incorrectly return false even when
> the quota is fully exhausted, bypassing the DAMON action quota limits.
> 
> Could this be written using subtraction to prevent overflow?
> 
> return quota->charged_sz >= quota->esz ||
>        quota->esz - quota->charged_sz < min_region_sz;

Good suggestion, I will do so in the next revision.

> 
> [ ... ]
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260407010536.83603-2-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260407010536.83603-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
