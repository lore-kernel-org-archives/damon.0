Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600619F464;
	Tue, 15 Jul 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605567; cv=none; b=F96/PzFRURY6kS+QLxw6atS89Lp1FvyyztcmJokK9tDJr659Vh728BI9ZOV9R1jMLBY2bJJ4u98Wf2c4DAP9ev7Pv4TsYrn0J7beb4oX0SnPlp+8RZZI9Nz0r0HwuzaAKt9gPHnx2mbv98tN15ozgIP+k8zP8wa1HZy0P4TimkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605567; c=relaxed/simple;
	bh=ek9O5KQqWrmcP2vhmC/Ar3y2lRpriZZ2kU2LNiqAg3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+geVKiS+cLSErsnb5c92qaH1iTTYUucTUfwDKLMTk5GUMrS5vpnD/til9fHQq+nSMEHkOM9nZnCYsPpSmEolJhuBqpeS3hvfpw4vg7RXHpIuowGsv+C3tcQLC3DpJKkmiEO2Kd+/n4OgvDOFO6eJy0Q0mrDHxzEmB1Qp0UDVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1VfDbTK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1VfDbTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B5FC4CEF4;
	Tue, 15 Jul 2025 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605567;
	bh=ek9O5KQqWrmcP2vhmC/Ar3y2lRpriZZ2kU2LNiqAg3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1VfDbTKoCKFfkl2hDhnlUaUqCXpPCfVS8xpbzB0OHvmh7cPhICXBLInyKqFZDjc+
	 +MaPjAWXodU2moGm/jnnZU9xT0E6NP32vfPGKWwWVOCVFdRvJC1YygCdhKYd3O4dyr
	 mWRdBEceBEKjil80oEjVxPDHSJ5rfvrdngu+QJkwE9ZHMIg5taITkrroObY+jQC/nj
	 qYI4IPRpv+aYAJm6pjG9BLLSBGQRlVQjI0gUZvSjTga4Mdo/tWtgLjrfcK75R0hVus
	 ymtRwVFg3M5mQJNGHwJ/8+sVAmUExNUfF+pOPpIwMXB4fIrXBFInQ/fBsEVCIi0pSw
	 0+xJ8LkUfLwwg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH mm-unstable 1/2] mm/damon: add kernel-doc comment for damon_operations->cleanup_target
Date: Tue, 15 Jul 2025 11:52:38 -0700
Message-Id: <20250715185239.89152-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715185239.89152-1-sj@kernel.org>
References: <20250715185239.89152-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 769bd386e490 ("mm/damon/core: add cleanup_target() ops callback")
on mm-unstable added cleanup_target field to damon_operations, but
forgot adding the kernel-doc description.  This causes a build warning.
Fix it by adding the description.

Fixes: 769bd386e490 ("mm/damon/core: add cleanup_target() ops callback") # mm-unstable
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/20250715185549.264260b8@canb.auug.org.au
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 34fc5407f98e..efabc3ba52ee 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -576,6 +576,7 @@ enum damon_ops_id {
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
+ * @cleanup_target:		Clean up each target before deallocation.
  * @cleanup:			Clean up the context.
  *
  * DAMON can be extended for various address spaces and usages.  For this,
-- 
2.39.5
