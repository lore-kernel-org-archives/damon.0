Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB42E1EE5;
	Sun,  1 Mar 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387011; cv=none; b=ax6eAkFNu1/eOx7rG47v2cJxwGeCw8gEZdhugN1wYUk9QjdGQrpEDJONFoSjzgunqq+eh3b2SfX+jXmfQv1vXhQvKEfOXuWgmsfCValBzVRZ6RU8VUfBVqod9AQ1Kfrj1k8sGzquc4jWA+RxkO7ZMPnnJZ1yURuqn93m9mAVeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387011; c=relaxed/simple;
	bh=BNmBp855yDuZHxGokx46EelosP2pYBbR2PhSTdYtR0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caydE4D7BB4N2+z9SH3RzqkhTju1l38tk2+14B6bJZpzeCIV5UqkEn4ELnmdk2kx/Nxai/UjVeqXW/ba+PbM5RVr05pLn8SWNzV8f3wEzp2eMtlQrTxHQQyetVOUH9VT8I/FhKjjttlNopKDLa+REjqqaiTlGQJzT4d/8DBSep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUbxeS22; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUbxeS22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B2AC2BC86;
	Sun,  1 Mar 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387011;
	bh=BNmBp855yDuZHxGokx46EelosP2pYBbR2PhSTdYtR0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUbxeS2211g8wN7uLQz6h9AuTbom7ZZgcCc6z5itDrzXT5tpiKoAfwCKWKYAFRrqR
	 1GaBLxPbwQseaYRjzrdebGBNebNJS5sKMbh1zui3pCpBozkaVHzrzYEFCG6SppXaYe
	 1InjYimjb06EgYOFJmlm2eVKtRNipbDRS+Nt5Ahd5o4Su/CXgWRmp2Y0J/GNTh8HnE
	 D7zKJd8QVVQUjFkAJSiqyQs9XnlJ3pTfdnMTfluB7bQ3gkbYbn+jrYmAV5N6VPlTyk
	 zAUzoYG8Rgy1HFNjA2N1aQMvbexshtnP78n8u/mxiG6CrNWN8SmxXjhyVgmg8kTE8+
	 QQ7xqekehkSHw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 02/10] mm/damon/core: add damon_new_region() debug_sanity check
Date: Sun,  1 Mar 2026 09:43:17 -0800
Message-ID: <20260301174327.76849-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_new_region() is supposed to be called with only valid address
range arguments.  Do the check under DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f1a97e85824ac..0c1353164ec81 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -109,6 +109,17 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	return err;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_new_region(unsigned long start, unsigned long end)
+{
+	WARN_ONCE(start >= end, "start %lu >= end %lu\n", start, end);
+}
+#else
+static void damon_verify_new_region(unsigned long start, unsigned long end)
+{
+}
+#endif
+
 /*
  * Construct a damon_region struct
  *
@@ -118,6 +129,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
 
+	damon_verify_new_region(start, end);
 	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
 	if (!region)
 		return NULL;
-- 
2.47.3
