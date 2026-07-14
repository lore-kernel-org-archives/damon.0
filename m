Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDC4446E0;
	Tue, 14 Jul 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039757; cv=none; b=fVxtu3h4JfRXOhNjFjJXHeLiX1t/uL1a1pbu/HtXkGuL9D7WWlPshbzyUBABJA5X1I77WaiFfv0Dr2E2Dx2PF30b9+Y9q2XHrh1aO2XC2L8fFGeyb/lUv/ToKqaiGQAfL9tPJjyalfolAHiOUOqE3BnkF3mHllPqSc7wrgdNxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039757; c=relaxed/simple;
	bh=/YooC0Og/qESa3EjUx8EinIYLgt3NHWfzDOzYxdEP/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwghkgjaSVI/24RXLraxg6x/yWwLqZbdaw6cbwJdnZfGwGE1w/VDtI01gRxtiacPutomVeyhQHVC2/iqfHmxJnh0RnWOfn1ecio4naUxCfVTyeJ/rZ/PyEKaUfiOJFRpQ4ryIcDmcYQPKwrqYb73TLsG3LEp1UBYEgXZ4b91eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnjEMvgF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnjEMvgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957F31F000E9;
	Tue, 14 Jul 2026 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039756;
	bh=K9M+/498pDyKMm1s0mlHFjJL8e/IqqSwdiOP+0fBImU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnjEMvgFAHBy/bzZQA4a7f1Y36g5vw4oxOI3sJN/eEZTgH4K8axXPJnwr649a+LFa
	 DlbXW0ZCc5W06Wuksp76J+nGs2n6y+gQu/2x4rV1S7JZ6R/f6HSbjDk9gX6yA0nF0r
	 7sKafT7Og+gChSqB8vcM9rj4dWncysS+TXLjhs6thBw+wkPC4z5yvvVZuzo+V00S2s
	 n6xx3u1qr7rFe1ou6nF8dohhyKs3foNBHilrfNSyZ5T490c695QCroKE/uvZU+DR3E
	 c8cSOlxmtTQO+9fli2Ju/xndl0khBw+w5HQBbbZRt28kn3+uTBzow6denRKj88hF6q
	 MQEKH2adAzeQQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/10] mm/damon/core: hide private damos_filter fields
Date: Tue, 14 Jul 2026 07:35:38 -0700
Message-ID: <20260714143544.101305-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_filter->list is intended to be used by only the DAMON core layer.
However, it is mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bd024b89adfa3..15517be3e4960 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -432,7 +432,6 @@ enum damos_filter_type {
  *		&damon_ctx->adaptive_targets if @type is
  *		DAMOS_FILTER_TYPE_TARGET.
  * @sz_range:	Size range if @type is DAMOS_FILTER_TYPE_HUGEPAGE_SIZE.
- * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
  * byte of the region matches to this given condition and avoid applying the
@@ -450,6 +449,8 @@ struct damos_filter {
 		int target_idx;
 		struct damon_size_range sz_range;
 	};
+/* private: */
+	/* List head for siblings. */
 	struct list_head list;
 };
 
-- 
2.47.3
