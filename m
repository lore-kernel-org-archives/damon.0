Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87D39DBE5;
	Thu, 10 Sep 2026 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013366; cv=none; b=X5xqJM26Y02JZmjKzOBGSMAxWi8R8sUtaK5Mfwe1+zTrj5Jc8H+Te0EqIHrBauizIpuOzKFDn4sqz9G17gfkYTofoItbYs6nSGVmb/X6toOUOIZTr69uy7j9HOy9Ity/UJ1JKNnnEz/oxBfYFu5y3hXTU/582Jc7z85EFJ/Zce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013366; c=relaxed/simple;
	bh=UYNii2J9N5IeNLw0Yeo1sxB3yu/PmjdINz6uaBoZpFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6tuF8pQcYprEQuyydYyVsjK9OAKPQZQ2Uc8Fm7xJxNxjzg4wSrz7lSE82+zPY+ueZFVZOg4CEJm9P+W71q6MDENcnZ/STZJK9zUYPuXAFjvVFmWhITPc+3WzE3qBaQ1jBvVmZkwyVBO1/zQoIXvNX3I0NT4p8j/fIxtubz061M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8RVJyHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8RVJyHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857341F00899;
	Thu, 10 Sep 2026 04:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013365;
	bh=2EEU3ekWc3qyXmh8drgRUKtX2xzp7GdjGEtLM6CGh4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J8RVJyHVAo/EbuUIAmOPKzIPPGZRytI33RXRSf9N5aSlMIBt0co3sWVRBHljS/zUP
	 kiUtyuYUw+WeSFndKgDowKfvOzQ2MzUDsgaPE6Lhy1HOCJPTYZiQ1JjnFsi1pZEI4d
	 EN1xs8TiNcYpLylfJ0o0//joKE1XIxs3FCSLadsxQvXRLfLFTFMGTRaXkm9QISbWaa
	 Cf1/uE1HwqPAJfQvGwRffnzgGhhaiXPOX6tw10ig5t50XxXrBCu20B+6fBk1Ss+fC1
	 GDcP8frrqmDPWMPry6mD8AdhL4UojBeTaohRcdrdNrMADfOETqz6wElKqB5Zgf6Tid
	 ze8UZB5ZM8zSQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 4/5] mm/damon/sysfs: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Wed,  9 Sep 2026 21:09:06 -0700
Message-ID: <20260910040911.148273-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040911.148273-1-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to let users setup
DAMON_FILTER_TYPE_PGIDLE_SET probe filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b576e97cbfdb8..51fa506c879b0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1001,6 +1001,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
 		.name = "pgidle_unset",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_SET,
+		.name = "pgidle_set",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
