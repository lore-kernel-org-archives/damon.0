Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0743BCD13;
	Sun, 26 Jul 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087586; cv=none; b=gojfVt8VCXhWMLnrBGxbBEYOPmu+BOi9cz3+MsqNSihDjWdB+IyOQp3Yg+X2BmuNJNiEnkWIzFoZujnYhhTVmVkecmVbaJWRPPDMUPq2YfCZMJPvB0YHQ0/+WcCN9ZqrtXqXCMJgFSzW9hgDFYQs/xi8/qUwwCDD6IPTkRf5+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087586; c=relaxed/simple;
	bh=o3hI53B8za+nhkok//HqpRTOEsjaqqLqJHmMQj9SDvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov33T9gs4Ss30bBxOqIEKRnxIBiuO8JGZ7r2VlMxws6w/bjRC1VtE77UcjlSl0Yc/D7aENyrwtklvoTpETfDePi3fIU4RPKdrWsLfTd3rw/j+P9Y7q8GKZH7h1k0r48CH1Xa+X4BzafEsPaHW2KSIE6W9NrxSadpu8BnYNzGjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4CXw4WC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4CXw4WC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B8A1F00A3E;
	Sun, 26 Jul 2026 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087585;
	bh=cAfIlLPcU4sckuDrbS7eOEg3BQtpmGkcQ7Y936FLtiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4CXw4WCW3mBgPGYLEXYsHKGA6SOd5AWjotEtTI8prTvmoLIRK8+K1m/Bcdzb2I8e
	 pLwV/wDUt1VaSa/QfRAolYHlli/CLfdF0oiKi5pemLJtNFbt4OfxzYW/jcWDWDkC7a
	 WaEu0s0Va3TufnxXofGwAqZVQLw0rwR3xraP7ZAZVXgNfeBXJ/7Lb30enAhgd5ogHb
	 kwnK5KcrVNi1vhpuDRg6FgmjZ1UYe+ZfgnV5Ko1kYtLQf8osVZ4zJ5k1EKCV54R0TC
	 FK8Hs0ErxeczEhbq+MaujwIEeHlGfqXc8SRrIdrOpIzA8/drv+EOoCyJ9tRQ+xACqc
	 f0fYsc7dPNEOg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 03/17] mm/damon/sysfs: support pgidle_unset probe filter type
Date: Sun, 26 Jul 2026 10:39:19 -0700
Message-ID: <20260726173935.94046-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to allow users to set
DAMON_FILTER_TYPE_PGIDLE_UNSET by writing 'pgidle_unset' to the probe
filter type file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 053ba2e53b969..376c6ecbd4bf3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -782,6 +782,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_MEMCG,
 		.name = "memcg",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
+		.name = "pgidle_unset",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
