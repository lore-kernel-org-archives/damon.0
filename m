Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D8426EDB;
	Thu,  9 Jul 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605970; cv=none; b=W09bE4KMHDQEOx+IrtrE6luqX1PAauxdbSimZ+mojewArWgYvgUAu2rt3pkPaEKly47IaRfqv1ccX4PVrkFjVycCYiqLyEe1e0wQNqqhSfx6XB2YBu+4h6oSCr2f3Ufq6YXmoFubHeqUFu0odT3QRbu2zC5sHnbeC888GGllztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605970; c=relaxed/simple;
	bh=z/d5efjTubNvC234s0RbsdkSQHPJQ8dSubik+FCcmjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBJTUlNgFCjfCloi8V6WN4JG/OsvqQdFkce01HsdRo82AoUAM+Mb4ukfGeEVg27D+j2dckvr6Vdkn2B4IcpwHUDCzXLwUOCLurBHulpQ2fksGUCWKTXe1g77yF0ZFuLRO7vR6QzTF8S6bNxb1z8WYXi9gtCRi/AqIbj+ONNgptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKda/8Kk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKda/8Kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE531F00AC4;
	Thu,  9 Jul 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605968;
	bh=ibGLnCcjbBBeYSipXvEOLcsc39tu7yTI88ewylASLiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kKda/8KkTpzWtIhthgfP+t+vMJfnwe8SlB1loMD8eVeFj+//HmZIsJkTq42mkLq4X
	 BnVd2fq+HBz0XB4eFCyjTUQmiom2Gei/OYA+mGjlUCYPQZWURKEQ+foDBCPBoKuNE9
	 pEYoiNiUUqyLpNhhyqWWyOItvYbD4Zhtr8IAOr5/YUIU5u0Sg0RyDg2aK4xDvbVsMr
	 56ietg39h++6cAz+hIlmTQk6GARVL005iEaUC34v+np5H/J6XZed3J1OIq+8AFD9Hn
	 0hUbJfs958cCxOqHE7/jzEJ4GmPzFdKgQs8pBHQ13j3ATCExTVBbT51zDfDS2LgFJ0
	 CpgRm9OyxALkw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 15/19] mm/damon/core: implement damon_has_probe_weight()
Date: Thu,  9 Jul 2026 07:05:53 -0700
Message-ID: <20260709140600.90950-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitors only data attributes when probe weights are set.
However, the function for detecting it is intentionally returning false
always.  The intention was to make changes for complete support of the
mode in a safe and incremental way.  Now all the building blocks are
made.  Complete the mode detection function so that the mode can really
start working.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 12c66edecd783..6661d4bfab5b9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 
 static bool damon_has_probe_weights(struct damon_ctx *c)
 {
+	struct damon_probe *p;
+
+	damon_for_each_probe(p, c) {
+		if (p->weight)
+			return true;
+	}
 	return false;
 }
 
-- 
2.47.3
