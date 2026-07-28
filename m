Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091E38F642;
	Tue, 28 Jul 2026 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211980; cv=none; b=HoJi7pbsZKoyJUmkyuMGgL7puz9wY0fBFAYiVVkExLECjwpC04Zpq9QpAY6QMsa03TfpJmqO5UBitaxpmX+cZrjHdKiJUc2ab+K8wJkNKQZ0r/bVqVs+azRNObygbZCUjAR/6TxMXVjPZiXmxrS1eWfYpuC/PBMQbFMqI4AELI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211980; c=relaxed/simple;
	bh=Pffw0QddcOdszpO6Pf+uRui7oVwqUV9y0L1CM1LEgZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAZoEFwyAkgLOW8O48pa1/dox57ep6rmbk0uDxMizpNj3R+47seXf6v9vhV6H9Vgej6dG8v3xYl1vhEqMeZ2XiRtuP/oZyJ11hUzRw+0BVg7jUs7SSLr/MinKUYAL7akSbcjTmXB+bHdY+RydZlahXuiPqwtToc0Sqt16T9zdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVsc48ZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVsc48ZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705F01F00A3E;
	Tue, 28 Jul 2026 04:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211978;
	bh=Zxj0qXZlLFjv8Oo1ubEI7gb1ZBWWHlkx56zIdj50cXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bVsc48ZMsvgyiWMHlS61ZpD4dNmpJRBDNPgwVvto//guZxfLhO+F8al8yu0jjFz4X
	 iDvOZwIWESzX8fm05Cm676tXJVryNFIQ1DaXKw5Z2JSUMrHgKmWrt2W6L595mPeOmr
	 /mrnbLBxTtfsCPJpamBZYR73gybiemFKOL96URlxN9/63L912MTZH2XSUMFj/JS8nG
	 4tDpSKQJtOoVNAmm13QD9kKJSuAiBzViz4XoCpKel3zeF8DMP8ZzIRzHX9Wy2E4qfS
	 h17jbIf+t6lMyg4SkEE9P5zd+ZoEMAqdeHYnZBAuEf0TlCecn56RFIIylWhj5iPyqg
	 V43wSVl6sFjjw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Mon, 27 Jul 2026 21:12:38 -0700
Message-ID: <20260728041242.187380-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMON probe prep sysfs
files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e675a57145e36..f8d2601e82904 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -173,6 +173,19 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		per-probe attribute weight.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/nr_preps
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probing preparation action named '0'
+		to 'N-1' under the preps/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/<R>/prep_action
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the probing
+		preparation action.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
