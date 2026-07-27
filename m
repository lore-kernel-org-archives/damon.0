Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFE40D59E;
	Mon, 27 Jul 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163120; cv=none; b=D8T6jh7Wxv0gcODEZdD2cm0J2e0m+cAloiU0MEUKywIyNr1VdaqsnnL+f0KJmX4zYeRB/4VUNfySbUZP6R2tZOH7kKa/aXB05eWDUNIKL3LqXpNUXrJ+4NzfEporTB0AJcyhvb4Z3yOBzyi/NdyHZH1qKtp7TtC08tsMM7WwrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163120; c=relaxed/simple;
	bh=/QpYvjXipXkD4LX2Y8VW1xMCeBMy9VwZWtSw2XWTVPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJIJVNG1baFp13ssEQ1u9ICFLT/q4Ui/VvDiWc6Dxc4C/x9UhYDOj0A86c8hAfy0rcPY32tSsgH83tKyullcTwBoeKAFla9YvOhr4wsaG5O3axws37QHdZiIUBOkc+ln4cGtSq4xQUuTHINtfOpfjbWFMOY3ydV5WgbEmnkZiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzdgySYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzdgySYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31641F00A3D;
	Mon, 27 Jul 2026 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163119;
	bh=k2KXxbbyQsDqyIakOwtopypnxAXb0Pug7Y/5FEepxqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzdgySYaHUsyr0xJ7hy8712JRZiXArYqqSB8A470yIj2jZM/LDGF78PVA2VSb3AhP
	 xf1El0i5bE10pEAC82PKRAtJjtiwjyUhMBgM6rKlxsnN+t5nEfO4NPpeUX9nzcvJ6m
	 iTuiiCVhF8pcw/Epv+sbD6a6IVDXpPPqwPh4/qo/Wsgf6vHC3SOna/48A0ysm0Z4Uw
	 XSwdYfcglBAJVD9LH9eXchJ9RmhVwuPJI5dSyOvI/Hqs78F6QIqlgNJpRHhwH3SN9G
	 XfVcuyNltNWO8PnLSD98XThJIe/kZP6wBkOeh6DrAwEAW9hnslbsRjOvaKdTsBQPXs
	 kprdDPblUvgsw==
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
Subject: [RFC PATCH v2.1 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Mon, 27 Jul 2026 07:38:26 -0700
Message-ID: <20260727143829.86236-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
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
index e9488bb48d23c..ad21f58f3c912 100644
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
