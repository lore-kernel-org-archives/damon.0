Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329D338593;
	Wed,  8 Jul 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521099; cv=none; b=ljFzE/xLPlEoFSz3mCydmv1IO4VHmgjEnT1GIptyyHsmiZ8qOs90qLEW4CHwT9w5Aei99Mp/eoArUDXxrxbzd1R/yw+BHFwPktPqhW8La357R8+RGWb8KM3kfzUUmW3UKA+FjC81xPaNagpbBi+Yk7FqPWcoLhOdCWtBzntob7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521099; c=relaxed/simple;
	bh=2w7lubSrH8qtcCbQHh9CPUnyPgB3V+V4t6pY+2AT/gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra+Gf+Fh9wSzKd4Io5jo8R8CH3u/uyDsQZ5XuNzVgIMHZcL0SkpoT/ldLr5nXbejGi/2jAOOQpaLRQRRwIiLzefFvD8nTCZ+Smoa6wYBP+23ph88Zz8kcMjNn/z2L+NJubKL9Q9fhQpLlO9K3gpC3BmE9j3Q9wuwGLrDy/14MHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCpJO0aj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCpJO0aj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852E41F000E9;
	Wed,  8 Jul 2026 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521097;
	bh=xnVyRAW1GybKVfIibIhr7aymmWn8IPGRIA1RKT+MYxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCpJO0aj5uJU/hUo5m+g7jSkGEXNzf5taItrCRpfzkUXT5cVT1l3aHMg/Er4rRRkK
	 VRcenDWbOqCaAXmTLwKLbApBvzIkiwYefLMVvn+CU9BBxs8TWUvBG9kibjxBm/dI/s
	 ip7keYMwP1vQfG0WQsvtLhuejUnfhAuD/5t7hBlydsEzkz+4roSo5ORag0sJ7inPSG
	 3Kkra9GFTZhTIhh+YrmrwF0zI0vHIPpI5Wdd8Kjq7NMch0Br+mS9Wpiy62B73Wofss
	 +S5KRYvzQVySR42chkR28/nIL91/GgYTFtiK2aGD2HKM3vHaesxuDVHHnnuFF4uHNV
	 uxG/jHMMYA4KQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/7] mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero
Date: Wed,  8 Jul 2026 07:31:29 -0700
Message-ID: <20260708143130.124419-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708135359.122587-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  8 Jul 2026 06:53:51 -0700 SJ Park <sj@kernel.org> wrote:

> The comments on damon_nr_accesses_to_accesses_bp() and its unit test
> warn it can trigger division-by-zero when the aggregation interval is
> zero.  Commit 35d4a3cf70a8 ("mm/damon/ops-common: handle extreme
> intervals in damon_hot_score()") modified damon_nr_samples_per_aggr() to

I mistakenly used the future name of damon_max_nr_accesses() on the above
sentence.  Andrew, could you please fix the above sentence by doiing
s/nr_samples_per_aggr/max_nr_accesses/ when you pick this up?

Please let me know if you prefer v2.


Thanks,
SJ

[...]
