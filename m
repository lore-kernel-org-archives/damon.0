Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D791818;
	Wed, 13 Dec 2023 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmocNWl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EBAC433C9;
	Wed, 13 Dec 2023 19:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702494235;
	bh=kQlCzt4zp30gEmZhugHeoZj6PZuokXzF1ZrH8vPgcLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmocNWl3Jdc8Dqs1hBubEL4b1RStm9nRj5Jc2Rli1sDWRw7vuP4QcTV6z46jKUSqC
	 PthmZ9WuzR3CbA9bZpzGCeRTfCbZwSNr1Plrlqvrz98vJiLjZ8LWKhUzXpYLrkRidG
	 FviqdxoXZhJhX4hOQNnGgUXBqfppAvzUTy3lwoT0Cl2+v17BHIWFeLyZ9IIoxShOmI
	 Yhem41ybWkVGEKSAmTaYfcsCYXKU6DEklVlGKg5MABzCEaBqfIH9kPymXnu2UAeAs5
	 Ec8qOrOwG2hnE69hrDDgp8ETY6MQgORm/i6Bkl9B4OtZXYhYgxKev6q87rVzLlB4Mu
	 lfdW8oBINHfEw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] Docs/admin-guide/mm/damon/usage: use a list for 'state' sysfs file input commands
Date: Wed, 13 Dec 2023 19:03:38 +0000
Message-Id: <20231213190338.54146-7-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190338.54146-1-sj@kernel.org>
References: <20231213190338.54146-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are eight command inputs for 'state' DAMON sysfs file, and those
are verbosely explained in multiple paragraphs.  It is not easy to find
explanation of specific command, and getting whole picture of supported
commands.  Replace the paragraphs with a list.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 47 ++++++++++----------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 671d3e50b998..9d23144bf985 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -130,30 +130,29 @@ In each kdamond directory, two files (``state`` and ``pid``) and one directory
 (``contexts``) exist.
 
 Reading ``state`` returns ``on`` if the kdamond is currently running, or
-``off`` if it is not running.  Writing ``on`` or ``off`` makes the kdamond be
-in the state.
-
-Writing ``commit`` to the ``state`` file makes kdamond reads the
-user inputs in the sysfs files except ``state`` file again.  Writing
-``commit_schemes_quota_goals`` to the ``state`` file makes kdamond reads the
-DAMON-based operation schemes' :ref:`quota goals <sysfs_schemes_quota_goals>`
-of the kdamond.
-
-Writing ``update_schemes_stats`` to ``state`` file updates the
-contents of stats files for each DAMON-based operation scheme of the kdamond.
-For details of the stats, please refer to :ref:`stats section
-<sysfs_schemes_stats>`.
-
-Writing ``update_schemes_tried_regions`` to ``state`` file updates the
-DAMON-based operation scheme action tried regions directory for each
-DAMON-based operation scheme of the kdamond.  Writing
-``update_schemes_tried_bytes`` to ``state`` file updates only
-``.../tried_regions/total_bytes`` files.  Writing
-``clear_schemes_tried_regions`` to ``state`` file clears the DAMON-based
-operating scheme action tried regions directory for each DAMON-based operation
-scheme of the kdamond.  For details of the DAMON-based operation scheme action
-tried regions directory, please refer to :ref:`tried_regions section
-<sysfs_schemes_tried_regions>`.
+``off`` if it is not running.
+
+Users can write below commands for the kdamond to the ``state`` file.
+
+- ``on``: Start running.
+- ``off``: Stop running.
+- ``commit``: Read the user inputs in the sysfs files except ``state`` file
+  again.
+- ``commit_schemes_quota_goals``: Read the DAMON-based operation schemes'
+  :ref:`quota goals <sysfs_schemes_quota_goals>`.
+- ``update_schemes_stats``: Update the contents of stats files for each
+  DAMON-based operation scheme of the kdamond.  For details of the stats,
+  please refer to :ref:`stats section <sysfs_schemes_stats>`.
+- ``update_schemes_tried_regions``: Update the DAMON-based operation scheme
+  action tried regions directory for each DAMON-based operation scheme of the
+  kdamond.  For details of the DAMON-based operation scheme action tried
+  regions directory, please refer to
+  :ref:`tried_regions section <sysfs_schemes_tried_regions>`.
+- ``update_schemes_tried_bytes``: Update only ``.../tried_regions/total_bytes``
+  files.
+- ``clear_schemes_tried_regions``: Clear the DAMON-based operating scheme
+  action tried regions directory for each DAMON-based operation scheme of the
+  kdamond.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
-- 
2.34.1

