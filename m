Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB5188713;
	Tue, 19 May 2026 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149831; cv=none; b=VbnKn5QmTTXEBcx/Z+0btcgkO+6w3RfYB6N4ccKrjHuVY/Gn0+twvg++UkTrWfqaadCPad85c+G71dvz53WrI+kSivfJc8NAYhJT+UQfAproc9FhpTRrnzjXbHx1LpY4ppTVte4unxJmQfGWuKTiEJLWt+RurFTipBVNyo377YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149831; c=relaxed/simple;
	bh=mxj47XeUru82Pt8pJLXY53mHkRiq7hhv4CRlGK/7boc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEHFs8V5W5hBuceRmTH+WukvQJpG01FutjEvMXymVX0mIP/xHRLaV7ybi1bTxD2sRUDuZ26Arb0hqF3IqNZ6+6W5tBQ1/Yd/wj0nOfpOGZrOtBH1BDRzgEAwgXtIPSIwhpqJYQATXDa1IMp2wBZRDWTZlIf/OeA+d9981aQMjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUjWG8Q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUjWG8Q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E85C2BCB7;
	Tue, 19 May 2026 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149831;
	bh=mxj47XeUru82Pt8pJLXY53mHkRiq7hhv4CRlGK/7boc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUjWG8Q9IZC2UVyUGXZLtuyJapt1DpiayMo95tUuaJqADSEPmFRR6ncWdoX128Hrr
	 HdXVxjLRCd0ugRtu827ZGvGiFdI0BuhNYHvalrXtm1asqbysmPjS9/4GslKv9xRTwU
	 3/Z+qtMpBh9EeSrfMKoNX7+yzb8M9tcEwAdKkjEroTvTU3KpRF1x8/nN93rC9zjEHH
	 2o2czCRoJikBmL/UfCVe5ookbOUyjI9Pjt9w+lx/JPvzxofklUuogJwY3rvj7W9PVx
	 Z8bezuqzz/JkmZSX6Upinw8jKDI8Uv4gJvDeeUIA9X4kUyiL8IXkq+d8tsIIwklvLR
	 RFqJjt6MzqRVA==
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
Subject: Re: [PATCH 2/6] mm/damon/sysfs: implement update_schemes_quota_goals command
Date: Mon, 18 May 2026 17:17:02 -0700
Message-ID: <20260519001703.99264-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518190932.42270-2-maksym.shcherba@lnu.edu.ua>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 22:09:28 +0300 Maksym Shcherba <mshcherba2000@gmail.com> wrote:

> Add the logic to copy the current_value from the internal
> damos_quota_goal structure to the damos_sysfs_quota_goal sysfs structure.
> Introduce the DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS command
> and integrate it with the sysfs interface via the 'state' file.

Could you please further elaborate why you think this change is needed?  What
is the expected use case and benefit?

Seems the following patches of this series depend on this patch.  I will hold
review of more details in this and following patches until the above high level
question is answered.


Thanks,
SJ

[...]
