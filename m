Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1F4307AE;
	Thu,  9 Jul 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605973; cv=none; b=GoLOVIBu7o/nrhDaK7JhM0NmBgms/DoSXrv3laYeDGrnlUkMM6lCpNTIweMHVEF+fXSgufiaotHcFP9RcTT6tKGpfpqri7Yegy+kcr3AQ+ZaUsPU2qqGK6BvviCdVsuXL/4JLMwER5b4eIOnM927rFyJ/aZtrW4QwbgEHX+mnwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605973; c=relaxed/simple;
	bh=76Ms7lr2E1n8a9s5BVP9BtK3Clv9+dktfC0KcnJw1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgVX6epwb71ShnI0qqskeqEw4KcIg7jFKKtz/fa2b5owUZG5IavByol17UWBhOMKWjjeLB/+AAxGlOfaaOhSLUtQgps8yFyFPQrBuzyhedUQF0lDxe1MKkh1gWcsRqznOXq5hwgQFhuxz9eepiOQ1ae5qVSC5Yg6OF3J5jc0tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+MvowD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+MvowD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC391F00A3A;
	Thu,  9 Jul 2026 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605972;
	bh=KtGhb2uuQghnzvwRekFMe5vHCrkMdKOrMY5ghfXYhj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n+MvowD5sZPU2yKTHj8RKerbKJrDMh+lcYqF6jmKJLtSEq/jCVrVTbsHOiPTceZnS
	 LLgD5txxChTw2I61p4rIEe98n1XhvX8oAd2Eahx6hNVxYjvUKwDX6gY/BH+pF5pLDj
	 yoWdG/+noYkBHgsfwQbnOgvgd08Y+u86ysPfF4ZgAGDOnnR4XMPHmR6SGHM5JFr0y9
	 EAm6iiQqRIrZnPF5iJBHsp3Ljqhx0nMG2IsStUfv/gSJzboDkFri1IFR89vJMutkOk
	 SwW/143tFx17n2FqyVcqk7OWhKwyvd4N6ARs3BscAIwTDPoNGzPsGLqEqqTtekn3u0
	 IKf9O+fhLmZ3g==
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
Subject: [RFC PATCH v1.2 19/19] Docs/ABI/damon: document probe weight file
Date: Thu,  9 Jul 2026 07:05:57 -0700
Message-ID: <20260709140600.90950-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
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
