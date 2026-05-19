Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B15318050;
	Tue, 19 May 2026 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149419; cv=none; b=njhFpEh5yz4uvD2YUDdyIk755NeUogBBWHc6PLoTozsfUlyQQy5K8n/wT+dVowuHUHD9tTGhEV7bUbkMnlTqQhSNFIQaWuW4e8gX3Uqf0dL+n8lEavphBs2ft//tDCOZNZ84nLJ31giyuDC82UnCtV2PyoAa53H6/25eb+axcsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149419; c=relaxed/simple;
	bh=6EEyyCmXZe4QyrN36kjm7G4P+AdpHLcR6vaJ02zX3Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMbpbSKD33eAp8Jx3Ec4LuRmv+zhL5MeyS+2+dVejRJL/LR0+nXOK/51PwtK/9qLOHC9GElcGTRVoPWiLuXE8qi0BlyLON9BppAxspZlRz4ld+/d3pcDH3AhQ19+EdTvbmPb9j5zd69mmk/hWwa1Q2lcBOBYW1TEFmL9j/pIuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2JU/INb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2JU/INb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785E3C2BCB7;
	Tue, 19 May 2026 00:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149419;
	bh=6EEyyCmXZe4QyrN36kjm7G4P+AdpHLcR6vaJ02zX3Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2JU/INb9KQ7ApYSFYLmMTtTSU9WcpYCIko/CuisG3/KwjhkDzxcNg+nlowMkCeAd
	 t2xq+OyVOhs+C1a2iEXSrJBCW6a6JKEvUpOE30E/i5XEqIvxCFRubKgOlnVsrvQPj4
	 HXyS5rhfwnEL49De8MmkiJQzuAnDXpVsi2UGI5B/5uamxSJfxt3mRidOcLmPsKLN1Z
	 xrZS1D1dLG6vhhT523L/tHCGnHOop6JtL97WE1yh5hVfQbRCDAyPc3u6Uu2O6ekBb/
	 sj6vuN0CP3q4AVppPq4nXwOc2zSznVOSAG/UnD1hf0UoQJZV/bv24Z2aOS7nMQOkWY
	 5vUyyawamAReQ==
From: SeongJae Park <sj@kernel.org>
To: Maksym Shcherba <mshcherba2000@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
Subject: Re: [PATCH 1/6] mm/damon: fix missing parens in macro arguments
Date: Mon, 18 May 2026 17:10:13 -0700
Message-ID: <20260519001014.99041-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 22:09:27 +0300 Maksym Shcherba <mshcherba2000@gmail.com> wrote:

> The DAMON iterator macros do not wrap their pointer arguments with
> parentheses. This can cause build failures when the argument is a
> complex expression due to operator precedence issues.
> 
> Add missing parentheses around the arguments in the following macros
> to prevent potential build failures:
> - damon_for_each_region()
> - damon_for_each_region_from()
> - damon_for_each_region_safe()
> - damos_for_each_quota_goal()

Nice catch, thank you!

> 
> Assisted-by: Antigravity:Gemini-3.1-Pro
> Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>

checkpatch.pl warns as below:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Maksym Shcherba <mshcherba2000@gmail.com>' != 'Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>'

Assuming that will be fixed,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
