Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CF22F74B;
	Sun, 27 Jul 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647501; cv=none; b=sJDokf59H8GVTy7oHQVz7nNTJX9yGWc9alLvT3B/dPmrN1P+vSsYKx7LpapVkrEVq4spZOISsYnI/1V9A6qcxUnTe3f4a0UxS8l2dRB0sKfQ2mDitzElvtMLaUmSnKM30w+mH/BAlz9GknllILlcYDJFt8qzhbGV+YtzhoifWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647501; c=relaxed/simple;
	bh=NkOlFUXA+qPHhiPIn4M4gJxZzGyprOZBn0h+Dwp+Qx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAEmjvFwbtSkPYhHUYH5hzCDnsr/J4i/6fvYcYjbAktsdIEuM4YgSzu9TfcXlemZj3wwN9z7Ji6Mt7/XD/Kmg2cMEsmqUD0AlQ6vNZHhrP5W8UXs3RLmDtGtvbWwNOieyIg0Xf+pjzssL7TJCyZ7W+uqY6+y2njv8hgHAxz9uW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4IztOny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4IztOny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4808DC4CEEF;
	Sun, 27 Jul 2025 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647501;
	bh=NkOlFUXA+qPHhiPIn4M4gJxZzGyprOZBn0h+Dwp+Qx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4IztOny+fn1C3EUh1pj9ARTeeD8TOf9NgKIVCaojvSByCCvki3xxfOrbkuouJxzl
	 XHorGjFUUMs/o71G7GUlAEm2M1DAVPpg47dNVSiMLBvoZNU/5D1aBZtxVxILIm30kB
	 5mAThhUy+RjFprJ7rcR3XH/j2lUKwiNc9Fvn3mxf2Qi0uRLk5qpUtTW9Bam32otJ0r
	 eqG2XxZNmvzLwnGxKLy0duXGxLU3zCk2EGkMjsb/kZwT3r9lHeKNC4Ezv/pYILS/2s
	 rtdicMP3GtNeB02eOtUwNVKWbe2oh8Zubeuv7GaB57bD2fiUPqysv2doZ8UZlkcVfs
	 k5A1f6ES8eVlQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 3/7] mm/damon/vaddr: implement eligible_report()
Date: Sun, 27 Jul 2025 13:18:09 -0700
Message-Id: <20250727201813.53858-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
References: <20250727201813.53858-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement eligible_report() operation for vaddr operation set.  It
checks the eligibility of the report based on the pid of the report and
the current monitoring target.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..a80cd34e5232 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -792,6 +792,12 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	return 0;
 }
 
+static bool damon_va_eligible_report(struct damon_access_report *report,
+		struct damon_target *t)
+{
+	return report->pid == t->pid;
+}
+
 /*
  * Functions for the target validity check and cleanup
  */
@@ -954,6 +960,7 @@ static int __init damon_va_initcall(void)
 		.update = damon_va_update,
 		.prepare_access_checks = damon_va_prepare_access_checks,
 		.check_accesses = damon_va_check_accesses,
+		.eligible_report = damon_va_eligible_report,
 		.target_valid = damon_va_target_valid,
 		.cleanup_target = damon_va_cleanup_target,
 		.cleanup = NULL,
-- 
2.39.5
