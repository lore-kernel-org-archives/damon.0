Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774548;
	b=DH9737TK+s20qtTZbfJuPxwINk9lGtev+TwyJBhNuKEMksW+jxjA+W9aSbvRyKHKG+07
	 hdajeJdhYyIcXnpFgw+rWuQU6zcT0AoAAnhkRqMim9mEwvYhKRQCU966osOrVgLanMcr0
	 S0mxEb2+R9lhU0A7Fgc2Oq+FZUUmCGqCKcdfnzyhVA4eyIE3dTVfJ62GJMekf4AiVIUtq
	 9UC8eh08yh6sEr9U66YWjvKFZMt6QRAGVyTdlbnewUliC9pNjIRd8D/gKjmTnEHdox1+U
	 Zui0RaZsKuTzgKv7F9uD0kA9GOJZ+6OLV+JMSeLWOVlw1AfgsM0VEcgCW8NXiliUukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GO4qPmpKkLYaXtklU/IsiZJrq+Hr5ONxZjvupaws1z4=;
	b=EJWD37t4dIdICNKtB/dwO0VS2yYsEY5lfu2FIy+rXn3795TiWkymjnOzdfjoGJjJT3rX
	 OUyjZdSJMaIJFWlL6met685pHzwt8p6E+CLlFB0uayvzdPd91y0nP2tlGTJpium7mJZQP
	 rXepZnpOsttgFct1dIwXWUv05pSx4D7YrR7z7ZL0iOOG/Wt7keGkKGOSu5gvIzhIGxzh7
	 q7f1Bv52QBg4cQUtKR5lYNYiOe/fPoXdnQUpqDOqN+3hBbg/983Fg2DURyloNtfIeHuAC
	 m4cnxcEgvRYpAuJgqY3ollMV9lFauIB5gXbshczFKudkObWr9AR8eG+Arx11IfhbNFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNde60AY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03A60A6F6B;
	Sun, 15 Nov 2026 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNde60AY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37641F000D0;
	Sun, 15 Nov 2026 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774548;
	bh=GO4qPmpKkLYaXtklU/IsiZJrq+Hr5ONxZjvupaws1z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oNde60AYsTywB6ie+feFYh/TvlfQ5LKFpsCBUi9JahDZIkzUtGieYnjtZWpoyDlQQ
	 5YD4DqtIJvBRjFKqUJERpUsNvUGFdzJRzZxiYFxi68JdZ/nmSs+5/QBcaoy5b146oS
	 0d4JlvSSwkU1nPvpEvTDKoJIAuwCnSsdZssu1WqABfm8FDVRzYC5y0T0S8jILVs0XB
	 SgyG4kxNkznS+PTUvcaeyFg5qghSkSjkSlB9yZx6sYM7OCbE/DBp3YsG6xKlCPjFLR
	 SGcrJwrDA/bcRiI3BfKY9Euu3MSuizwOE7dPes6nm4wdrhis7s3DCaBXE4TU88TdQe
	 nZyS2v+p1qNCw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 17/27] Docs/mm/damon/design: update for report_made probe filter type
Date: Sun, 15 Nov 2026 12:28:35 -0800
Message-ID: <20261115202849.99134-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added data attribute report
existence type probe filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e0eb53d7694f7..68cd80e2788cd 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -303,6 +303,8 @@ filter types.  Currently below filter types are supported.
 - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
   of a given size range.
 - ``active``: Same to that for DAMOS filters.
+- ``report_made``: Matches if a :ref:`report <damon_design_attr_reporting>` for
+  the memory is made in last sampling interval.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -382,6 +384,10 @@ depending on the type of the report.
 
 For now, no report type is supported.
 
+The data attribute probe supports the reports.  The probes can be configured to
+hit for a given memory region if a specific type of valid reports that are
+associated with the probing memory exist in the reports queue.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
