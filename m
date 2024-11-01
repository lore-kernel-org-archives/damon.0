Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3261BF24;
	Fri,  1 Nov 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493367; cv=none; b=bO0Hw0S8uwmE7WnOlZ6uDSOhUvnWzrRkgQCgy+RcZbwUaqASvtq6Hp9qpi46WSI+AZCru7z3LzAGD19+vDxu8rB53dtqU7WN4Ofd9dBD9Ug1Xyw3XUJDMOqaTP8YvKiPvWNPkTiC0unQYnkVjbDYpJN7mPgT8Ioxh1MWWkx1R3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493367; c=relaxed/simple;
	bh=5eCO9XS/xoBgNMLEP9m5A4VZhTdwofU1+RzbBV9rDzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oWBoQLRGv0oSJFk6kZY+WUJo0OkBZEC9auUlAWpKWNhLFgnHci1OikRIYY7JoooId4gKnmoDPs5Hf2PPMBZZvypI1CtPWd2JJmsgSbgCKZIh3jctnBwXwWbgWp72Cwvouitpun/MkxoMAgChikOBCztgV8GIa+mAIPpjVsuN0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB4rVme4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB4rVme4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D6C4CECD;
	Fri,  1 Nov 2024 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730493366;
	bh=5eCO9XS/xoBgNMLEP9m5A4VZhTdwofU1+RzbBV9rDzU=;
	h=From:To:Cc:Subject:Date:From;
	b=mB4rVme4NVIzqUX0zc5vgayzuN2RoAVbIDHFRDCwMTk4zcBbIljZkcUUd99IcfBtA
	 bsJJaJfUIDoLDTH6O6UnF90q/a2MQ+3cbock2WUcX70D5ilui4iED7N7tV8mFu012X
	 0JXKUVjdIH4Mas2HzfedPnNXnMAFjWbzMzLOnJ+kxlH0LP+6ct8NMw23jm9aywAvZb
	 ojXUzTGBxmpWE9sxvEhiAgdlNan2C+OA1mwZNkiZ8bM35eTVGvOvvJZ0nsI1euV6Bp
	 4fnwHD9I6SiTNpbJUuLEAxqDYk8nmsb96as8D4FxAYkeODDHVM/VhmPypDYTHIlayB
	 7z/Y1ZBJfSAUQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] Docs/mm/damon: recommend academic papers to read and/or cite
Date: Fri,  1 Nov 2024 13:35:57 -0700
Message-Id: <20241101203557.55210-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel documentation is the most up-to-date and recommended resource for
DAMON.  It doesn't cover non-kernel part of the entire project[1],
though.  Also it is not optimum for formal long-term citations.
Depending on cases, DAMON academic papers[2,3] could be better to be
read and cited.  However, there is no clear guidance for those.  Add a
paragraph for DAMON academic papers on the kernel documentation for
DAMON.

[1] https://damonitor.github.io
[2] https://dl.acm.org/doi/abs/10.1145/3366626.3368125
[3] https://dl.acm.org/doi/abs/10.1145/3502181.353146

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/index.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index dafd6d028924..5a3359704cce 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -37,3 +37,9 @@ with no code but simple configurations.
 
 To utilize and control DAMON from the user-space, please refer to the
 administration :doc:`guide </admin-guide/mm/damon/index>`.
+
+If you prefer academic papers for reading and citations, please use the papers
+from `HPDC'22 <https://dl.acm.org/doi/abs/10.1145/3502181.3531466>`_ and
+`Middleware19 Industry <https://dl.acm.org/doi/abs/10.1145/3366626.3368125>`_ .
+Note that those cover DAMON implementations in Linux v5.16 and v5.15,
+respectively.
-- 
2.39.5

