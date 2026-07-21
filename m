Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB937F8DF
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642788; cv=none; b=hUvPlCab2qu7UGKd6QLQ+MDZ7BCB8uPpCcpEg/z5cokLbMP757kOWoiGDAQVxXTdc4ASNXDeHbZR0pTg50xxozA9UUN9XhKHyp+iWDoaD6yGQe/yzyWKrlWx6pVvgziGnrtzuueobKdanFoGS2Jx6cfPRlJ8KyrXMD7Eyc7oEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642788; c=relaxed/simple;
	bh=8l16zc/7OK0rBoO0elilnfaTQI3qTEGczZdo2vMLnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIUWpVHDNBv7/pXgOOVyJ/1e9sJ3qqt6ciKlq0P+f76JC+9libBDxJ7baRZkIbbop3p7xX05oFsY2cAoh+Mp2CnGSwGw5AApV70BDK5sBIC7DfaIyK0ulbaRJl8KiG2JIEslv3nzKEF9YuMwWr8DyE+GljRjJJf3XHupxhyH66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTokIeXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTokIeXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3641F000E9;
	Tue, 21 Jul 2026 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642786;
	bh=CdhiAY3AR+DWlx+cfFlEkb6gx81e+qOTJQ6399p5XX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTokIeXIv0qyStkdpnmS+y+AQHlDHS2hFIEnc6/i0lw6uIKD7qarbgCA5oz+mjWev
	 9mLc2McjUXzHaf475W79BvctBYhqr9jgx/uKcQvnTWLwjAm7tmc+lDBMdr7jov62iL
	 9PAMjgxK7yggvD+6u26v1MFd8wrnzR9WtdFbx11qYv77LipTtyWlFaH2Uvy5IPpJc7
	 x2dzalMX47/mEFfSHtFr2SMl8l6WM59Dlvi1wHAPj4o72Tec3DOirezrsSgIX8FtcK
	 q/lAhiuBkSyUfPGIKPuE3rzjY6IgVJCC6gcutsAP1NwDZn6KLPiCxP2nRr4QneY5Aq
	 K3kbZx4LSOXGw==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] samples/damon/mtier: add comment for struct region_range
Date: Tue, 21 Jul 2026 07:06:18 -0700
Message-ID: <20260721140619.297538-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721070756.54435-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 15:07:56 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The mtier sample defines a local struct region_range using phys_addr_t
> instead of damon_addr_range which uses unsigned long.  Add a comment
> explaining the rationale: on 32-bit systems with more than 4GiB memory,
> phys_addr_t will be 64-bit while unsigned long is 32-bit.

Looks good to me.

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~3 days?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
