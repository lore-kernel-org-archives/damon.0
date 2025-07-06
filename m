Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92D2BE7AC;
	Sun,  6 Jul 2025 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832033; cv=none; b=jD12lFw0rXSDuAv0PpBzaPBCaEdXtF7LV4XiNG89V1ebYdglGJGbCo83eM751QyW6qC9Qvl5xySuX8SfE9DMbC3c6eWwSbmyYyaTK+F0N5D0giNeql+CLgGTQygfVoGimdYFk12Fa1iJ5WUktJ5VEyHVAkkYLZyXrg/7TT6D/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832033; c=relaxed/simple;
	bh=kPaBWHAVnTpt3IhJpZpvKlwnOD5/goIRLdoHL+X/dnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Is9OU4ztptk5cJEd3qGTJ5NQs+mPAb2R2fKeravN65bjbuswNUNNqGXA6OdH45rRuXwxMkJZV+LT5N/gGbNZlP3ekqsBT0sSXnPa6TBz11ENIMwoc7NgqI2CWumVOmKiRgaRVTiKtrH0u4PIUrKvRx2RiMRbEqVJ1sLd/qn2TaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTQV/EBd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTQV/EBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6602BC4CEF4;
	Sun,  6 Jul 2025 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832033;
	bh=kPaBWHAVnTpt3IhJpZpvKlwnOD5/goIRLdoHL+X/dnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTQV/EBdZ+FEb4l50CWDcbREHDhLh/y+oEWykVciIUzsu1JlCNLnsCdRI42AKrSaB
	 5AoQVzIj+ynaCVhdzqLkYtX+rllRieKnOtspV5kiuv3b0xyic544cjrjDDnSlh9ccu
	 yBDGKU6s8nvy4J84g1sMnFKa8hyA9cuLp7zDdceDIlcZJiRGRNlJFyIgEyNa28Te8D
	 aVEWLmBL9VTGimWrb4n3OSPxsTLf1nwdz86LKFZKttgKQlwGGzvOLcALKQpt/WT1Ez
	 iV+5zPllFVf3HIuMpm+9Sqb4RMTrZ1RhAvi31afjOnq9zDudzblqruWEMALbd/dy58
	 vHmTGvQ/ZMP2g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/14] mm/damon/core: do not call ops.cleanup() when destroying targets
Date: Sun,  6 Jul 2025 13:00:12 -0700
Message-Id: <20250706200018.42704-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_operations.cleanup() is documented to be called for kdamond
termination, but also being called for targets destruction, which is
done for any damon_ctx destruction.  Nobody is using the callback for
now, though.  Remove the cleanup() call under the destruction.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7a4dc76dd023..eaa2306ff324 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -550,11 +550,6 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next_t;
 
-	if (ctx->ops.cleanup) {
-		ctx->ops.cleanup(ctx);
-		return;
-	}
-
 	damon_for_each_target_safe(t, next_t, ctx)
 		damon_destroy_target(t);
 }
-- 
2.39.5
