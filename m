Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB71FBC92;
	Wed, 24 Dec 2025 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554207; cv=none; b=fS+r0W6RYWevVEarcRsnuTWqAHz6QiRwl0MttCAf7pFc8w9Oa/elwyW+OFAzR0q0hyx8EyJbDZ4tyC25xtc66A/9nwJ7WaScUSATOJPuMl0E1n6tD1hIEsJvhe89wAm5fosBTEx9nkpjqx85z97gVwlrFCy8pBptLpyLgB1C9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554207; c=relaxed/simple;
	bh=aCu6Dpw4kIA0zMNsdM1hGIRft3R9eKCH/KpDIOa7sOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jowi22wno14utaqnHVtcFQzv1CqU8Qc/KOsJClBDg50kRmUUjs8XcctYgMRSrFZONGy6T4ap+EaYkfexPMbqNzly2uTIob3O4iSygY7+Wp6GFM197yWbqc+yChaf/OLRiKmOoSQfv+KxjDxfTAi1uTNZivH99er6vbLaTRdSUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGuUVSeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGuUVSeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BF7C4CEFB;
	Wed, 24 Dec 2025 05:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766554207;
	bh=aCu6Dpw4kIA0zMNsdM1hGIRft3R9eKCH/KpDIOa7sOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGuUVSeK7YEmAoMCUaLFUR/+7m9BnjJIjh+UXBDtYnpiR+GSouFnxVSyoKuS9uGo6
	 pCc8NY+HkDe2KK/MbkQC4FLdq5xw5PS36xyGYm1vsr2G6LDa4U6IevzltV31w2AB0z
	 36oBMy9ZihSO+VXerH6FW8K/gUYZMx3tXZFwEfPM3770/xNCk7cjsAAXQC0v1Z755r
	 TmeV4+ij1KIfTMJh578oikRD8DfoasIpWghxXg/0kczput+bo8ZD9FJD96tWh+5B+6
	 92ua6uuk/FC+KtHvjQn6w9W+ZBGPt3crScwrfw9jxX4JYWnEBE9zuTXIYeNgfQndxx
	 5v2W+9U2NMUBg==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm/damon/tests/core-kunit: add a test case for region merge size limit in damon_test_merge_regions_of()
Date: Tue, 23 Dec 2025 21:29:57 -0800
Message-ID: <20251224052958.81796-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224042200.2061847-4-shu17az@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 04:21:58 +0000 Shu Anzai <shu17az@gmail.com> wrote:

> Add a test case in damon_test_merge_regions_of() to verify that 
> two adjacent regions are not merged if the resulting region would 
> exceed the specified size limit.
> 
> Signed-off-by: Shu Anzai <shu17az@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
