Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B421A94B
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65048C433EF;
	Tue, 10 Jan 2023 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377447;
	bh=/ftDYRYihjGl5PEz5Dv1FCnL2ESZwAkvBGHkxClfATA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWdbcT4V6ti0Ll/sRjROvWkvtNQCTLv7+0IA+XG0QqOdhMMLgUnm9HgZ6MnDDqEOl
	 dngadbkAJrq2Vcj6erIyqDlcg0E31UlwF/+Id7rxgO3NvcGdeYMCONmYVP+oAiH7x4
	 TO1md/05eBEiK10d48YhUKg5Gx6E2K0Y9B6FaQ2yhy4EBLYZVq1+ecmxQqpzpN3X/B
	 AH9Ox0o/TVtIAvmzC8VLqBZ6zpmGCH3dWfk+S1l4i//UegMvXlBHbyTu5F5LbItnIS
	 XrTV3fqkCIvSfQUTlspFp8isWnSa3kugYmoPy5NFx4NNsWlxZaI+EA28ngOGYVYwZ/
	 v7ZC9g9RiHveA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] Docs/mm/damon: add a maintainer-profile for DAMON
Date: Tue, 10 Jan 2023 19:03:57 +0000
Message-Id: <20230110190400.119388-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the basic policies and expectations for DAMON development.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/index.rst              |  1 +
 Documentation/mm/damon/maintainer-profile.rst | 62 +++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/mm/damon/maintainer-profile.rst

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 2983699c12ea..5e0a50583500 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -32,3 +32,4 @@ operations with no code but simple configurations.
    faq
    design
    api
+   maintainer-profile
diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
new file mode 100644
index 000000000000..24a202f03de8
--- /dev/null
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+DAMON Maintainer Entry Profile
+==============================
+
+The DAMON subsystem covers the files that listed in 'DATA ACCESS MONITOR'
+section of 'MAINTAINERS' file.
+
+The mailing lists for the subsystem are damon@lists.linux.dev and
+linux-mm@kvack.org.  Patches should be made against the mm-unstable tree [1]_
+whenever possible and posted to the mailing lists.
+
+SCM Trees
+---------
+
+There are multiple Linux trees for DAMON development.  Patches under
+development or testing are queued in damon/next [2]_ by the DAMON maintainer.
+Suffieicntly reviewed patches will be queued in mm-unstable [1]_ by the memory
+management subsystem maintainer.  After more sufficient tests, the patches will
+be queued in mm-stable [3]_ , and finally pull-requested to the mainline by the
+memory management subsystem maintainer.
+
+Note again the patches for review should be made against the mm-unstable
+tree[1] whenever possible.  damon/next is only for preview of others' works in
+progress.
+
+Submit checklist addendum
+-------------------------
+
+When making DAMON changes, you should do below.
+
+- Build changes related outputs including kernel and documents.
+- Ensure the builds introduce no new errors or warnings.
+- Run and ensure no new failures for DAMON selftests [4]_ and kunittests [5]_ .
+
+Further doing below and putting the results will be helpful.
+
+- Run damon-tests/corr [6]_ for normal changes.
+- Run damon-tests/perf [7]_ for performance changes.
+
+Key cycle dates
+---------------
+
+Patches can be sent anytime.  Key cycle dates of the mm-unstable[1] and
+mm-stable[3] trees depend on the memory management subsystem maintainer.
+
+Review cadence
+--------------
+
+The DAMON maintainer does the work on the usual work hour (09:00 to 17:00,
+Mon-Fri) in PST.  The response to patches will occasionally be slow.  Do not
+hesitate to send a ping if you have not heard back within a week of sending a
+patch.
+
+
+.. [1] https://git.kernel.org/akpm/mm/h/mm-unstable
+.. [2] https://git.kernel.org/sj/h/damon/next
+.. [3] https://git.kernel.org/akpm/mm/h/mm-stable
+.. [4] https://github.com/awslabs/damon-tests/blob/master/corr/run.sh#L49
+.. [5] https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh
+.. [6] https://github.com/awslabs/damon-tests/tree/master/corr
+.. [7] https://github.com/awslabs/damon-tests/tree/master/perf
-- 
2.25.1

