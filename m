Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D283CF962;
	Tue, 15 Sep 2026 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438185; cv=none; b=OvUd9D0mr90LuKhV3rY9qHDZlHTfne5QsEeDX3Cotg1ha84+ClN68eAZQt7KQE2Ho7JoIcNxfiiN7kolU21e0AUkd0Wjt+4Ay1Wh5kxxWj4kgUSidPztavwbZt0ljVbvAjbIIenoPVdxKw5sH+tNgxhfLXku+Dk29AW/LJELyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438185; c=relaxed/simple;
	bh=mdrTtuzWyI8F7lQlAtoXmlw72idaeRcZ7fA3+Z9qesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSLgHOYkBQ+VoQxnd+SfZYwYtaqtiLk++/v3URji8x2Nc955vZw4TrWXzYW/i+AuX08QU0CNMIoOF2GM2c2vgqGWq1uHgh7uSPrTQ15wMU3ZDEU2phgZE4+nQnxLr7SIw2u3d0zad8XmuWBVpNQuiqm/AF4UnFgtZoDwe0X22I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOzKjjAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOzKjjAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F8C1F00898;
	Tue, 15 Sep 2026 02:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438181;
	bh=Pe5PEKflMlDglfugpw4os1GpkWtazCvp49h5WT4n+gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bOzKjjAgjcSgqu76iU01qHfLTFRUV+6aW84VMrBPDKzyiR3TB4VohSgzjUxFcnP/s
	 1pcsfQTOjSs4hOWWoSoiiuUaexRmsoYCLuBPCzB6xBr6NIUiRCWKlAKTcMp8NgqlXb
	 95RM2jItxUu+uuqldZH3qsSfGt3X/tBR5ZGOFQF3GWz/tCBN8WXWE4adyxEV3ysa2B
	 pcpERic9oCyYrDaqoQmxpSJOKKDziBXjFknOYYd/CpPM5Q6nvjGerITGT9LRhQpjeS
	 MtePmEXuSbk2fVVu7IQ1U3KxyJRRZXAntxo5i23UTW+Md8cY+dqST0SOTd7Skb3YjI
	 491kVF/K0zg8Q==
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
Subject: [RFC PATCH v3 8/8] Docs/ABI/damon: update for hugepage_size probe filter
Date: Mon, 14 Sep 2026 19:09:27 -0700
Message-ID: <20260915020929.102953-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915020929.102953-1-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
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
