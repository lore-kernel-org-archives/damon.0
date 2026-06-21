Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47B2DCF41;
	Sun, 21 Jun 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057462; cv=none; b=nMxFdzc5WQHdwMjNxivaCddVBUXhyqBCCXRUG/oao9RXzb1Ds5yBXqgRV5/gaikQLFgpdYejg5B9zA3X6AaVZ5hUWtdFrAH98iO1DI+z+svR58sTBu734rWCn3qzCldX/3n0KNkM2nzx8WKV/93/DbhcWpuArt0PMQRejQGJ1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057462; c=relaxed/simple;
	bh=ckmKQgjNP1Y3L76JDcK/l1LXO+8dsi+M33MXj+hcDAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYpG8DHtKQdwPr0bUlGN1w4koCDPOq7a+36K9I7lY7oTHpRNbOzOWannXLUm3/MWMjBv/qVB2TpEaee3lDkLkgKrrRISXwHMvrQHFpNF92RZjWHorbkksl8TiYHMWwIVPXu27UbYPNXyzX/GnP6eK1GimOq1stSJ3++OFeID3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmmKZVr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmmKZVr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FB41F00A3A;
	Sun, 21 Jun 2026 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057459;
	bh=XBlT7kxUiLnizW5xmXI1w/7C7n4H7InmdeB786HKy9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmmKZVr/AJUUiclVg4XsRJbSssuEq0AzdJ4cju6mfaSjL3kTPLac6pYFcTU4t9yqb
	 FEn6NGlDwOXcsjgpRcZcbzdlCiekDwXnnaTc6GeP9NnTMwQbgcu1JCVS3UoIEBbDoC
	 QVMTznDjaBX8N0xXoV1lgv0n9Hp+LPU7VyMNJt/WHGN/g6CKbuY49XP4f776Xpth/9
	 AqLxmU8YIuhanr9tDeMGpvpy4JTus3vQOG5Ee+aAnwI6L9vCE7O10rox0C4acTWNpx
	 8EusLQaR2HBLLmXljwWS/JRXUjeTxpSEJBYGUu1VliZoyhh604dGbdUUC9+S7h6vxK
	 yiertDqaOzDUA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 11/17] selftests/damon/drgn_dump_damon_status: do not dump nr_accesses_bp
Date: Sun, 21 Jun 2026 08:57:07 -0700
Message-ID: <20260621155715.87932-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is dumping nr_accesses_bp field for future use
case.  nr_accesses_bp is not being used for a real purpose, though.
Hence there will be no future test for it.  Do not dump it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 26b207e44268d..09552e91bc782 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -59,7 +59,6 @@ def region_to_dict(region):
         ['ar', addr_range_to_dict],
         ['sampling_addr', int],
         ['nr_accesses', int],
-        ['nr_accesses_bp', int],
         ['age', int],
         ])
 
-- 
2.47.3
