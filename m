Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52540DB34;
	Sat, 25 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013362; cv=none; b=C14f9RYmiwtc2ajV4lw/i5dFfdg6umszRgIasJH5VcypTNkJweJ6FrSAtz/f2R3EOyEd9dxzysLr3eUUp6xI1jrFwKX8Yq4j0OUrMTwac0cZHsE7WfZpYQBlsF2CrskSu6wSmyy2PXpCTnbieERVNuAH7DQVojNauWxSFcHSRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013362; c=relaxed/simple;
	bh=am+Z8GbyQ/9tBiAA5iLx3VDlJR6R2ym2PAwyn0EJ/Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prBxUebXidW7jRn/kgWnUpFTTizM36wfbe1iUmMePi+2oHCGBNWnO9RMZW396YkgEYGQD4KV0OrpTnahzDmkelVU7I/bl885bcD5omQd/wc75/X50C/ntE8bnUJTwDfDmZjX6qCy+qQDwVElN4GLbBBZ1lrsjEzzvDnrniYRJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgLs+Ifi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgLs+Ifi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7EA1F00A3A;
	Sat, 25 Jul 2026 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013361;
	bh=ZiLHw/ckp8YWqfcdIWygf97czhvsQo25jB80E+mfF5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgLs+Ifiz6wWYeWxpjB7po548NvLQXD3kJId+7ONZJcLW/RqaFrRNz6X0v4Hm3cpC
	 5cZCP66T2Zv1bfCrWF2pk/EuajHi1HbP7Ju/I9kM0j+26OQ9SZSVr3033yOwSVk7pt
	 F4GZUzBnQcLqUPTm1/43f3MxyOifTw9NpG+sTo8tnnkIGMAfmf+4XJVwbq1a1KKdBp
	 lsXKqHvvVp8RaoV8q+9qo4KQ96r8hQyl9sCWWvCyL2r9YJp5Y2Xzn11yTMDXUlF1mU
	 aOzWoGT5WYNySMfKsPq0vLJOPvPAnZarQOt86Y/2kE/30jJn0f43ufEyQDC5NpjEvu
	 Y4psVWowMguuA==
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
Subject: [RFC PATCH 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Sat, 25 Jul 2026 14:02:21 -0700
Message-ID: <20260725210225.129944-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
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
index e9488bb48d23c..786be4537da14 100644
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
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/prep/<R>/action
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the probing
+		preeparation action.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
