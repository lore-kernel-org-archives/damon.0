Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119A31A800;
	Mon,  8 Dec 2025 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175445; cv=none; b=KDzDtgJihZPwdUWjcq7uByZs5CGBuCAhlZ2iCe9jxd3PH1PXzJD1wzxf+kkfiFYoH8VBYu25WIQkL5oFF//npQvuXpSOv+30Kci6Fh1ACv1tl28c9WnOh9YXDae2QLDepK3FUSyOUtqVf0w1oWC910uEqWadJA4sxmCGIbHHwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175445; c=relaxed/simple;
	bh=my96BzscRoG5OJJ+4DXHi+6nxWHst+CeituNuj8uGfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0hqYaIYDcmiTy2IPHIejpBgW+zPRs6vCx3rzs742M8SQBLljLlPFhq0CES9kyXK3e66gptdyPRmmbOinkWU/UpMwXbhbMUJXDzubwkXMkr6PhCpEM32OYhA8cmeAK+C0GZWFDM1qhgzitW22H7li+3+KrUg0njc3XUSObzMUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQEDMWUt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQEDMWUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB2EC4CEF1;
	Mon,  8 Dec 2025 06:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175445;
	bh=my96BzscRoG5OJJ+4DXHi+6nxWHst+CeituNuj8uGfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQEDMWUtVie4xcVROv00P1YKbtb+Gi24FUrk16/pvmtqaujQM4CTfk82pEL27xTj/
	 uQ4+24tBDGsoDWrertUrcW8EZmtJe4fcI5VaPxtiddAQKYIdsudknTIltccKXv/152
	 pasQqgRDZHC5BySXsw2btEm9VljjOGwpVzsgnvZPt92Q4rbWFEU5UfeSh55+6Fxxi0
	 d25dNjG+x4kKnRi/Zluf6E/Li0Q9b7/k0bOrYf35FnMYwRYC1+/0y2X4LJ6SXvg9PY
	 /qNQDlDe9+rariOO1/7b/IB6MeSd38iCF7gtJrnZ+oVprVdY3uv6xqVHhcX4zhjjmz
	 z7QJwjjugrOAg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 36/37] mm/damon/sysfs: support write-type access sample filter
Date: Sun,  7 Dec 2025 22:29:40 -0800
Message-ID: <20251208062943.68824-37-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users utilizing the write/read-only access sample results
filtering, by adding a new supported input for specifying the filter is
for that purpose.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b96df2d2d17e..d6f6a012a0e2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -782,6 +782,10 @@ damon_sysfs_sample_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_THREADS,
 		.name = "threads",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_WRITE,
+		.name = "write",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
