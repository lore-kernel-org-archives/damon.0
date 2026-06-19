Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158722A1D4
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781899018; cv=none; b=ii0hVfdAccXPbaE78jf20RpICsXcnHOIcjyUVtXz3L3xCIeukLTxeC8NtIhdD1U2jmPbrZxQojVcifWEf578KvBz0HNQ1p9H4j/2eb0tm6ec6aikUnRSUhqxhBt1zHG22WhPkeI2la5+k8iKlgijm7umWMFbW7CI6L602+l2l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781899018; c=relaxed/simple;
	bh=pBy5Y9UJV/YTPZygQuVpdk8EG0bLqHiLdXyEpu7mqng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT4uh4LY4TKeuu+3m70Zkf8dT6i4DxBBQRyIWATnk7/k1GA9NyrFGvNIogS/cmTI6NhuFIrbBqcqy0ZRx5ATyXMAcybHnSc4jSssG4gK4PKkOQxWIM+O25Kf0t3M68dld9E2g7IySt1oO0uD+GM5j+uwxn2bU7BgBaONSsj1VgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCKmYNUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCKmYNUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6C21F000E9;
	Fri, 19 Jun 2026 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781899017;
	bh=ZAB5E2ns8u+SO5NzY4BCpr9v9aao+X/uB/B0KIDmAFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aCKmYNUyxg4C3YR3MYZ9jnziyrUSInr0Pb7GiFokHuyKCKNL5nJVWTxgU5xgoIp3z
	 Xm+ndJIZ5ck0JfvxfWTD+Fo/hKUEBUNa05xHVfWSw0nTntgpxh4E2XCyUe7Cz96eHE
	 5t4TdMvg+EtgejvW1jD3fY/nUNCld5vgDFkHDIfBeJA0BEYQD897vKVx9Nuh3/iI/w
	 ZoS5X4n0hhGTZSC+PmOPTAaSUjFNsEr+X7U3MVjvs80hZfjnct+NanceSrWqbgtf+z
	 V7WDvwCRC6OgBKeBeziwnZibiCt9Hfj2TzWWpSLESvbZr6ZWhBEe5sVLaWzYbf30rk
	 z+Y3gw3ohQ8dA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 06/13] mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
Date: Fri, 19 Jun 2026 12:56:48 -0700
Message-ID: <20260619195648.64015-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619194745.361EA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 19:47:44 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] damon_nr_accesses_mvsum() causes a divide-by-zero kernel panic if aggr_interval is configured to 0.

I will fix this in the next revision.  For more details:
https://lore.kernel.org/20260619195232.26053-1-sj@kernel.org


Thanks,
SJ

[...]
