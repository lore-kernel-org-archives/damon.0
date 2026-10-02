Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899F2DFA2F;
	Fri,  2 Oct 2026 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964702; cv=none; b=DaaxOs+K/MjIMCvbygf4Pff464VueFaDbmyHEoKR+/1oSN+ugnENCko/8J7973mVMf35LU0n+hi2yvtT9QiKfsQYkXHOR9mfIplhonqxulIXtfcJLDsr972ujP9W5ww+XQBYmFkG0sqbIKFpG7p1EIpBUcQaAQOEQJ6CvJi5Gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964702; c=relaxed/simple;
	bh=KKtf8apJFKPJKWasfaHRRVzkCEmUu3Hn3/EINo4iKgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYZIF68SqkRYZjIk4gr8rOrS1Fk9AhBPDA0regvSjkk80OVOYbGNoTB6r6FI7uVq25giiC5blg6cP/Ma3pm77VGRr8Ly+079TJGsnW4UGo9mch9mcsv3hSObYHpf0SwHurEkY6qxybMDBN+vfeWvA8P5v3xeaEOL/QAqQoCbfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA0fQUr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA0fQUr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADA71F000FF;
	Fri,  2 Oct 2026 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790964701;
	bh=CP0MsROgLgfuaL5H6Y5umaXQ51VIpkOCJtpOwL5TQtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EA0fQUr/fj5O7sfp2orAz+pVzZcRx1HqK8p61QAJwe/iIs4PATGeitrNzt1SFHiEh
	 BRMbUhG6d2dpPJR0HQxtNOUsCkORVI9hlYONcmzIcPAsfQUogywTIQ+qYAyRWKNBMf
	 uspDaeKEIR4ouZ+UdqGOAS+LVfJZ9BsdjDS+OBBE5HbVJ6lX/2e1+Zfdb9QSq9Z+zd
	 ryMHLs5zGY4u6VSXdw+gAHe2Qc3l1BvD248FjU1cd081Qw0jZTwANgFvn+M+BJNnaK
	 W0ejJ/u2Rvn/y2MYgOUwvLsv75J7oW7F1Pyn9ucEeAY8DTQKAhiKhWdKJ6Rj0J3TFa
	 VRG15XLDgJ63w==
From: SJ Park <sj@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon: use damon_get_monitor_folio() for hugetlb entries
Date: Fri,  2 Oct 2026 11:11:35 -0700
Message-ID: <20261002181136.46472-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002140727.701709-1-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Gregory,

On Fri,  2 Oct 2026 10:07:27 -0400 "Gregory Price (Meta)" <gourry@gourry.net> wrote:

> From: Gregory Price <gourry@gourry.net>
> 
> Hugetlb folio acquisition is open-coded in three places:
>   - damon_hugetlb_mkold()
>   - damon_young_hugetlb_entry()
>   - damon_va_probe_hugetlb_entry()
> 
> DAMON already has damon_get_monitor_folio(), which paddr uses to
> get monitored LRU and hugetlb folios and to filter them through
> damon_folio_acceptable().  These paths bypass that check.
> 
> Use that helper in these paths too, so that DAMON acquires hugetlb
> folios and applies its acceptance policy in one place.
> 
> No functional change intended. All callers reach these paths with a
> present hugetlb PTE under the page table lock, so the folio is always
> a mapped hugetlb folio and the helper always returns it.

Thank you for this patch, looks good to me!

> 
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Reviewed-by: SJ Park <sj@kernel.org>


This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
