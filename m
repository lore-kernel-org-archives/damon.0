Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104543786E;
	Mon,  6 Jul 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347569; cv=none; b=Yv4DsJASNPeilm22UlM44lldgyusaHSiOFXvJ4OecGLo+S3GOH1SXCddex+VcIbHgocmHtCmhISBhS76HDftskaMXBaCn0OOJtIhrAP4CkyXbUrc4INayYWavVhHUZgeKQGT68R6MEvhlB3g/y0kOOhBh++osFrv1MH0xU1E3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347569; c=relaxed/simple;
	bh=76Ms7lr2E1n8a9s5BVP9BtK3Clv9+dktfC0KcnJw1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsKKgTRq0jsmnVFj9JdNAhDuNzvB2YJNee5oHR5yiMoagBW3ov5BPnc9PqTP73kdgdzZ0l8wjHskmseP6rY2sz4btzy/MRh5VYsbf9CY8TJRjzQV6ttq4hpFJT27kTS5yCRYIwIAZaG4jUzXxHQ+tXVnVVt/Igau8PjMdAXTwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZenK5tOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZenK5tOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13441F00A3E;
	Mon,  6 Jul 2026 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347567;
	bh=KtGhb2uuQghnzvwRekFMe5vHCrkMdKOrMY5ghfXYhj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZenK5tOo3Jj9+9DUycgnw187qw/eOsqR06vcERBfy/co0DZh9TIUv2S2siMrfTlJt
	 +x9XfuA6AaM9wsCkcuV8zRtSu07n9aj+8AzgXamMpPP6CtONus6UaKHK0kqVe2MzJz
	 ORVkEHAQBnkQt3CtrnuTFpOA+B8ezZEpHMfWsd/Grwei42sS6++dkqXnb1MKdF1S5D
	 2/WlxY6MWmtpZvXv/3tovtebklCzho6hfSShT4YNVYUdee5PcNLMjrT54zCh+kQYy2
	 pRyyYZAzGvOzHpauGKXtypSxOY2V7VQMaY+G9X0tosDCMPsEgMLk04AG6FEhh8sVO/
	 TOVJTtTBH/hSQ==
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
Subject: [RFC PATCH v1.1 16/16] Docs/ABI/damon: document probe weight file
Date: Mon,  6 Jul 2026 07:19:10 -0700
Message-ID: <20260706141912.88445-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added probe weight sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index dd6b5bd76e119..907a504fb64c5 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -164,6 +164,12 @@ Description:	Writing a number 'N' to this file creates the number of
 		directories for each DAMON probe named '0' to 'N-1' under the
 		probes/ directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/weight
+Date:		Jul 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		per-probe attribute weight.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
