Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7B32FA2E
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903281; cv=none; b=HCmdg5wUbJxI7G18RwSVva8xT1DhpfGq3ayyj1aPuTlqbY0hUQqQi9iIyEa0w3OhaOIi1v+2O8zf/B2KrVy/AKXJJt09zm13bCmMzeBnqSEpyUfQhC6RJNOja9AsqSmusYejUKYKZT7Iuis5BWl92OM0ct+aKTj8SmpnMJj1qUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903281; c=relaxed/simple;
	bh=WV10DrOzdO3lR1Ni3oBmXJE1RLkOPTcSkW0ndJFFiU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l91lzPDIpraFbeckd46S4bgu0cjulMmdf3h0jh1mukvM/tQwvdWbBKzv0GnQlGSn75CJ8AdDqKeWUa5tmXcUV5q6l+dOdjF0KIiwP/2ALlrmFrrxebAwBkxvv7MPiFqIOMYRRqxguwETuggNlvtoBRas66hDmxdjtP5yoY/Nnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6kI5q2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6kI5q2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B11F000E9;
	Fri, 19 Jun 2026 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781903280;
	bh=SNNiAhOvKgVX0Jqz1LR5H1AXI9UkwNXEE7YIR5ExsXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6kI5q2Zvy04aT0mib0MLZuLHOMoYc66b70rI2jjhhW+tGCpuROkchcKu+xW3OgAw
	 3FifKPrmDkVjjVLcGWkmfct6OaIjcUnMAtQD85mCZcZKG706QS9BvF/7HXp+W2aNBk
	 QvXCNn4oLk4R+Y2276wPiyInGuqH4M0GjuGNfqXROR3Sk8hdVYY2dAQtZlgD//bX0B
	 PyNSftx8DiZRfvrmkPW6JZz8/k0HdzLAtZ72LWZFQf/CdX7XOLOIGWGe0fQn5nf57F
	 U9YudGByxxBDscQc9NF6PR6HseUzA7gMDNHMWdE5tA2lofPnhqIhPQJfXN0p7f1ztv
	 PXCm8ss6g/N7Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon: handle zero sampling interval in damon_max_nr_accesses()
Date: Fri, 19 Jun 2026 14:07:56 -0700
Message-ID: <20260619210757.152173-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619210304.A89AD1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 21:03:04 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch replaces a divide-by-zero crash in `damon_max_nr_accesses()` with a divide-by-zero crash in caller functions such as `damon_hot_score()`. When `aggr_interval` and `sample_interval` are 0, `damon_max_nr_accesses()` returns 0, which is then used as a divisor by its callers.
> --
> 
> commit ca6b91d50d3b7234e014066f6e835c8aab906f49
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon: handle zero sampling interval in damon_max_nr_accesses()
> 
> damon_max_nr_accesses() causes divide-by-zero if sampling interval is
> zero.  Fix it by handling the case.
> 
> Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 6f7edb3590ef9..83b43d8ffef38 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -1065,8 +1065,10 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >  
> >  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
> >  {
> > +	unsigned long sample_interval = attrs->sample_interval ? : 1;
> > +
> >  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> > -	return min(attrs->aggr_interval / attrs->sample_interval,
> > +	return min(attrs->aggr_interval / sample_interval,
> >  			(unsigned long)UINT_MAX);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does this patch shift the divide-by-zero
> crash to the callers of damon_max_nr_accesses()?
> 
> If a user configures DAMON via sysfs with both sample_interval and 
> aggr_interval set to 0, damon_set_attrs() allows it because the validation 
> check evaluates to false (0 > 0):
> 
> mm/damon/core.c:damon_set_attrs() {
> 	if (attrs->sample_interval > attrs->aggr_interval)
> 		return -EINVAL;
> 	...
> }
> 
> With this patch applied, damon_max_nr_accesses() prevents the initial
> division by zero by defaulting sample_interval to 1. However, it then
> evaluates min(0 / 1, UINT_MAX) and returns 0.
> 
> Later, when a DAMOS scheme with a quota is evaluated, damon_hot_score() uses
> the return value as a divisor:
> 
> mm/damon/ops-common.c:damon_hot_score() {
> 	...
> 	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
> 			damon_max_nr_accesses(&c->attrs);
> 	...
> }
> 
> Since damon_max_nr_accesses() now successfully returns 0, wouldn't this
> trigger a divide-by-zero exception in damon_hot_score() instead?
> 
> Could we explicitly reject an aggr_interval of 0 in damon_set_attrs(), or 
> ensure damon_max_nr_accesses() always returns at least 1?

Ah, good catch.  I will fix this in the next revision, like below:

'''
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1252,11 +1252,11 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)

 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
+       unsigned long aggr_interval = attrs->aggr ? : 1;
        unsigned long sample_interval = attrs->sample_interval ? : 1;

        /* {aggr,sample}_interval are unsigned long, hence could overflow */
-       return min(attrs->aggr_interval / sample_interval,
-                       (unsigned long)UINT_MAX);
+       return min(ggr_interval / sample_interval, (unsigned long)UINT_MAX);
 }
'''


Thanks,
SJ

[...]
