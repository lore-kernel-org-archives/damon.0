Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937B2E5D01
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277146; cv=none; b=X63KK74sV/NuHg+E2sQXQjHi5Ch9K9w2rY/0LAes997qIuabLniCBItQLM2O6xwk8I9xcGp/kTKD5fOzOe7erWrsOzQjAcbZ9twPqP2Qa5uGtUZDl7pur7DZVq4m0z7LG9KslrdBYgSeUTzZcdwVhHfZTR0PP0XdqGfZymDy54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277146; c=relaxed/simple;
	bh=NGegCFhiyZ1h1w697ypgzowDLyLqjIrtnSAlxH3t/VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXGStOWbqjj2SpkTNtLj2vEW9ggyMg1Ea3CT434rIy+2A7aNAQ01SBophzCXvjaebuRGPfkcfOGRSRrFHNrfXKsbj8JPpWVosQcgzxkqPK/uDgdfue0H+DWPkqQAAUrwMoCoe49d6lfKFZrEJxEhm9ywlvS/ktkwyANUGPIrzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQnc5YgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQnc5YgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A8AC4CEEB;
	Fri, 15 Aug 2025 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277146;
	bh=NGegCFhiyZ1h1w697ypgzowDLyLqjIrtnSAlxH3t/VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQnc5YgIDUcyweR2XFx0UO+yui+YXy9sSk48egUARHzbaANC89iGrBATo3uJTIs/E
	 8uDUT0hyQhAEWl5muQbXKSrEeslENfalxgoYETmW76TE6yXE9avBHqKbFctM4l8MOX
	 qN6f6vitvi1SFuUSTeajhiMBUyKqF4rZXquF8y736xB3V5jvnn1awhHlJJBtjtrylr
	 e2szxAvm1nf1Li/hgCtb1/IqTrh+JRRc6gyNG3npfUCQzh1/ntBk857Ljot6XKch3B
	 Pr94HwaYnlZLGCtLSkVfoRqUyaYMXnk6n0cR8TLqfOnkRQ0GMQz8fWZn5UeXLE73xM
	 4cLIAYTgHaIQA==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH v2] mm/damon/Kconfig: make DAMON_STAT_ENABLED_DEFAULT depend on DAMON_STAT
Date: Fri, 15 Aug 2025 09:59:03 -0700
Message-Id: <20250815165903.13330-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250815092110.811757-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 17:21:10 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The DAMON_STAT_ENABLED_DEFAULT option is strongly tied to DAMON_STAT
> option -- enabling it alone is meaningless.  This patch makes
> DAMON_STAT_ENABLED_DEFAULT depend on DAMON_STAT, ensuring functional

s/depend/depends/ ?

> consistency.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> v2:
>   - Change the subject as suggested by SJ.
>   - Keep 'default DAMON_STAT' as before.

Thank you for addressing my comments!


Thanks,
SJ

[...]
