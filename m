Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B845908B5;
	Thu, 17 Sep 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654941; cv=none; b=muVo63Hg3C4jXGtKTP4r6PpipPQT1FayYWgL8TZOuYlCgiN2UQSPRi+T0WKsSqdR7nVtVzxGLoZp+mlWsMf7rxoC2hGv9AQyQIu+M7JRfZtbE9p+nNTppOvV6YnnSG6+b3Gi7c8rKOI/63JkPZHAEGsoXBimREM44beschW8bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654941; c=relaxed/simple;
	bh=5x3DivB9gQB5lxNvwTlsjIfeudSnzImQeh4vtHJ1uLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZLDjtPNzMQGrjKday7WC2Vp5uPiO8ysnWDcBq0ZiYXijF3oxCg9aAvlUy1KcwJU7U0VBIeKb4f3uuJ3jzbSZjUlfmxOrNBucUC5y3gIKQMkcDxnmBBqs/NalJCldFmG3Geiz9zdUh5wvdRSbR7qJjCIuYt0wvi4vgOd4LY3XQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybj0/BVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybj0/BVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39F31F00898;
	Thu, 17 Sep 2026 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654939;
	bh=T7NGmBAgLNyxB6QRiSTsc0KXNRJO/iSY1w2o1E3csW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ybj0/BVybpVYjI52lmYjn6CSqa7w0qBacucLk7YHbAiTAl7Q94Kyqhxgfd3mwuOSb
	 Y+b9VurEDucUbgBMrq8NEzYM5HqPVxdg8LEUkeFI00h/MqIJfrSnkrSDVb2cVrrqlB
	 Rae2oLyzMmfBor6ViRSYc/GpIAdKnM8Vbfe8USRFmk9dcTd7uwi6fPMmTUB5BY9XwD
	 QyNEhN7x6lAh/w1Ug+rYSeyWDp8DpcKbJjNy21Xc12juc7h4VJCfP4WnLQxQSi/Nj1
	 /xcOfbSZOAnwv8QANoux2AAuA5iFgaYv9pPwHCfbmNrrTQImUmP9XXiPYDQHaYUFPQ
	 fqhAfvPZj18bA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
Date: Thu, 17 Sep 2026 07:21:59 -0700
Message-ID: <20260917142210.90829-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bbb190b474015..836353c4ab9aa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -400,7 +400,6 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
- * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
  * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
  * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
@@ -422,7 +421,6 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
-	NR_DAMOS_FILTER_TYPES,
 };
 
 /**
-- 
2.47.3
