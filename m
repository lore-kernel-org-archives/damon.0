Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1040DFA4;
	Tue, 28 Apr 2026 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336762; cv=none; b=AtaGKSbsOcD5s0gcCK9rfTX5kjpal320nHAXaTeJZO15T9yXmOwNQuz1bx35eZIq2mghQrtW/PfnpRts3s47InIDUPBFloNBJ5/l22BM+hWPPlRNs2pSEyvWo3mvnQT1LjNX1xx2nU1T+ETv36U15Cx8MBg0yBVV2uJ1J1ohKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336762; c=relaxed/simple;
	bh=lRGNhb+u6wBJ03S0QzqJb4wpYWidPN3/P13uPg4Nhv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7un92d+Bo7OFXVZ56EzTULw0dVCF/va+QBos4Eg6iYgDJy7YzD3In8oBG9E5L2liuw498ybpzPtYveOy2ZxHtH9OPaaWrjkPQ75zDfhmVAlDp+ddYmY2K1JkT2AqyFoVGzdW4WLp/aiy1xDo/dtbzpNUg5P3W2DAxeY0YOIHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOzL7rJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOzL7rJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FADC19425;
	Tue, 28 Apr 2026 00:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336762;
	bh=lRGNhb+u6wBJ03S0QzqJb4wpYWidPN3/P13uPg4Nhv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOzL7rJWl+2wyYZ09VlxfZyK/+M+21lzd9PIsBeoDZu0uOoEyOF0YAN1eicTp6fdw
	 9Gi44kbatTRAhZsN/3dUIQ8y6y/ygSVm6Uq8ivBw/RtCeznkTFoc4xd8tk1D3FdfAM
	 w2SywQ/jcRr8kFYC4xF6YaA8P9ouQNx7M4cyd674CMufhXzV8GtoJAnq8XG3kOvpSh
	 +hRfYk6Uky6dAfUyQy7rVrLi5xsQ0C/VBugQKTdOzbHOf8inS5wfnbWx02Oo/nYsvQ
	 c43bGHS0GQY4edI710wsdR5Dt/MS6OokYNOeyNMUY7QU4aDRSxERNG6cSzC7IM9dQC
	 cEm2mHrwGyhPQ==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 04/19] mm/damon/core: commit probes
Date: Mon, 27 Apr 2026 17:39:13 -0700
Message-ID: <20260428003914.113299-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c09f7c82-88d3-4870-9805-f22394b08583@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for reviewing, Asier!

On Mon, 27 Apr 2026 16:21:19 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 4/26/2026 11:52 PM, SeongJae Park wrote:
> > Update damon_commit_ctx() to commit installed data probes, too.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
[...]
> > +static int damon_commit_filters(struct damon_probe *dst,
> > +		struct damon_probe *src)
> > +{
> > +	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
> > +	int i = 0, j = 0;
> > +
> > +	damon_for_each_filter_safe(dst_filter, next, dst) {
> > +		src_filter = damon_nth_filter(i++, src);
> > +		if (src_filter)
> > +			damon_commit_filter(dst_filter, src_filter);
> > +		else
> > +			damon_destroy_filter(dst_filter);
> > +	}
> > +
> > +	damon_for_each_filter_safe(src_filter, next, src) {
> > +		if (j++ < i)
> > +			continue;
> > +
> > +		new_filter = damon_new_filter(src_filter->type,
> > +				src_filter->matching, src_filter->allow);
> > +		if (!new_filter)
> > +			return -ENOMEM;
> We should bail out here. If we return an error, we have already
> committed some of the filters already. If there is an error, we
> should remove any fill that was already added.

The cleanup will be done by the caller.  That is, damon_commit_ctx() caller
should destroy the ctx when the return value is imposing a commit failure.

> > +		damon_add_filter(dst, new_filter);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
> > +{
> > +	struct damon_probe *dst_probe, *next, *src_probe, *new_probe;
> > +	int i = 0, j = 0, err;
> > +
> > +	damon_for_each_probe_safe(dst_probe, next, dst) {
> > +		src_probe = damon_nth_probe(i++, src);
> > +		if (src_probe) {
> > +			err = damon_commit_filters(dst_probe, src_probe);
> > +			if (err)
> > +				return err;
> > +		} else {
> > +			damon_destroy_probe(dst_probe);
> > +		}
> > +	}
> > +
> > +	damon_for_each_probe_safe(src_probe, next, src) {
> > +		if (j++ < i)
> > +			continue;
> > +
> > +		new_probe = damon_new_probe();
> > +		if (!new_probe)
> > +			return -ENOMEM;
> The same as before, we should bail out.

Ditto.


Thanks,
SJ

[...]
