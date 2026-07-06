Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFAF379C53;
	Mon,  6 Jul 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346802; cv=none; b=VHfEv4029PJ2giOeEG/HeuwvRO63/MORIapF6w3kQjFtBx7tjYruSxPZAqBoYbkCwIcsVJncGHPrQdyXp/MmRsP3Etz+8gFB5q2582sLkSWhujz3/xbFi9Ty9iJdQtY6iKNtRQ003+QT8dLO3HPDofpf8KGV1CJaPyIAiX2h7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346802; c=relaxed/simple;
	bh=apYwkYgjta09iatlAqcBQzxffoVQ7J1TTsvqhGbrFRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSpdPaGbk5XOFyTPMEPLCWo4VgGgFhoY3pb3MUcKiLgKWbSBr6ZPWoq+7Nwq+989KzWrybKiCiR8XDCXSNLI0XZIkhUnk88bPOT+FtUwUnRsQ5FpbtYt39Dvoo7GvIx9ohq5spC6LzgPV62+Vmsmmc6zqDARsuRvVxOdOrHqu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekfWfAui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekfWfAui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83FB1F00AC4;
	Mon,  6 Jul 2026 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346801;
	bh=LS4CO1+OYp8+pSPAS3NbVTVyYCl94ZecPiNEYxC3hmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekfWfAuitYuwonapsS/11mTl8oLxfiZ2cBK1kLPuSJpYed67fF5WpGEiA8qCLTeHV
	 pw2EgFq2BiN8RqJZ/pLrwxVU78kOUO7OR8JKvNbquHZwx5yosKyYIOHWFX31OuRytp
	 uLDPB5rGRFTp3vjUT3soJOBDfvJbcUgwbb/Qq7sOl9dZ1hRau47Y1PdPdPEKnhJ0VK
	 Spja7poO/Y/hm7JfDLQjzy5U582amuse6yO39Ujs0n1aMst3gKbmUp4B4kaWMccWNZ
	 PeDR1rK/7cDV7X51YD+Tu7sFYtHD9UDvFiqO5yoIHlbt5VBqSFTqVthvnno33EV/qK
	 76ODUHFS42ZbA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/11] samples/damon/mtier: stop all contexts with single damon_stop() call
Date: Mon,  6 Jul 2026 07:06:23 -0700
Message-ID: <20260706140628.87414-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() was theoretically able to return failure while keeping the
second context for mtier running.  mtier stops its contexts one by one
with two damon_stop() call for the reason.  damon_stop() is refactored
to always successfully stop all requested DAMON contexts.  The two calls
are unnecessary.  Use only single damon_stop() call for all contexts.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 90881e8bd441f..ac9c24b92ead8 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -200,8 +200,7 @@ static int damon_sample_mtier_start(void)
 
 static void damon_sample_mtier_stop(void)
 {
-	damon_stop(ctxs, 1);
-	damon_stop(&ctxs[1], 1);
+	damon_stop(ctxs, 2);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 }
-- 
2.47.3
