Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22A1E531;
	Thu,  5 Mar 2026 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672103; cv=none; b=X+HykFDz6V9ZN2Udo500vRAGguZ75mh6wXMFTvEu4SuTpuBg5gMwIadAOVwjfTLpXYh1TRUWRkdFeX/H7qGl9N6p4K/bbp0uAjd0cUH6znHWpneMNdQhJ1hr8A+oZfOE69pEPY2KUQ7W+BrtsTzXv18y+3zBiwOOkqsoOCEBILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672103; c=relaxed/simple;
	bh=uhkqqYzBgXQddoLBpJs6tjXLYsyzjESovm0d5V33olA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otENevqQ/e4Kat78zwhNNERXAXHShgKDFPx13sNOyVSWIm9FquafGFQ05Hr5hqexGt3dAFmyzPkGspHA2qBbfxe6UqJvK5MRF/qnDVQVvSyEPK01aE5Ck09QUL48dqkJn8lAN6GPu1ZZWeGgFsXd6IfSlRDSq+EPiwRjZTU3i6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIN/AhtU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIN/AhtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4379C4CEF7;
	Thu,  5 Mar 2026 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672103;
	bh=uhkqqYzBgXQddoLBpJs6tjXLYsyzjESovm0d5V33olA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIN/AhtUYBiRZc8RztJGdli1WMuzIAe7Ns92DiKDrN7LBOqV90Pq6iL5qTvpyGjCA
	 1ZiBhxjFKaarSNLWc5Se3ol6yUaeAkrjG+eusCOdPwyLBvOyMYfEgpaTvlXZUcBJCx
	 cfsRpwEWbpKxYjEesifJGqJf63vhOZ744iR7AWlTHHT1Uov1u4aYQXHezPxi/S6R5J
	 /GAQ7OT2OqqYLgxgtYCvULQBdwM0B7+/R8xUtnERyBXIDjXNZ3G0YKakH+ZR2pGKWY
	 Ujsi1hpXPrLJiods5PWfqeOU3bmIElWEGoKQGkHhCu0Qjp9WAykHcXfUhyCR6wJ3ED
	 q352Y6LvRvPkw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 02/10] mm/damon/core: allow quota goals set zero effective size quota
Date: Wed,  4 Mar 2026 16:54:57 -0800
Message-ID: <20260305005458.26137-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304145140.172293-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  4 Mar 2026 06:51:39 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 4 Mar 2026 13:18:16 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
> > 
> > 
> > On 3/4/2026 7:41 AM, SeongJae Park wrote:
> > 
> > I find the name of this function confusing. The function doesn't
> > actually set anything. Maybe better damos_quota_is_set()
> > > +/*
> > > + * damos_quota_set() - Return if the given quota is actually set.
> > > + * @quota:	The quota to check.
> > > + *
> > > + * Returns true if the quota is set, false otherwise.
> > > + */
> > > +static bool damos_quota_set(struct damos_quota *quota)
> > > +{
> > > +	return quota->esz || quota->sz || quota->ms ||
> > > +		!damos_quota_goals_empty(quota);
> > > +}
> > > +
> 
> Thank you for the nice suggestion, I agree your points and like the suggested
> name!
> 
> Andrew, if you pick this patch to mm-new for more reviews, could you please add
> below attaching fixup together?

Never mind.  This is an RFC, which is not aiming to be merged into mm-new.
I'll squash the fixup to next spin of this patch.


Thanks,
SJ

[...]
