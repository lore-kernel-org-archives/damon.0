Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6C4825D7;
	Mon, 14 Sep 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398992; cv=none; b=DpacLjIJQan7thsXxGowUBYScJOqVIKdC5o8YpgUVRmA+MP4OUkcdbmoMvGh9yd/yidbTduA7/N0ALSO/562MN+/quYXf1OMqVvWYYC17Tc+WM7dTqdWDS1GGrhPyvtYJWhA9t9xnlJgQg3EO2iUe3mSzXM2q92wUeO1XKk4sqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398992; c=relaxed/simple;
	bh=kh9cUyRtzCDFVBUt+AsRuq5GeATBBHHiXlxYX2+L0lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdepUivF30O6vtjLIaP80CruHnYWo9j6icrp+63LzaPMrgyI/7kIjEqmg50RDpvYIKF8ybRIGjQSVSa4sRifRjbKRflmSr8l5GPbyuTxUJb9F9HYRwpsoaV9OQmetv2G7eqjzPEOeFo7jDps/f7ItKZqjpOP7SrM0Arb7zhFvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmm6SMRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmm6SMRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72571F000FF;
	Mon, 14 Sep 2026 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398989;
	bh=B0jZkSZMfhmBRZ0Xr5aed0ootLssH96XlsM2bmpkwl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmm6SMRuxY5eyqjxySnQCJbeRb43iEM7D/MWaGkhWM0ozdkt2dDD8pPOu2p5z3azN
	 +tZ5F2Y2EZN5WpZML+MdhDCrCrNFH3YCP3vvLwSBY5KX1a74Dk7z/POyozNlmv/i57
	 KYAhhiwhISrDNg6Q9SuObhLAgWTPenpSjNbNrJ9yUfXCj8OhsRkx7F0utZ+RoWc7Kb
	 oyB5ghapxEsW53c3ayl1ajhCFtozzXwgYvh38XKkZQjjEWorZhIEqtN47g0/iTwezH
	 OhqbBAQM6YD4NORyZuMJPPWA/SlkhILRv/ZHfK7ppgBIDp0MJnxYDHuQxcUlbON4oZ
	 XjkynDU9AKhhQ==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 4/9] mm/damon/core: use damos_quota_is_set() in damos_adjust_quota()
Date: Mon, 14 Sep 2026 08:16:16 -0700
Message-ID: <20260914151617.97903-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914150150.1507525-1-kunwu.chan@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 23:01:48 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Sat, 12 Sep 2026 13:08:05 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > damos_adjust_quota() is manually checking if the user set the DAMOS
> > quota.  There is a dedicated helper, damos_quota_is_set(), for the
> > purpose.  Use the helper.
> > 
> > Signed-off-by: SJ Park <sj@kernel.org>
> > ---
> >  mm/damon/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index cf10f6d725c19..dd27068cb83e3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3344,7 +3344,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  	unsigned long cumulated_sz, cached_esz;
> >  	unsigned int score, max_score = 0;
> >  
> > -	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> > +	if (!damos_quota_is_set(quota))
> 
> Hi SJ,
> This is more than a cleanup, because damos_quota_is_set() also checks
> quota->esz, which the original condition did not.
> 
> The path that makes this matter: damos_commit_quota() copies ms and sz
> from sysfs but not esz.  So if a scheme runs with a non-zero ms, then
> the user sets ms=0 and commits, the running scheme gets ms=0 while esz
> keeps its old value.
> 
> The old check would then return early, leaving esz stale.  That stale
> esz is visible to damos_valid_target() and damos_quota_is_full(),
> which also use damos_quota_is_set().
> 
> With the helper, damos_adjust_quota() proceeds into
> damos_set_effective_quota(), where the first branch resets esz from sz
> when ms and goals are unset.
> 
> The code change is correct, but worth noting the behavioral change in
> the commit message.

So, if user sets only time quota, and then commits the quota to zero while the
esz is non-zero, esz is never reset to zero.  As a result, DAMOS keeps applying
the action with the esz forever.  Correct?

If so, this may deserve Cc-ing stable@.  Kunwu, what do you think?


Thanks,
SJ

[...]
