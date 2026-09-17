Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30A30E85D;
	Thu, 17 Sep 2026 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608420; cv=none; b=arKhv8PZpJGK25hsH7SJBRjHCilE6WceUmK1fbe043i4yXuP3y9XrUnw/A228Lqcv5NceOwVCc5u1sgBC2dK6PwCQUy7GWzN/BWxHjBCD+NxNBKo81mVLhyWXb34TBblBJ4d/15UCEdejhUTczXegGe9e4LNuEhN704nR6D7zcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608420; c=relaxed/simple;
	bh=cBp5GIMyxCsKFy3UwdUrKY6HCKiImUb1JXgoTTrwaho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwK/z4cZl47YZsoGZAxTg/Hbf493cF5oH+0EvtiNElk3MhwpoobbUZBaCTY6q3glpfXodBlmivdXWQ5dZOFfZhS5U6SYUZLKJ/JpqApXYvYpC7ca/ZeYsm2ymhcNlt/w9JrJX+HAloAMN6V7aXjpPEfXJE0XxUTh93VJT8x/VUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRDo5fsT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRDo5fsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B981D1F000FF;
	Thu, 17 Sep 2026 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608418;
	bh=6OMNz3CzLTryMajvI16kLuSSdViwFTIviZ5J9O+nTJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRDo5fsTaWRBzlfqECIeSUYrTQGoI8rKKgDF7QPrWg4KSFgezopRMNebgitb/ys4Y
	 lB2PcCpQXn+qRrwjlqQ8e5xUsGils15XgZC3/RholiTa6vC8JlM6mz5HVNG+AK0vVT
	 wAm3KSMkrtQS9obmQfH45lt6NgT40qF8kMlwaT9xo0f+UFRWkVxk3qX9udWoSZEnEu
	 y2eicZ+QVDTYWkt/m6lgjEhzroBnwJDB4r/cFgjswaOdm2H/Tv/AuICCK7lScOEpNJ
	 vbwIDUimWyEsRyGBpP32cTpMiRi5Sp4UqrFTmQDwutvIeoAW7dMzhcQENfN+IG2/k8
	 JHqqP7nUm0HiQ==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/tests/core-kunit: test the size charged for a filter-trimmed region
Date: Wed, 16 Sep 2026 18:26:51 -0700
Message-ID: <20260917012651.101228-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917003553.2465523-3-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 09:35:53 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> damos_test_filter_out() checks that an address range filter splits a
> region at the filter boundary, and stops there.  Nothing checks what
> damos_apply_scheme() then charges to the quota and reports as tried.
> 
> damos_test_apply_scheme_filtered_sz() covers the two ways such a filter
> trims a region: one that starts before the filter's range, and one that
> starts inside it.
> 
> damos_test_apply_scheme_filter_sz_unchanged() and
> damos_test_apply_scheme_quota_sz() cover the cases whose accounting must
> not change: a region wholly inside a reject range, one wholly inside an
> allow range, two filters trimming in a single call, a filter type that
> never splits, no filter at all, a region the quota trims, and a quota
> remainder too small for one region.

Thank you for adding these tests!  I to be honestly would prefer making the
code shorter, but I wouldn't block this.  We could cleanup later if it turns
out causing real readability issues.

> 
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
