Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCAD1E47C9;
	Mon,  6 Jan 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192069; cv=none; b=ZN2Y45Od5rOeCwb3bzqgy+FLN2sN1ipXzSsbMPbwCtseEdWMEdrtM4yo9Dc7rdsoHMuGDQB+dZcGVAhUcafjEoWS2EhPcj4HZJZrvR6OCp3pBKMMWt1mLkpmnsImq1hSgQCzyUuEiyWkMzKIITydwbGLlUsUpN+ePgJvkug0VmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192069; c=relaxed/simple;
	bh=3O+7JbZj6xxSI8uZRXk/Ms1BG1Ir2OifGM6jxU273yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qikZIHX+FFJaxML5ehobPiWDuIRIw9pO1XniUQ1BWDnD152Qfn2rLDCqUDFfcBmnbYwbTyem+DYe4uNmwPaIe+liWlZDSFJQBpGt4C2ch5LEB/Rn39F98mKKlTgjiQEKdbCs//q9IrQWVumgOTWPu3vRi3vcbvAWREIiS8qGJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZHzEXT0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZHzEXT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7EAC4CEDF;
	Mon,  6 Jan 2025 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192068;
	bh=3O+7JbZj6xxSI8uZRXk/Ms1BG1Ir2OifGM6jxU273yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZHzEXT0/ZCiiBJtIoztxLXOeM5gJiISJG5r6HbQyZrpw/1mVfjWVBtuPg0ERW5kJ
	 0h7DbOBlSt5hqBB4g5tr4gLDyKEftf9mZ9NXCo4Ca+oEwNHrgoiSDm/+DRLUb7tqA1
	 lOgCmypgaOYcSvmrx4t/cyk0zXA3YiNYBUqijWImfhYnvGebhzu8LswTHl2DNPqsQx
	 PVMU3LIIFBul1jXu7clmKpHV8dJ91/1b5MIP5Is8PLMkNovAdI3pmGGIz0Xf7W7CQw
	 0RIHE6StYflDhilR+J4DNRyNW9jFMQD4eq9ZUYCr+Ls9o9bXqxrQYhMBcyDKcSPkUm
	 tXB7fgnNMzRMw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 16/16] Docs/ABI/damon: document per-region DAMOS filter-passed bytes stat file
Date: Mon,  6 Jan 2025 11:34:01 -0800
Message-Id: <20250106193401.109161-17-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new ABI for per-region operations set layer-handled DAMOS
filters passed bytes statistic.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 19cde386fd15..8c0acb31638b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -430,3 +430,10 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the 'age' of a memory region that
 		corresponding DAMON-based Operation Scheme's action has tried
 		to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/sz_filter_passed
+Date:		Dec 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the size of the memory in the region
+		that passed DAMON operations layer-handled filters of the
+		scheme in bytes.
-- 
2.39.5
