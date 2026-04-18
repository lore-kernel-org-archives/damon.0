Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A329B781;
	Sat, 18 Apr 2026 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776476898; cv=none; b=tYZETcof/rDM3pxC+KCdVKABA/E1Y6x21CAqV4At+i0ag0Y4De7dSTTSRrjM0wSrbh4uOko/FchX18TmdI7J+yHE8x38fssADSLaKq8LyC9HgkXJs9aCEJxXaUmtkM/WsbOySyTHk+IN6meyo83FgJuTASA81p/DLcYg4nyVA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776476898; c=relaxed/simple;
	bh=1Rp1KBEyLyK+Bx4RgUvTNrqEBxwP43pQchU5gS2AO9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeY0jYvihYPYmWCpiUUaQiIv5OnT8LNOtY4e78tdcVnhZvz11DSBIwHj6Mpd2qQHTMb3dQPXTXQFS+n8Pt0oKmo9OoZYuBRTAYQJ9Y/7AW2YoPYRJc0AJnrFzy16lBjeMHbDZd+37ueos1nZbRldenUDnv2VYfR0zFIEJSfsWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBPkYmSA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBPkYmSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A79EC19425;
	Sat, 18 Apr 2026 01:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776476897;
	bh=1Rp1KBEyLyK+Bx4RgUvTNrqEBxwP43pQchU5gS2AO9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBPkYmSASkVlJEao0vRV/xxyyMOiN7JBiSCwVegfTTNhlgubeoLPDgliDrRCTPA9F
	 qkn0OdbsEemZz/j4XVVr5k+oH3WGsQW99Xz5tJWE4SgB+np0s9PAIrZyXvjwPHkn5W
	 9NHwmuXcZB7mK/VdvEnnw9uijwBt0gPcEnw24E+yz1S43bomNLF5NpevDbVDVqDos0
	 pLwrzuDwB8WKrov+hliFpkedgvklxSU7bVKy6as0RDK8poRKSHrjdt5zWssUQwU40e
	 VIoy9zKS+hwksmgS+7Yiku6HbJQOkcMK3M4GaVPyHMQL+nufwne0a535Hf1h55vZJC
	 GxCuWECx++ygQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/stat: detect and use fresh enabled status
Date: Fri, 17 Apr 2026 18:48:09 -0700
Message-ID: <20260418014809.6428-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416143857.76146-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Apr 2026 07:38:55 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON_STAT assumes the kdamond will keep running once damon_stat_start()
> succeeds, until it calls damon_stop() to stop it.  If the
> regions_score_histogram allocation in kdamond_fn() is tried after
> damon_stat_start() returns, however, and if the allocation fails, the
> kdamond can stop before DAMON_STAT calls damon_stop().  In this case,
> users will show the 'enabled' parameter value as 'true', while it is not
> working.  This could make users confused.
> 
> The user impact should be mild, though.  First of all, the issue may
> happen only quite rarely.  The allocation failure is arguably too small
> to fail (100 unsigned long objects) in common setups.  The time window
> for the race is also quite small.  Even if the race and the allocation
> failure happen, users could find the fact that the kdamond is stopped
> using 'ps' like commands.  By writing 'N' and 'Y' to the 'enabled'
> parameter sequentially, the user can also easily restart DAMON_STAT.
> 
> That said, the bug is a bug that needs to be fixed.  Instead of managing
> the complicated state in the variable, detect and use the real kdamond
> running status when the user reads the parameter, via the parameter read
> callback.  This will allow users to always read the correct 'enabled'
> value.
> 
> Note that the 'enabled' variable is no longer the argument for the
> 'enabled' parameter.  But it is still used for two use case.  For
> keeping the config/boot time user-set parameter value.  And for keeping
> the user request to compare against the current state, to see if the
> damon_start() or damon_stop() call are really needed.

Posted the next version of this patch as a part of another series [1], because
the patches of the series are fixing the similar type of bugs.

[1] https://lore.kernel.org/20260418014439.6353-1-sj@kernel.org


Thanks,
SJ

[...]
