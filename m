Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1813B293
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433895; cv=none; b=FFkiost2cUJOlkKgdoRw2UajMIwo2eJm78XK0bC4lc1iQN0+MYga35phTTEDWewzSJcvTVGgQ5sfwLqYXcMugcYjuCsuwKc1scdvcm3CNbJ8IVU1YIhuT3JN8290fn1YkA12cGBbGDb+14eTP09IQCGtgOLxn2bTk2TmImRjinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433895; c=relaxed/simple;
	bh=vna2p94sniECXaa/k1X4qq9Hm0TjReE1oyCSixnRrog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTP8ZqiadjS3ffeP4mIWr4dOemBoKOcMVbLix3yb7bP+OdffGvSHi9zlZom3GgU0roXQh65TNwBxWJ6xX9LBga1ll3Sp0u3R5XkHG21GtPKwjplArdhVczqDG93DSdv8oYTxAzOusqMa3OpxxnYgub0XMr9aNRe+b91Qrb6ep8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J11o7lx7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J11o7lx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0451F000E9;
	Fri, 26 Jun 2026 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433894;
	bh=NjaS3ECDngpdUy0Dt1tppOu7Jx1xs3bsILQYbIGP8eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J11o7lx7meDzNnEO8UvdYnwq+ejQMauVfOMJufNNAWZ16z6OzawCD4WgJK90WvvtH
	 +CMISsE6zGnPiW8zke2/9aTXa5O6I/UQYkzE166UAU88kJcdaA1bnpQ/9ErrvjbKrQ
	 Q8wnzmjF9QUA6wFeMaCJhr0X/Cn4PEwrG5ZGOU1TYBwM8EGxKQ7vTw02d3JuhKG//j
	 gIkhhqlnV/nOaDG8FSpozhcTHUa77HYDciwUcS7mDrj8999yu/OZTiFQfjxmM8A99e
	 pWtLDm5Fmkm7KPOQjR+nLSN6m8M39sTl3UgGsZq4HclaRIz7ZlhKOy8EOLr3zMfvCU
	 phAwAZD7Ddh2A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 01/11] Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Date: Thu, 25 Jun 2026 17:31:24 -0700
Message-ID: <20260626003125.87513-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626002448.975E21F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 00:24:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Truncation of 64-bit phys_addr_t to 32-bit unsigned long in damos_get_node_eligible_mem_bp leads to incorrect metric calculation on 32-bit systems.
> --
> 
> commit 569eb38d08bfaf4718faa6440d86cad7ba9478b7
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
> 
> Commit 9138e27a3bc3 introduced DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP but forgot
> updating the DAMON design document for that. This commit updates the
> documentation to include the missing metric.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -686,9 +686,11 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
> >    (1/10,000).
> >  - ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size ratio in
> >    bp (1/10,000).
> > +- ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
> > +  of a node in bp (1/10,000).
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing this metric, I
> noticed a pre-existing issue in its implementation.
> 
> In mm/damon/core.c:damos_get_node_eligible_mem_bp(), 64-bit phys_addr_t byte
> counts are cast to 32-bit unsigned long before ratio calculation:
> 
> 	if (!(unsigned long)total_eligible)
> 		return 0;
> 
> 	return mult_frac((unsigned long)node_eligible, 10000,
> 			(unsigned long)total_eligible);
> 
> On 32-bit systems with PAE, if the amount of eligible memory exceeds 4GB,
> will this truncation cause the metric to calculate completely incorrect ratios
> (e.g., reporting > 10000 basis points) or erroneously return 0 due to modulo
> arithmetic?
> 
> This could cause the DAMOS quota tuner to adjust quotas wrongly, potentially
> resulting in extremely aggressive or completely ineffective memory actions.

Known low priority issue.  Not a blocker.


Thanks,
SJ

[...]
