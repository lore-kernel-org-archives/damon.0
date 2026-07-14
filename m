Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5C2F7F1E;
	Tue, 14 Jul 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038777; cv=none; b=gj+gKPuiGp6DsHm5+tXZPidXWdP/slWqf4r7sA67Icm+vFbyvPFzeAye9uWxZzxPe6Mz12U+OcPJaFoGo2WXB94UCWgjTE07RrDA8mwCvj0XZ20dESWmhR5zGYEGfQzOTo3Zd9mC4JWKXf+XNxkypdGyGJnIxzInkH1hl8yCPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038777; c=relaxed/simple;
	bh=WGDJ84QFQpszpv2H8HctrIprisO0Y+K12vX4KiXOXuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQjvKmKN5IAFn7I7B2X+lASBtcejogcb7IXNF6wLgwRwjVhLFWh5EUrsb7IahrJTBJkYRBuVCm/SFrfKmJ8tnHHjTIswZhjkusn0vanxFayB6VzQEVnEQDIMw9YuYcROR9kw4KI1V4mFPXoksBM8g42er0nwFol5MjBvpivEmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xro6Eb+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xro6Eb+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997CD1F000E9;
	Tue, 14 Jul 2026 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784038775;
	bh=LOlbLc2qaG2QBOOhEn3n4/8lPPbfM5YgeFxaZ9vpRVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xro6Eb+rUE86RnbMJWxBwPCOXOCMH7r4XuDwCdsV1tSubc3JLvla0Aph2hDvOG2XV
	 M16+614h4x+Rn93ddAavC52RQAbBuiruOpohnIw0hBH//qTpW896P6JOsbKETHNn4O
	 xhwGZDPoS4n+kJdTT3m4P43Jj3SVT6u7xxyczirbqGY4CqjURmAuUBwTb7VabhPR9f
	 xjHxXlmc9c93vyEbj5LYWhCubJRoMePbGaqsO2ZNmkmXAptpzxBLw/dhznTFRivcxN
	 kDEqlZksN/p0gkc8mgeFCKeekhTd/owc8JmoiQQFH4rQmnmGymKTBe1fhyrwEYDUZc
	 nCMjFuz/H3WIg==
From: SJ Park <sj@kernel.org>
To: Jiahui Zhang <jiahuitry@outlook.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH v2] mm/damon/ops-common: prevent migration fallback to non-target nodes
Date: Tue, 14 Jul 2026 07:19:26 -0700
Message-ID: <20260714141927.100207-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To:  <MN2PR02MB665479119535A1235D69F125B5F92@MN2PR02MB6654.namprd02.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 03:38:17 -0700 Jiahui Zhang <jiahuitry@outlook.com> wrote:

> DAMOS_MIGRATE_{HOT,COLD} passes a target NUMA node to migrate_pages().
> But alloc_migration_target() only treats mtc->nid as a preferred node
> unless __GFP_THISNODE is set.  Hence target allocation can fall back
> to another node, and migrate_pages() can report success without placing
> the folio on the requested target node.
[...]

All make sense to me.  Thank you for kindly revisioning with the clarification
of the motivation, Jiahui!

> Signed-off-by: Jiahui Zhang <jiahuitry@outlook.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
