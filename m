Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24858423170;
	Tue, 30 Jun 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829061; cv=none; b=Wq+tNOyKo8acoBW7PXaPWcT/f2aqgL2rO2QLzOaixsZUWm5+cyh3PIdFTSCF5ZnUShkg+yBiDPQeQBRnOPLbjFtov/63x+9t96QR44OqVMKT4vgdvYYpZJ+d4ltYUUQLUnVKr1Cws+/Kx2vzJsQHcbX8vX9fEFL5n9VNf642Xos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829061; c=relaxed/simple;
	bh=2nTbbQOne6Xb+T76v6pssLDFidAdicJyXUXJUqWCOaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nN0GkHS6QeSVWj6MXVESD9R9G/A9GC+br+FO56uZmaw3n+k3QjnU1TCWe9DZelCff/otkGVLKfMXr4ne422sEg09iTlSoasxlqFWdDYdP0gTRrQyHU/rs6DrbIXS9B4vz2mXYqfn3Bz9wSOHGTTED54plCLtCjyX2ODzBdvmArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd98KBHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd98KBHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE61F000E9;
	Tue, 30 Jun 2026 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829059;
	bh=tHx9E3z9Lw6thGzocnkJE4de1IIySrzMkwZxkqXO/y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gd98KBHk48qxp7JudoP0SPFiYSlTvZDxu5F+wxNZkGL4OBaSEVwaT1xZhVptYG+79
	 Z9UiylLjRMsI3xmO3IuQvRiqIH1gALaeqNFzaeDhlMOnEmdJ6YYdmw0ATVZcGWD2VG
	 xaW54zvBaSJGYxCy5o6Rw2Atq1v6yJlyU5JdiO74wEWUQjTkYvJ2TMj4jLFKf2eMdK
	 623qM0WyaR1V5nydwVn+G++Z/IPVkaOqFAKl692wr9aamLPkXRD/Gz6efouDNmyqzp
	 D50lmzA7K8NiXYW0tvn5NIQ9dUKJKQkXMP0/ARXNBShRKOvH0biONkaM+ufgeSfL1i
	 kvocPmKfaTQgw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/11] Docs/ABI/damon: document probe files
Date: Tue, 30 Jun 2026 07:17:16 -0700
Message-ID: <20260630141726.92246-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON ABI document is not updated for the DAMON probe sysfs files.
Update.

Signed-off-by: SJ Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4fdec63a47d4a..dd6b5bd76e119 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -157,6 +157,46 @@ Description:	Writing a value to this file sets the maximum number of
 		monitoring regions of the DAMON context as the value.  Reading
 		this file returns the value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/nr_probes
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probe named '0' to 'N-1' under the
+		probes/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probe filter named '0' to 'N-1'
+		under the filters/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/type
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the type of
+		the memory of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/path
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'memcg' is written to the 'type' file, writing to and
+		reading from this file sets and gets the path to the memory
+		cgroup of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/matching
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether the filter is for
+		the memory of the 'type', or all except the 'type'.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/allow
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
+		hitting the probe for the memory that satisfies the 'type' and
+		the 'matching' of the directory.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
