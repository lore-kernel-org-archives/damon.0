Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE427281E;
	Tue, 16 Sep 2025 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993032; cv=none; b=pm2RZxZz0DYUfmKmQ7D9pXp2tK88T6dBpnInShm5l2xNfgJWEgh5tZERr8sSbiS9wRNdRI9kjL1EOC9rxxF1KamfslOh+tWl5bxRBfX3r13KsmrQcXHjI6eIVKPv0UPf18znia0TSOP3z5RAqfjRVV7keVDzTIQwfa1TupfHi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993032; c=relaxed/simple;
	bh=tG/+3LKYF2FSnLVHXLho3ONEf7Ek8I7B7tVYfXji6YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmYuSZBuc6yDTHTLkp1rgnIqV6xk4IG02zN//Hs9DHLtJXx8EjAHkfB52ftgsx/G2u4OnN9fnKuFcGL6ggRMdDYD1P9jVgGScUfMSskmuuz543rnGmDrB58GUfpZtfZx0G2x6OTnGRIsgeT4egpNRE9iRphT++3Im8w9nV3o8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfjKY/Kx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfjKY/Kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F29CC4CEF9;
	Tue, 16 Sep 2025 03:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993032;
	bh=tG/+3LKYF2FSnLVHXLho3ONEf7Ek8I7B7tVYfXji6YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfjKY/Kx8ktevyHtWSRTdz9zmLnjn4C74c7FvIXgziK4QPt9nDiqQZuKa9pxtu33x
	 nx50QAGy9yUb6skEIzlrFBhhA5wLHfgqwfbuAopVNFZzH2nXxCkSfA8ASl4Mrn1UqZ
	 ZeZ5/5adpyKPTfgLrF+ehrSawMINbTxLJ5sdnaguqPdAcjb30M9vFPjOWMcRriQlbv
	 /dyeU47MmK3n0XKcpBH8EE8C+egeSaSNKEajbdtBiYPCy4elXfvJZQLc82opUu0j4V
	 Crqsrwp8cQH/1gTYlPXZLyIMe/WG6txghRkiVFl0sZb9Ywz7ctTaEUwhEU6R39jSOv
	 y/29l+ReygZQA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 5/5] MAINTAINERS: rename DAMON section
Date: Mon, 15 Sep 2025 20:23:39 -0700
Message-Id: <20250916032339.115817-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916032339.115817-1-sj@kernel.org>
References: <20250916032339.115817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON section name is 'DATA ACCESS MONITOR', which implies it is only
for data access monitoring.  But DAMON is now evolved for not only
access monitoring but also access-aware system operations (DAMOS).
Rename the section to simply DAMON.  It might make it difficult to
understand what it does at a glance, but at least not spreading more
confusion.  Readers can further refer to the documentation to better
understand what really DAMON does.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c8bbf70a3c7..ca8e3d18eedd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6738,7 +6738,7 @@ S:	Maintained
 W:	https://docs.dasharo.com/
 F:	drivers/platform/x86/dasharo-acpi.c
 
-DATA ACCESS MONITOR
+DAMON
 M:	SeongJae Park <sj@kernel.org>
 L:	damon@lists.linux.dev
 L:	linux-mm@kvack.org
-- 
2.39.5
