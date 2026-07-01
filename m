Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00676360ED6;
	Wed,  1 Jul 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917309; cv=none; b=fddBgSY/wUUu69x9Sr5XSxEIDx0qjg8UUqClcDCCNEZSo3ASHhW/UFygAGykNj3nmG9L5kBhcd7io9X+RxNceA+5TwlU6yFNCLLXwfrqSHfZXnyV+81Z0jXRf0um3n7xAxFoPIEs7zZzCcZlSleAmLc2Gpn+8Q594gszTGsj91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917309; c=relaxed/simple;
	bh=bdekqXvOVoaDs3Ln06eDJGdKKSdYIc1OYGapj3qJYd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOdx9zc7Ic+h/b9o1rLjxx3n7y1QulXcHOMMgD5VVpcV6t7+oiQJPZco8/1BAh16xF8zhCS4bG4BYh/yAtzdR6lzzjfk6hbsza+WWoxM1LOjV1sDCmgDnlGB3t4IMJid1cwGHuoOwyHHaak2WF0H8MgBsZVoNXdAgwetnoTFQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef1kytGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef1kytGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991B21F00A3D;
	Wed,  1 Jul 2026 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917307;
	bh=5cBYap3I/+j4x4ct/1Qkcg1MmF7CxIgWC1JLwxymeuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ef1kytGxIlm9+IeZ3gf6w0dQ6AIqWkP5gaPwK+NBTWchJf9jk80+9vPq2C8lxdtLO
	 SC/NZ/iuMhPJieCxVpZnTGcSgbuBPIRZZ5r7sUcnrK5jeC5dhtpUZn3lPR6GfQJMQI
	 /Rj9OJ0cIW8oEQ0KB164m40hrCmKWgksmERooV3l58FtacpjrG02qHsdjBj4qMlAiy
	 6jLgahisGpdMtsxE4yzxoElgB/5Qz8MFOg82CN9hST/szLnbxCTRZ1TP8upM7G26ee
	 vHXvA03bBRT0B7wG/OXjWDah6xTDBG0nc7WLiTlUGwmATujBpOdfQ3yoVbzcgCHlDQ
	 EFkpz6GhYLK0Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 7/8] mm/damon/core: remove start, end check in damon_set_region_system_rams()
Date: Wed,  1 Jul 2026 07:48:09 -0700
Message-ID: <20260701144815.113325-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701144815.113325-1-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_region_system_rams() validates user inputs to avoid creating a
negative size region.  But DAMON core avoids zero size, too.  The check
is incomplete.  The complete check is done inside damon_set_regions(),
which is eventually called from damon_set_region_system_rams_default().
Drop the incomplete and unnecessary check.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6b30cb6007e54..3caf1b67a7f98 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3847,9 +3847,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
 {
 	struct damon_addr_range addr_range;
 
-	if (*start > *end)
-		return -EINVAL;
-
 	if (!*start && !*end &&
 		!damon_find_system_rams_range(start, end, addr_unit))
 		return -EINVAL;
-- 
2.47.3
