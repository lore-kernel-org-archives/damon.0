Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824046C4D0;
	Mon, 14 Sep 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397104; cv=none; b=fzPz5PaByNdprpNIrcnrJQ6u97d2TMQIGr3B2kzDQbHilO356Y63YrvcwlCo9+hxH8cOrnb/MbKL2QNkgmJe0YaFROKbyMM2zK55J6lColdSPN3HHeck8cylG/8alXmkXSCdEr7OYEobc1TBKHGqBAjuwMhjpQ5RstdbOCGmhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397104; c=relaxed/simple;
	bh=mdrTtuzWyI8F7lQlAtoXmlw72idaeRcZ7fA3+Z9qesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVdmu5XTng5a3ijR9Ov8EvpP6qdBT09WZ+kcWh6xh2bZ4D8baoav5vpHeO7XwIPH4xxvwOx12m1PwZ/h1Wl77UXKrJ0d9juWqJA30hu32oOv0ZMyQgAAHGRUCyj8br2iGEhWEz11Oq2PQBKTV4dqpnuUgCxpVuO1NzvIhtRNEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDWJPo6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDWJPo6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A2C1F000FF;
	Mon, 14 Sep 2026 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397099;
	bh=Pe5PEKflMlDglfugpw4os1GpkWtazCvp49h5WT4n+gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDWJPo6CioTXC0L1xlPNk0vVexQrbXgzSvuSlsaet6SV0LsY8ktyIn0l7ijI24HpZ
	 0oKlGzJXMdhBqZlZL2zGfFdPn+A9D3PZMqH0DEC0OVuhe8yPIrMQuJ3U79BZbzeLG3
	 w+idBuTZTD4NKvStaRs8O4eFliDKlNrtpZT9YHYqMAvFkrP4Z8kwyCI2gab8/m5n0L
	 l9oS/cYSP4eZRqo8aTOzcyXc1x0DFpwIZ7D80fArIsJhHZgkdYO6LJolsYo0LeBWbK
	 GH5I3ZTyy9mOCG5pcv0+uLo+ThQ7A2FrvstGz6y3hIJXDT6c3Fof4ivhbfqBDRPLPE
	 9SD3UgnHcTWJA==
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
Subject: [RFC PATCH v2 8/8] Docs/ABI/damon: update for hugepage_size probe filter
Date: Mon, 14 Sep 2026 07:44:45 -0700
Message-ID: <20260914144448.93732-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914144448.93732-1-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the newly added hugepage_size data attribute probe filter, two new
sysfs files are added for the size range.  Update DAMON ABI document for
the new files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index ad21f58f3c912..55df688ea596f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -206,6 +206,20 @@ Description:	If 'memcg' is written to the 'type' file, writing to and
 		reading from this file sets and gets the path to the memory
 		cgroup of the interest.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/min
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to and
+		reading from this file sets and gets the minimum size of the
+		huge page of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/max
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to and
+		reading from this file sets and gets the maximum size of the
+		huge page of the interest.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/matching
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
