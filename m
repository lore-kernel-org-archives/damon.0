Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58848EC96;
	Thu, 10 Sep 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050163; cv=none; b=YJ9b7Cg7LYRiBe37GGx50LkBQE5he1EfpkWHP8mDoq6NMX10zbyXbXRIDlGf4F7uaaWx+mu4I/grt+rE/d18LLA8KKaRdlIQqSJPyOjOkDkT0HSpW5WFdC4J5pGSS2dZtuJa3daxVsFOJEHs1OnxCWEObNPDFLQKJ8b34MxIEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050163; c=relaxed/simple;
	bh=tdMg/rAzMwGV8K21yBEvNt3ifahWAbuJJNcO+LoUH3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boF8cg/MZa98UVUOV2txkOKOTzUmyZCp7GxmT2+AGg2/hGy38pzz1xVdtHDC2NPeu0BIXkhg+0bs8wwhGcoBiFLC8MVquDrf3WbKjY/pucX3eEir2mlF5NvZz+E4ODe8DcgeIzH1MjJf3rdjQA6YEqSPiTk/qahy8l2QRgc3/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrUOBzYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrUOBzYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04D41F0089A;
	Thu, 10 Sep 2026 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050162;
	bh=tn9W742GaDY7vW9qUrTT7oroxJHcL95g99YMTLAp8qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KrUOBzYOGFLH3xJVEyEG5PEb85RdtuCu6bBryCLW51DkVrE4i4pqJ7rj26EpP3PQj
	 vV1IVF/1joJqJUaE9uCuMAzM/3BaftvFPSMIyNmXn9v9KQp63n6nVHJY7zrvSOGxwD
	 fKxQr810Qd7XMCYrUifJGvbjUxX5xC5HMWEmuasxVjfOpUD23ClBHvGuQmeZIHmcHi
	 8NcCsobkCyGd3P/Zw0DfdmJP3pXeWQNnjRugfM6wJhJ9kCTiZmR50opX3OHlMYUXuL
	 bIQcYZPyr4Srrg1NXVGVugkMIdAAY5F7H/H3XkBQOkLOpQgApXTAedW/34LpDsK0/m
	 CJEzr8GSX5F4A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] mm/damon/vaddr: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Thu, 10 Sep 2026 07:22:30 -0700
Message-ID: <20260910142234.171562-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910142234.171562-1-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON_FILTER_TYPE_PGIDLE_SET support on the virtual address
space DAMON operation set (vaddr).

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4aecf34e39be2..d5dde97b3cd0d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -550,6 +550,13 @@ static bool damon_va_filter_match(struct damon_filter *filter,
 			matched = damon_va_young_addr(folio, pte, pmd, mm,
 					addr);
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_SET:
+		if (!folio)
+			matched = false;
+		else
+			matched = !damon_va_young_addr(folio, pte, pmd, mm,
+					addr);
+		break;
 	default:
 		return damon_ops_filter_match(filter, folio);
 	}
-- 
2.47.3
