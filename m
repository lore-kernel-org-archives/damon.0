Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE579DA;
	Sun,  6 Sep 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717019; cv=none; b=CHB/f0jsfs1Y7ipwIgwVQnSEkuCM8h1mlytmLpffg1KLWATXJyW32COFvTEqs51luOaxje9r60nkLqcABh6XmFbRgoHmmDW/g0/ZFRgbuoNByDj6P0eEjeCxEXwPedjmv0Zuw2f4ClLc8/F1NWkkaF2p4kO1jddD+YbqWztDSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717019; c=relaxed/simple;
	bh=RvGLqxsrALAINsiZteZKAvhH/v4iatUyChHXT6RNXKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVz8W01vEGTaLN8YlnP7Tg6YJrtPsyoeFdSx5lQmW3GOimXME8JTelnR2damnF8KR6BbygVvgzffAWGfdHYtU+ZSgwGOQpkjrjsM/upu4iy1eAGr13MQGCHFH15i9MsZJW6kYtSJ8a2G7X0bpOv8cKplYRbRahng6eILAcM68Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPwMeAyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPwMeAyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC08F1F00AC4;
	Sun,  6 Sep 2026 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717017;
	bh=u9caat1DezSKbkpbmOqFRGnH5jIo166ZKqznROpa2/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPwMeAyy1zN0zViRcHCHpIXrbfpEzl0oLLicpp6K2n79LNSsX9FPaYCnG2uEEmoBO
	 1TfNYupDip/RSKBmuPRpDO72DgiQn4Q5nl+a921wHsPmNsozwgyUYZnE9yMoMIfjgx
	 AZJYvc2i3zaRB3BGIg5DlX5C894GhNKijgYziij+KEg4GDAprt4u2mU1IW96Mjac4g
	 H+rz/9AqbD6A1FuJl2DLpsJ+IEBS/AH0lIjDq5tWZtnp16J2DgdA1ZXBz2WJuqme3K
	 IYQTOoUc842UlENHQAWsFThkeBtti+p8taHUYkEb8oTEUoL0q/3sZfTCGOL6m1SXRL
	 uLjeawFsQDjhA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/5] mm/damon/vaddr: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Sun,  6 Sep 2026 10:50:05 -0700
Message-ID: <20260906175009.93471-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906175009.93471-1-sj@kernel.org>
References: <20260906175009.93471-1-sj@kernel.org>
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
index 9a38dc89a156e..7063356370c34 100644
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
