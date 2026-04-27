Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADA37B019
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301913; cv=none; b=BzKXoeP0fJ2iikRM7f9vvrTA4FPXagDPnyAu+r79TkmqlZ5pZej5aFmSNuEvG6b0RYuw0fcpAUvcO8N1L5qgla2iJqIASpb7CkHXuKdzjAwLFAXi7UiqH/NaclbqXx6Zu30y+TC1fHVnHfiGowmkCsBrm2HwzGF8ggOQHA0EICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301913; c=relaxed/simple;
	bh=Dy6HDY5f7i/fK0l5asW9+Y4z3Dq4AYkK2eqcnRQ1GzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG2JNYTGgZQjFOvc77v3wHdVvBGXfUBna5iEZXnfuXsLc3/aeJuZnu1DXnt3L/PLoVzI+wZSQArjMheeAS1HddIxZogMutX/7FzMtDcWSAMjqi5lBYxaFuOqR5On4dAIwhrz2SdA06eGjqp0d/ObEBmtpKC8w1c7VRKluUbZW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwB+cApx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwB+cApx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7A5C19425;
	Mon, 27 Apr 2026 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301913;
	bh=Dy6HDY5f7i/fK0l5asW9+Y4z3Dq4AYkK2eqcnRQ1GzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwB+cApxCOJB5Y8V+A9hl7/J9YJw/Uii8qzic8q1aOEfyIbSQdJ0orkY+vs7xn2Kd
	 I5bPWcQ7WkoD5jnjwawvUpicpQFXTTJXKJLjH4eS3dkuiZtn8HXoChiJPN/Ztb1yfe
	 OEqQuckyGYRz9HwDFWzwGP1/0Ljc25Up7cUahic0/R5EkIkCSJCiAhcI8pbN4I7YuZ
	 DFhSqEFtdDzXX6MTcHAhDYQoOn+zVMHNxonAlamkXyRiarZ49AzzUYw096H03SbGQC
	 +2Rs1e8sbfV0vGuTFjYUTNynkr6PkDV2gInZ+sP2/i8kly+UteM4VxaZRq+KOqXELj
	 Dj4dJM8HVKuuw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: [PATCH for-sashiko] mm/damon/core: (fixup) break calc_eligible_bytes() loop if addr overflows
Date: Mon, 27 Apr 2026 07:58:30 -0700
Message-ID: <20260427145831.112393-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427145331.112239-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Sashiko pointed out, it could result in infinite loop.  Check the
overflow and break the loop in the case.

Also, wrap the addr setup line to keep the 80 columns limit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
NOTE:
Writing entire patches for minor Sashiko finding is tiresome.  This is an
experimental posting of fixup patch, wishing Sashiko to review this kind of
incremental fixup.
---
 mm/damon/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 22d6eb3a974d4..9a4220174a61a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2349,7 +2349,10 @@ static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
 
 				folio = damon_get_folio(PHYS_PFN(addr));
 				if (!folio) {
-					addr = PAGE_ALIGN_DOWN(addr + PAGE_SIZE);
+					addr = PAGE_ALIGN_DOWN(addr +
+							PAGE_SIZE);
+					if (!addr)
+						break;
 					continue;
 				}
 
-- 
2.47.3


